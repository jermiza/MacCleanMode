import Cocoa

class InputBlocker {
    private weak var appState: AppState?
    private var eventTap: CFMachPort?
    private var runLoopSource: CFRunLoopSource?
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    /// Establishes the CGEventTap to capture and suppress inputs
    func start() {
        var mask: UInt64 = 0
        mask |= (1 << CGEventType.keyDown.rawValue)
        mask |= (1 << CGEventType.keyUp.rawValue)
        mask |= (1 << CGEventType.flagsChanged.rawValue)
        mask |= (1 << CGEventType.leftMouseDown.rawValue)
        mask |= (1 << CGEventType.leftMouseUp.rawValue)
        mask |= (1 << CGEventType.rightMouseDown.rawValue)
        mask |= (1 << CGEventType.rightMouseUp.rawValue)
        mask |= (1 << CGEventType.mouseMoved.rawValue)
        mask |= (1 << CGEventType.leftMouseDragged.rawValue)
        mask |= (1 << CGEventType.rightMouseDragged.rawValue)
        mask |= (1 << CGEventType.scrollWheel.rawValue)
        mask |= (1 << CGEventType.otherMouseDown.rawValue)
        mask |= (1 << CGEventType.otherMouseUp.rawValue)
        mask |= (1 << CGEventType.otherMouseDragged.rawValue)
        let eventMask = mask
        
        let selfPointer = Unmanaged.passUnretained(self).toOpaque()
        
        // Setup the event tap at session level, inserting it at the head of the chain.
        guard let tap = CGEvent.tapCreate(
            tap: .cgSessionEventTap,
            place: .headInsertEventTap,
            options: .defaultTap,
            eventsOfInterest: CGEventMask(eventMask),
            callback: { (proxy, type, event, refcon) -> Unmanaged<CGEvent>? in
                guard let refcon = refcon else {
                    return Unmanaged.passUnretained(event)
                }
                let blocker = Unmanaged<InputBlocker>.fromOpaque(refcon).takeUnretainedValue()
                return blocker.handleEvent(proxy: proxy, type: type, event: event)
            },
            userInfo: selfPointer
        ) else {
            print("[KeyLock] Error: Failed to create event tap. Make sure accessibility permission is granted.")
            return
        }
        
        self.eventTap = tap
        self.runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0)
        
        if let source = runLoopSource {
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, .commonModes)
            CGEvent.tapEnable(tap: tap, enable: true)
            print("[KeyLock] Event tap successfully enabled.")
        }
    }
    
    /// Tears down the CGEventTap and restores standard input flow
    func stop() {
        if let tap = eventTap {
            CGEvent.tapEnable(tap: tap, enable: false)
        }
        if let source = runLoopSource {
            CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, .commonModes)
        }
        eventTap = nil
        runLoopSource = nil
        print("[KeyLock] Event tap successfully disabled.")
    }
    
    private func handleEvent(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent) -> Unmanaged<CGEvent>? {
        // Monitor key down events to check for the Escape key
        if type == .keyDown {
            let keyCode = event.getIntegerValueField(.keyboardEventKeycode)
            if keyCode == 53 { // 53 is the virtual keycode for the Escape key (ESC)
                DispatchQueue.main.async { [weak self] in
                    self?.appState?.recordEscPress()
                }
            }
        }
        
        // Suppress the event from propagating by returning nil
        return nil
    }
    
    deinit {
        stop()
    }
}
