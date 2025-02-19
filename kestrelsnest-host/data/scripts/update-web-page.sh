#!/bin/bash

# Set variables
WEB_DIR="/var/www"
ICON_SCRIPT="/var/www/icon_generator/generate_icons.sh"
LOG_DIR="/var/log/nginx"
LOG_FILE="$LOG_DIR/git.log"

# Ensure the log directory exists
mkdir -p "$LOG_DIR"

# Redirect all output (stdout and stderr) to the log file in append mode
exec >> "$LOG_FILE" 2>&1

echo "-------------------------------"
echo "Script started at $(date)"
echo "-------------------------------"

# Navigate to the repository directory
cd "$WEB_DIR" || { echo "Failed to navigate to $WEB_DIR"; exit 1; }

# Clean up any local changes
echo "Resetting and cleaning local changes..."
git reset --hard
git clean -fd

# Record the current commit hash
PREV_COMMIT=$(git rev-parse HEAD)

# Fetch the latest changes from the 'main' branch with prune
echo "Fetching latest changes from the 'main' branch with prune..."
git fetch --prune origin main

# Reset local repository to match origin/main
echo "Resetting local repository to origin/main..."
git reset --hard origin/main
GIT_STATUS=$?

if [[ $GIT_STATUS -ne 0 ]]; then
    echo "Git reset failed. Exiting."
    exit 1
fi

# Record the new commit hash
NEW_COMMIT=$(git rev-parse HEAD)

# Check if there were any updates
if [ "$PREV_COMMIT" == "$NEW_COMMIT" ]; then
    echo "No updates found. Exiting."
    exit 0
fi

echo "Updates detected. Running icon generator script..."
chmod +x "$ICON_SCRIPT"
"$ICON_SCRIPT"

# Set permissions on the web directory
echo "Setting permissions for $WEB_DIR"
chmod -R 777 "$WEB_DIR"

# Reload Nginx to apply any changes
echo "Reloading Nginx"
nginx -s reload

echo "Update and reload completed successfully."
echo "-------------------------------"
echo "Script finished at $(date)"
echo "-------------------------------"
