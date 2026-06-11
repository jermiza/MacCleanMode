import Cocoa

class OverlayWindow: NSWindow {
    init(contentView: NSView, screen: NSScreen) {
        super.init(
            contentRect: screen.frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        
        self.contentView = contentView
        
        // Position window above all standard windows, the Dock, and the Menu Bar
        self.level = .screenSaver
        
        // Visual window settings: near opaque black to help reveal display dust
        self.backgroundColor = NSColor.black.withAlphaComponent(0.96)
        self.isOpaque = false
        self.hasShadow = false
        
        // Ensure the window intercepts mouse clicks so they don't leak through
        self.ignoresMouseEvents = false
        
        // Behavior when spaces are switched: remain visible across all Spaces/Desktops
        self.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        self.hidesOnDeactivate = false
    }
    
    // Allow the window to receive focus if needed
    override var canBecomeKey: Bool {
        return true
    }
    
    override var canBecomeMain: Bool {
        return true
    }
}
