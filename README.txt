======================================================================
  🔑 KeyLock - Installation & Setup Instructions
======================================================================

Thank you for downloading KeyLock! 

Since this application is not distributed through the Mac App Store, macOS may block it from running and show an error saying:
- "KeyLock is damaged and can't be opened." OR
- "App Developer cannot be verified."

To fix this, you must clear the macOS quarantine flag BEFORE opening the app for the first time.

----------------------------------------------------------------------
👉 STEP-BY-STEP SETUP
----------------------------------------------------------------------

1. Extract the downloaded ZIP file to get "KeyLock.app".
2. Open the "Terminal" app on your Mac (press Cmd + Space, type "Terminal", and press Enter).
3. Copy and paste the following command into the Terminal and press Enter:

   xattr -cr ~/Downloads/KeyLock.app

   *(Note: If you moved the app to your Applications folder, run this command instead:
    xattr -cr /Applications/KeyLock.app )*

4. Now you can double-click and open KeyLock.app!

----------------------------------------------------------------------
👉 FIRST-TIME RUN (ACCESSIBILITY ACCESS)
----------------------------------------------------------------------
KeyLock intercepts keyboard and mouse inputs so they don't reach your Mac while you clean. macOS requires explicit Accessibility permissions for this:

1. Click the keyboard icon (⌨️) in the menu bar at the top right of your screen.
2. Select "Grant Accessibility Permission".
3. Toggle the switch next to "KeyLock" to ON in System Settings.
4. Click the KeyLock menu bar icon again and select "Refresh Accessibility Status".

----------------------------------------------------------------------
👉 HOW TO UNLOCK
----------------------------------------------------------------------
To exit the clean lock screen, press the Escape (ESC) key 5 times quickly (within 2 seconds).
