#!/bin/bash

# Define source and destination directories
# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Prompts are in the parent directory's "prompts" folder
SRC_DIR="$SCRIPT_DIR/../prompts"
DEST_DIR="$HOME/.gemini/antigravity/global_workflows"

# Ensure destination directory exists
mkdir -p "$DEST_DIR"

# Copy markdown files
echo "Copying prompts from $SRC_DIR to $DEST_DIR..."
cp "$SRC_DIR"/*.md "$DEST_DIR/"

echo "Done."
