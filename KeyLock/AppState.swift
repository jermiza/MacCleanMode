import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var isCleaningModeActive = false
    @Published var escPresses: [Date] = []
    @Published var hasAccessibilityAccess = false
    
    private var blocker: InputBlocker?
    private var overlayWindows: [OverlayWindow] = []
    
    init() {
        checkAccessibilityAccess()
    }
    
    /// Checks if accessibility permissions are granted for event tapping
    func checkAccessibilityAccess() {
        // Dispatch to main thread to safely update UI state
        DispatchQueue.main.async {
            self.hasAccessibilityAccess = AXIsProcessTrusted()
        }
    }
    
    /// Prompts the macOS system to request accessibility permissions
    func requestAccessibilityAccess() {
        let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary
        _ = AXIsProcessTrustedWithOptions(options)
        
        // Check state again immediately, though the user must enable it in Settings
        checkAccessibilityAccess()
    }
    
    /// Toggles the keyboard & mouse lock status
    func toggleCleaningMode() {
        if isCleaningModeActive {
            stopCleaningMode()
        } else {
            startCleaningMode()
        }
    }
    
    /// Starts the cleaning mode by locking input and showing the overlay
    func startCleaningMode() {
        // Double check accessibility access before activating event tap
        checkAccessibilityAccess()
        
        guard AXIsProcessTrusted() else {
            requestAccessibilityAccess()
            return
        }
        
        isCleaningModeActive = true
        escPresses = []
        
        // Hide mouse cursor for cleaner visuals while cleaning
        NSCursor.hide()
        
        // Open overlay windows across all screens
        showOverlayWindows()
        
        // Instantiate and activate the low-level input blocker tap
        blocker = InputBlocker(appState: self)
        blocker?.start()
    }
    
    /// Stops the cleaning mode, restoring input and cursor control
    func stopCleaningMode() {
        guard isCleaningModeActive else { return }
        
        isCleaningModeActive = false
        escPresses = []
        
        // Tear down the event tap first to immediately restore input
        blocker?.stop()
        blocker = nil
        
        // Dismiss and release overlay windows
        closeOverlayWindows()
        
        // Restore mouse cursor visibility
        NSCursor.unhide()
    }
    
    /// Records Escape key presses and verifies if we need to unlock
    func recordEscPress() {
        let now = Date()
        escPresses.append(now)
        
        // Retain only presses within the last 2 seconds
        escPresses = escPresses.filter { now.timeIntervalSince($0) <= 2.0 }
        
        // Trigger unlocking if Escape is pressed 5 times within 2 seconds
        if escPresses.count >= 5 {
            stopCleaningMode()
        }
    }
    
    private func showOverlayWindows() {
        closeOverlayWindows()
        
        // Display a fullscreen overlay on every active monitor
        for screen in NSScreen.screens {
            let hostingView = NSHostingView(rootView: OverlayView(appState: self))
            let window = OverlayWindow(contentView: hostingView, screen: screen)
            
            // Display above other applications, dock, and menu bar
            window.makeKeyAndOrderFront(nil)
            overlayWindows.append(window)
        }
    }
    
    private func closeOverlayWindows() {
        for window in overlayWindows {
            window.orderOut(nil)
            window.close()
        }
        overlayWindows.removeAll()
    }
}
