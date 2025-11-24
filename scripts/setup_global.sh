#!/bin/bash

# setup_global.sh
# Usage: ./setup_global.sh [path_to_rc_file]

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALLER_PATH="$SCRIPT_DIR/install_agent.sh"

# Ensure the installer is executable
chmod +x "$INSTALLER_PATH"

echo "Setting up 'install-agents' global command..."

# 1. Try to detect the user's shell configuration file
DETECTED_RC=""
if [ -n "$1" ]; then
    DETECTED_RC="$1"
else
    # Check the SHELL environment variable (user's login shell)
    case "$SHELL" in
        */zsh)
            DETECTED_RC="$HOME/.zshrc"
            ;;
        */bash)
            DETECTED_RC="$HOME/.bashrc"
            ;;
        */fish)
            DETECTED_RC="$HOME/.config/fish/config.fish"
            echo "Warning: Fish shell syntax is different. This script adds a bash/zsh alias."
            echo "You may need to manually add: alias install-agents '$INSTALLER_PATH'"
            ;;
        *)
            # Fallback: check for existence of common files
            if [ -f "$HOME/.zshrc" ]; then
                DETECTED_RC="$HOME/.zshrc"
            elif [ -f "$HOME/.bashrc" ]; then
                DETECTED_RC="$HOME/.bashrc"
            fi
            ;;
    esac
fi

# 2. Ask for user confirmation (Interactive Mode)
TARGET_RC=""

if [ -n "$1" ]; then
    # If argument provided, just use it (non-interactive mode support)
    TARGET_RC="$1"
else
    echo "Detected shell config: ${DETECTED_RC:-None}"
    read -p "Install alias to this file? [Y/n/path]: " USER_INPUT
    
    if [ -z "$USER_INPUT" ] || [ "$USER_INPUT" = "y" ] || [ "$USER_INPUT" = "Y" ]; then
        TARGET_RC="$DETECTED_RC"
    elif [ "$USER_INPUT" = "n" ] || [ "$USER_INPUT" = "N" ]; then
        echo "Aborted by user."
        exit 0
    else
        # User entered a custom path
        TARGET_RC="$USER_INPUT"
    fi
fi

if [ -z "$TARGET_RC" ]; then
    echo "Error: No config file specified."
    exit 1
fi

# Expand tilde if present (simple expansion)
TARGET_RC="${TARGET_RC/#\~/$HOME}"

echo "Installing to: $TARGET_RC"

# 3. Append the alias
if grep -q "alias install-agents=" "$TARGET_RC" 2>/dev/null; then
    echo "Alias 'install-agents' already exists in $TARGET_RC"
    echo "Please check if it points to: $INSTALLER_PATH"
else
    # Ensure directory exists
    mkdir -p "$(dirname "$TARGET_RC")"
    
    echo "" >> "$TARGET_RC"
    echo "# Agent Installer Alias" >> "$TARGET_RC"
    echo "alias install-agents='$INSTALLER_PATH'" >> "$TARGET_RC"
    echo "✅ Added alias to $TARGET_RC"
fi

echo ""
echo "Setup complete! To use it immediately, run:"
echo "  source $TARGET_RC"

