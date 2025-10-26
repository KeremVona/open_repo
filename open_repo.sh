#!/bin/bash

# Define the default GitHub username/organization.
# Change 'your_username_or_org' to your actual GitHub username or the organization's name.
DEFAULT_OWNER="your_username_or_org"

# Check if a repository name was provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <repository_name>"
    exit 1
fi

REPO_NAME="$1"

# You can customize how the script determines the full URL:
# Option 1 (Default): Assume the repository belongs to the DEFAULT_OWNER
# REPO_URL="https://github.com/${DEFAULT_OWNER}/${REPO_NAME}"

# Option 2: Check if the argument includes a full 'owner/repo' format
if [[ "$REPO_NAME" == */* ]]; then
    # Argument is already in 'owner/repo' format
    REPO_URL="https://github.com/${REPO_NAME}"
else
    # Use the default owner
    REPO_URL="https://github.com/${DEFAULT_OWNER}/${REPO_NAME}"
fi

# The 'xdg-open' command works on most Linux distributions
# 'open' works on macOS
# 'start' works on Windows (via Git Bash/WSL)
if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$REPO_URL"
elif command -v open >/dev/null 2>&1; then
    open "$REPO_URL"
else
    # Fallback for systems without a common opener
    echo "Could not find a command to open the URL. Please navigate to:"
    echo "$REPO_URL"
    exit 1
fi

echo "Opened $REPO_URL in your browser."
exit 0
