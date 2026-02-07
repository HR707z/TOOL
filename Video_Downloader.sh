#!/bin/bash

# Check if yt-dlp is installed
if ! command -v yt-dlp &> /dev/null
then
    echo "yt-dlp is not installed. Please install it first."
    exit 1
fi

# Check if a URL is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <video_url>"
    exit 1
fi

VIDEO_URL="$1"
OUTPUT_DIR="$HOME/Downloads/Videos" # Customize your download directory

mkdir -p "$OUTPUT_DIR" # Create directory if it doesn't exist

echo "Downloading video from: $VIDEO_URL to $OUTPUT_DIR"
yt-dlp -o "$OUTPUT_DIR/%(title)s.%(ext)s" "$VIDEO_URL"

if [ $? -eq 0 ]; then
    echo "Download completed successfully."
else
    echo "Download failed."
fi
