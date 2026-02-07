#!/bin/bash
# Unlock the Android device with a PIN

# Your device PIN or password
PIN="1234"

echo "Waking and unlocking Android device..."

# Wake the device (press power button)
adb shell input keyevent 26

# Swipe up to reveal the PIN pad. Coordinates may vary.
# Adjust the Y-axis numbers if this doesn't work on your device.
adb shell input swipe 500 1500 500 500

# Enter the PIN
adb shell input text "$PIN"

# Press the Enter key
adb shell input keyevent 66

echo "Unlock process complete."
