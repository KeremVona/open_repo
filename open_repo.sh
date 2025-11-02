#!/bin/bash

# Change 'your_personal_github_username' to your actual GitHub username.
DEFAULT_OWNER="your_personal_github_username"

# --- Function to determine the repository URL ---
determine_repo_url() {
    local repo_name="$1"
    local repo_url=""

    if [ -z "$repo_name" ]; then
        # Case 1: No argument provided - check current directory for Git repo

        # Check if we are inside a git work tree
        if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
            REMOTE_URL=$(git remote get-url origin 2>/dev/null)

            if [ -z "$REMOTE_URL" ]; then
                echo "Error: Git repository found, but no 'origin' remote is configured." 1>&2
                exit 1
            fi

            # Use sed to clean the URL and extract owner/repo path from both SSH and HTTPS formats
            # e.g., git@github.com:owner/repo.git or https://github.com/owner/repo.git
            CLEAN_PATH=$(echo "$REMOTE_URL" | sed -E 's/.*github\.com[/:]([^\/]+)\/([^.]+)\.git/\1\/\2/')

            if [[ "$CLEAN_PATH" != */* ]]; then
                echo "Error: Could not parse a valid GitHub owner/repo path from the 'origin' URL." 1>&2
                exit 1
            fi

            repo_url="https://github.com/${CLEAN_PATH}"
            # Send status message to stderr (1>&2) so it's not captured by REPO_URL=$(...)
            echo "Auto-detected repository from current directory." 1>&2
        else
            # Not in a git repo AND no argument provided
            echo "Usage: $0 <repository_name> | (run inside a Git repo)" 1>&2
            exit 1
        fi
    else
        # Case 2: Argument provided - use existing logic
        if [[ "$repo_name" == */* ]]; then
            # Argument is already in 'owner/repo' format
            repo_url="https://github.com/${repo_name}"
        else
            # Use the default owner defined above
            repo_url="https://github.com/${DEFAULT_OWNER}/${repo_name}"
        fi
    fi

    # Only the final URL is printed to standard output for capture by the main script
    echo "$repo_url"
}

# --- Main Script Execution ---

REPO_URL=$(determine_repo_url "$1")

# The 'xdg-open' command works on most Linux distributions
# 'open' works on macOS
# 'start' works on Windows (via Git Bash/WSL)
if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$REPO_URL"
elif command -v open >/dev/null 2>&1; then
    open "$REPO_URL"
elif command -v start >/dev/null 2>&1; then # Windows WSL/Git Bash fallback
    start "$REPO_URL"
else
    # Fallback for systems without a common opener
    echo "Could not find a command to open the URL. Please navigate to:" 1>&2
    echo "$REPO_URL"
    exit 1
fi

echo "Opened $REPO_URL in your browser."
exit 0
