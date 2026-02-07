#!/bin/bash
# Lock the Android device screen

echo "Locking Android device..."
adb shell input keyevent 26
echo "Done."
