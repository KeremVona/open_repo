# open_repo

A simple, lightweight bash script and utility to quickly open a GitHub repository in your default web browser directly from your terminal, without needing to type out the full URL.

## Features
- **Detection**: When run without arguments inside a local Git repository, it detects the origin remote URL and opens the corresponding GitHub page.
- **Explicit Naming**: Supports opening repositories by name or by owner/repo format, using a pre-configured DEFAULT_OWNER when necessary.

## Installation and Setup

### 1. Script Setup

1.  **Save the script:** Save the `open_repo.sh` code into a common scripts directory, like `~/bin/`.
    ```bash
    mkdir -p ~/bin
    # Save the script contents to this file (e.g., using nano or a text editor):
    # nano ~/bin/open_repo.sh
    ```

2.  **Make it Executable:**
    ```bash
    chmod +x ~/bin/open_repo.sh
    ```

3.  **Configure Default Owner:**
    Open the script (`~/bin/open_repo.sh`) and edit the `DEFAULT_OWNER` to your personal GitHub username or organization name.
    ```bash
    # open_repo.sh excerpt
    DEFAULT_OWNER="your_personal_github_username"
    ```

### 2. Update your PATH

For the command to work from any directory, ensure the script's location (`~/bin`) is in your system's `$PATH`. Add the following line to your **`~/.bashrc`** file:

```bash
export PATH="$HOME/bin:$PATH"
```

## Usage
The script supports three modes of operation:

| Mode | Command | Description |
| :--- | :--- | :--- | 
| **Detect** | `open_repo.sh` | Run this command **inside** a local Git repository. The script extracts the URL from your `origin` remote and opens it. |
| **Explicit (Name Only)** | `open_repo.sh my-project` | Opens `https://github.com/DEFAULT_OWNER/my-project`. |
| **Explicit (Full Path)** | `open_repo.sh user-org/other-repo` | Opens https://github.com/user-org/other-repo, ignoring the DEFAULT_OWNER setting. |
