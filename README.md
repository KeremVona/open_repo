# open_repo

A simple, lightweight bash script and utility to quickly open a GitHub repository in your default web browser directly from your terminal, without needing to type out the full URL.

## Installation and Setup

### 1. Script Setup

1.  **Save the script:** Save the `open_repo.sh` code into a common scripts directory, like `~/bin/`.
    ```bash
    mkdir -p ~/bin
    # Save the script contents to this file:
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
    DEFAULT_OWNER="your_username_or_org"
    ```

### 2. Update your PATH

For the command to work from any directory, ensure the script's location (`~/bin`) is in your system's `$PATH`. Add the following line to your **`~/.bashrc`** or **`~/.zshrc`** file:

```bash
export PATH="$HOME/bin:$PATH"
