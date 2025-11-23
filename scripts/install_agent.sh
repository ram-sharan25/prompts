#!/bin/bash

# install_agent.sh
# Usage: ./install_agent.sh <path_to_target_project>
# Example: ./install_agent.sh ../MyNewProject

# Get the directory where this script is located (scripts/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# The project root is one level up
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
PROMPTS_DIR="$PROJECT_ROOT/prompts"
AGENT_DIR="$PROJECT_ROOT/.agent"

TARGET_DIR="$1"

if [ -z "$TARGET_DIR" ]; then
    echo "Usage: $0 <target_directory>"
    exit 1
fi

# Resolve absolute path for target
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

echo "Installing Agent configuration from $PROJECT_ROOT to $TARGET_DIR..."

# 1. Link the .agent directory (Workflows)
if [ -d "$TARGET_DIR/.agent" ]; then
    echo "Warning: $TARGET_DIR/.agent already exists. Skipping link."
else
    echo "Linking .agent directory..."
    ln -s "$AGENT_DIR" "$TARGET_DIR/.agent"
fi

# 2. Link all Prompt files from prompts/ directory
if [ -d "$PROMPTS_DIR" ]; then
    echo "Linking prompts from $PROMPTS_DIR..."
    for prompt_file in "$PROMPTS_DIR"/*; do
        if [ -f "$prompt_file" ]; then
            filename=$(basename "$prompt_file")
            target_path="$TARGET_DIR/$filename"
            
            if [ -f "$target_path" ]; then
                echo "Warning: $target_path already exists. Skipping link."
            else
                echo "Linking $filename..."
                ln -s "$prompt_file" "$target_path"
            fi
        fi
    done
else
    echo "Error: Prompts directory not found at $PROMPTS_DIR"
fi

echo "Done! You can now use '/activate_coder' (and other installed prompts) in $TARGET_DIR."
