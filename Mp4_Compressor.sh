#!/bin/bash

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null
then
    echo "ffmpeg could not be found. Please install ffmpeg to use this script."
    exit 1
fi

# Check if an input file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <input_video.mp4> [output_video.mp4]"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="${2:-compressed_${INPUT_FILE}}" # Default output file name

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found."
    exit 1
fi

echo "Compressing '$INPUT_FILE' to '$OUTPUT_FILE'..."

# ffmpeg command for compression
# -i: input file
# -vcodec libx264: video codec (H.264)
# -crf 28: Constant Rate Factor (CRF) for quality control. Lower values mean higher quality/larger file size.
#          A CRF of 23 is often considered a good balance. 28 will result in higher compression.
# -preset medium: encoding speed vs. compression efficiency tradeoff. Options include ultrafast, superfast, fast, medium, slow, slower, veryslow.
# -acodec aac: audio codec (AAC)
# -b:a 128k: audio bitrate (128kbps)
ffmpeg -i "$INPUT_FILE" -vcodec libx264 -crf 28 -preset medium -acodec aac -b:a 128k "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "Compression successful! Output file: '$OUTPUT_FILE'"
else
    echo "Compression failed."
fi
