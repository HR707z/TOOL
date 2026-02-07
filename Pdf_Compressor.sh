#!/bin/bash

# Check if Ghostscript is installed
if ! command -v gs &> /dev/null
then
    echo "Ghostscript (gs) is not installed. Please install it to use this script."
    exit 1
fi

# Check if input and output filenames are provided
if [ -z "$1" ] || [ -z "$2" ]
then
    echo "Usage: $0 <input_pdf_file> <output_pdf_file>"
    exit 1
fi

input_pdf="$1"
output_pdf="$2"

# Check if input file exists
if [ ! -f "$input_pdf" ]
then
    echo "Error: Input file '$input_pdf' not found."
    exit 1
fi

echo "Compressing '$input_pdf' to '$output_pdf'..."

# Ghostscript command for compression
gs -sDEVICE=pdfwrite \
   -dCompatibilityLevel=1.4 \
   -dPDFSETTINGS=/ebook \
   -dNOPAUSE \
   -dBATCH \
   -sOutputFile="$output_pdf" \
   "$input_pdf"

if [ $? -eq 0 ]; then
    echo "Compression successful!"
else
    echo "Compression failed."
fi
