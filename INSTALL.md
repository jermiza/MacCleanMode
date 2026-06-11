# Installation Guide

Follow these steps to install and start using **KeyLock** on your Mac.

---

## Step 1: Download KeyLock

1. Go to the [KeyLock Releases Page](https://github.com/jermiza/MacCleanMode/releases) on GitHub.
2. Under the latest release (e.g. `v1.0.0`), click on **`KeyLock-Apple-Silicon.zip`** to download it.
3. Once downloaded, double-click the zip file in your Downloads folder to extract **`KeyLock.app`**.
4. Drag **`KeyLock.app`** into your **`Applications`** folder.

---

## Step 2: Resolve macOS Security Warning (Quarantine)

Since this app is built locally and is not distributed through the Mac App Store, macOS may show a warning saying *"KeyLock is damaged"* or *"Developer cannot be verified"*. 

To clear this system quarantine flag:
1. Open your **Terminal** app (search for it in Spotlight).
2. Copy and paste the following command, then press Enter:
   ```bash
   xattr -cr /Applications/KeyLock-Apple-Silicon/KeyLock.app
   ```
3. You can now double-click **KeyLock** in your Applications folder to launch it.

---

## Step 3: Grant Accessibility Permissions

KeyLock intercepts key presses to prevent them from reaching your system while cleaning. macOS requires explicit **Accessibility permissions** for this.

1. Launch KeyLock. You will see a small keyboard icon (`⌨️`) appear in the menu bar at the top-right of your screen.
2. Click the icon and select **Grant Accessibility Permission**.
3. macOS will prompt you to open System Settings. Click **Open System Settings**.
4. Navigate to **System Settings > Privacy & Security > Accessibility**.
5. Locate **KeyLock** in the list and toggle the switch to **ON** (blue).
6. Return to the KeyLock menu bar icon and click **Refresh Accessibility Status**. The warning icon should disappear, and you will see the **Start Cleaning Mode** button.

---

## How to Use

1. Click the keyboard icon (`⌨️`) in the menu bar and select **✨ Start Cleaning Mode**.
2. Your screen will turn black and all inputs (keyboard, mouse, trackpad) will be locked. Clean your device safely!
3. To unlock, press the **Escape (ESC)** key **5 times quickly (within 2 seconds)**. The blue dots on-screen will light up as you press.
