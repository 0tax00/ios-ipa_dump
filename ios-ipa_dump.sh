#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <ipa_file>"
    exit 1
fi

IPA_PATH="$1"

if [ ! -f "$IPA_PATH" ]; then
    echo "Error: File not found"
    exit 1
fi

APP_NAME=$(basename "$IPA_PATH" .ipa)
BASE_DIR=$(dirname "$IPA_PATH")
WORKSPACE="$BASE_DIR/$APP_NAME"

mkdir -p "$WORKSPACE"

TEMP_DIR="$WORKSPACE/_extracted"
mkdir -p "$TEMP_DIR"

echo "Processing $APP_NAME..."

unzip -q "$IPA_PATH" -d "$TEMP_DIR"

APP_DIR=$(find "$TEMP_DIR" -name "*.app" -type d | head -1)

if [ -z "$APP_DIR" ]; then
    echo "No app bundle found"
    exit 1
fi

BINARY_PATH="$APP_DIR/$(basename "$APP_DIR" .app)"

if [ ! -f "$BINARY_PATH" ]; then
    echo "Binary not found"
    exit 1
fi

OBJC_OUTPUT="$WORKSPACE/class_dump"
SWIFT_OUTPUT="$WORKSPACE/swift_dump"

mkdir -p "$OBJC_OUTPUT"
mkdir -p "$SWIFT_OUTPUT"

echo "Extracting Objective-C classes..."
ipsw class-dump "$BINARY_PATH" --headers -o "$OBJC_OUTPUT"

echo "Extracting Swift classes..."
ipsw swift-dump "$BINARY_PATH" > "$SWIFT_OUTPUT/$APP_NAME-mangled.txt"
ipsw swift-dump "$BINARY_PATH" --demangle > "$SWIFT_OUTPUT/$APP_NAME-demangled.txt"

echo "Analysis complete: $WORKSPACE"
