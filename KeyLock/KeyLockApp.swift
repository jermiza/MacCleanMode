import SwiftUI

@main
struct KeyLockApp: App {
    // Keep the application running in the menu bar and hold onto the AppState.
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        MenuBarExtra {
            if !appState.hasAccessibilityAccess {
                Button(action: {
                    appState.requestAccessibilityAccess()
                }) {
                    Text("⚠️ Grant Accessibility Permission")
                }
                
                Divider()
            } else {
                Button(action: {
                    appState.toggleCleaningMode()
                }) {
                    if appState.isCleaningModeActive {
                        Text("🔒 Stop Cleaning Mode")
                    } else {
                        Text("✨ Start Cleaning Mode")
                    }
                }
                
                Divider()
            }
            
            Button(action: {
                appState.checkAccessibilityAccess()
            }) {
                Text("🔄 Refresh Accessibility Status")
            }
            
            Divider()
            
            Button("Quit KeyLock") {
                appState.stopCleaningMode()
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q", modifiers: .command)
        } label: {
            Image(systemName: appState.isCleaningModeActive ? "lock.keyboard" : "keyboard")
        }
    }
}
