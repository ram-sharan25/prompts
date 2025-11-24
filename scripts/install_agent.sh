#!/bin/bash

# install_agent.sh
# Usage: install-agents [target_directory]
# If target_directory is not provided, defaults to current directory.

# 1. Resolve the directory where the *script* lives, to find the source repo.
#    We use a trick to resolve symlinks if this script is symlinked.
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

PROMPTS_SRC="$PROJECT_ROOT/prompts"
WORKFLOWS_SRC="$PROJECT_ROOT/.agent/workflows"

# 2. Determine Target Directory
TARGET_DIR="${1:-.}"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

echo "Installing Agent from $PROJECT_ROOT to $TARGET_DIR..."

# 3. Create Directory Structure
AGENT_DEST="$TARGET_DIR/.agent"
PROMPTS_DEST="$AGENT_DEST/prompts"
WORKFLOWS_DEST="$AGENT_DEST/workflows"

mkdir -p "$PROMPTS_DEST"
mkdir -p "$WORKFLOWS_DEST"

# 4. Copy Prompts
echo "Copying prompts..."
if [ -d "$PROMPTS_SRC" ]; then
    cp "$PROMPTS_SRC"/*.md "$PROMPTS_DEST/"
else
    echo "Error: Source prompts directory not found at $PROMPTS_SRC"
    exit 1
fi

# 5. Copy Workflows and Rewrite Paths
echo "Copying and configuring workflows..."
if [ -d "$WORKFLOWS_SRC" ]; then
    for workflow_file in "$WORKFLOWS_SRC"/*.md; do
        filename=$(basename "$workflow_file")
        dest_file="$WORKFLOWS_DEST/$filename"
        
        # Copy the file
        cp "$workflow_file" "$dest_file"
        
        # Rewrite paths:
        # We need to replace the absolute path of the source repo with the absolute path of the target repo.
        # Specifically, we look for links like file:///.../prompts/python_coder.md
        # and change them to file://$PROMPTS_DEST/python_coder.md
        
        # We use sed to replace the file link.
        # The pattern we are looking for is roughly `(file://).*/prompts/(.*.md)`
        # And we want to replace it with `\1$PROMPTS_DEST/\2`
        
        # Note: We use | as delimiter for sed to avoid issues with slashes in paths.
        
        # Logic: Find any file:// link ending in .md, and replace the directory part with our new local directory.
        # This is a bit aggressive, but for our specific workflow files it should be safe.
        # A more specific regex: `file://.*/prompts/([a-zA-Z0-9_]+\.md)` -> `file://$PROMPTS_DEST/\1`
        
        sed -i '' -E "s|file://.*/prompts/([a-zA-Z0-9_]+\.md)|file://$PROMPTS_DEST/\1|g" "$dest_file"
        
        echo "  Installed $filename"
    done
else
    echo "Error: Source workflows directory not found at $WORKFLOWS_SRC"
    exit 1
fi

echo "Done! Agent installed in $TARGET_DIR/.agent"
echo "You can now use the activation commands (e.g., /activate_coder)."

