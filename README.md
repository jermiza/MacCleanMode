# KeyLock

**KeyLock** is a premium, lightweight native macOS menu bar application built in Swift and SwiftUI. It allows users to safely clean their keyboard, trackpad, and screen without triggering unwanted inputs.

When enabled, KeyLock blocks all keyboard, mouse, scroll, and gesture inputs, replacing the view with a stunning glassmorphic fullscreen overlay on all active displays.

---

## Features

- **Menu Bar Integration**: Quick, low-overhead access directly from your menu bar. Runs as a background agent (`LSUIElement = true`) without cluttering your Dock.
- **Global Input Interception**: Captures and blocks all keyboard presses, trackpad actions, clicks, scrolls, and drag-and-drop gestures using a low-level macOS Event Tap.
- **Multi-Monitor Screen Cover**: Spawns high-level borderless windows (running at `.screenSaver` depth) to lock out all connected displays, allowing you to clean screens simultaneously.
- **Micro-Animations**: Features a beautiful glassmorphic dark visual theme with pulsing shields, radial glows, and spring-animated unlock indicators.
- **Safety Lock / Unlock Mechanism**: To prevent accidental unlocking, the user must press the **Escape (ESC)** key **5 times within 2 seconds**. An on-screen dot tracker dynamically responds to your escape presses.
- **Accessibility Automation**: Proactively checks accessibility permissions required for event capturing, guiding the user straight to System Settings if configuration is needed.
- **Native Apple Silicon Build**: Compiled natively targeting Apple Silicon architectures (`arm64`).

---

## Build Instructions

KeyLock requires macOS Ventura (13.0) or later and Xcode 14.0 or later.

### Building via Xcode GUI

1. Clone or copy the repository files.
2. Open the Xcode project:
   ```bash
   open KeyLock.xcodeproj
   ```
3. Set the target run device to **My Mac**.
4. Press `Cmd + R` to compile and run in Debug mode, or select **Product > Archive** to package for production.

### Building via Command Line (CLI)

You can compile a native release build directly in your terminal:

```bash
xcodebuild -project KeyLock.xcodeproj \
           -scheme KeyLock \
           -configuration Release \
           -destination 'generic/platform=macOS' \
           ARCHS=arm64 \
           clean build
```

The compiled binary will be placed inside the `build/Release/` directory as `KeyLock.app`.

---

## How to Use

1. Launch the application (`KeyLock.app`).
2. The keyboard icon (`⌨️`) will appear in your macOS menu bar.
3. Click the icon. If launching for the first time, click **Grant Accessibility Permission**. macOS will open *System Settings > Privacy & Security > Accessibility*. Toggle **KeyLock** to ON.
4. Click **Start Cleaning Mode** from the menu bar dropdown.
5. The screen will black out, your cursor will hide, and inputs will lock. Clean your device safely!
6. To exit, press the **Escape (ESC)** key **5 times within 2 seconds**. The progress dots will illuminate to register your inputs.

---

## License

This project is licensed under the MIT License.
