#!/bin/sh

# This script generates a QR code image from a sample message using BytesToQrCodeCLI.

# Define the sample message
SAMPLE_MESSAGE="Hello, QR Code from example.sh!"

# Define the output file name
OUTPUT_FILE="sample_qrcode.png"

# Generate the QR code and save it to a PNG file
echo "$SAMPLE_MESSAGE" | BYTE_LIMIT=32 ./BytesToQrCodeCLI > "$OUTPUT_FILE"

echo "QR code generated and saved to $OUTPUT_FILE"

file "${OUTPUT_FILE}"
