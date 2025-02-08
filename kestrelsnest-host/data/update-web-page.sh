#!/bin/bash

# Set the working directory
WEB_DIR="/var/www"
ICON_SCRIPT="/var/www/icon_generator/generate_icons.sh"

# Navigate to the repo directory
cd "$WEB_DIR" || { echo "Failed to navigate to $WEB_DIR"; exit 1; }

# Stash local changes if necessary
git reset --hard
git clean -fd

# Pull latest changes
git pull origin main > /tmp/git_pull_output.log 2>&1
GIT_STATUS=$?

# Check if there were changes
if grep -q "Already up to date." /tmp/git_pull_output.log; then
    echo "No updates found. Exiting."
    exit 0
fi

# If there were updates, run the icon generator script
if [[ $GIT_STATUS -eq 0 ]]; then
    echo "Updates detected. Running icon generator script."
    chmod +x "$ICON_SCRIPT"
    "$ICON_SCRIPT"
else
    echo "Git pull failed. Exiting."
    exit 1
fi

# Set permissions
echo "Setting permissions for $WEB_DIR"
chmod -R 777 "$WEB_DIR"

# Reload Nginx
echo "Reloading Nginx"
nginx -s reload

echo "Update and reload completed successfully."
