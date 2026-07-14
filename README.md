# Dotfiles Repository

This repository manages my system configurations using a **bare git repository**. This approach allows tracking dotfiles directly in the $HOME directory without the need for symlinks or external tools.

## Initial Setup

To set up these dotfiles on a fresh system, follow these steps:

1. **Clone the repository as a bare repo:**
   git clone --bare https://github.com/Scrottz/configs.git $HOME/.cfg

2. **Define the alias for the current session:**
   alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

3. **Configure the worktree and hide untracked files:**
   dotfiles config --local core.worktree $HOME
   dotfiles config --local status.showUntrackedFiles no

4. **Checkout the configuration files:**
   *Note: If existing files in your $HOME conflict with the repository files, move them to a backup directory first.*
   dotfiles checkout

## Workflow

- **Check status:** dotfiles status
- **Add changes:** dotfiles add <file>
- **Commit changes:** dotfiles commit -m "Your message"
- **Push changes:** dotfiles push

## Authentication & Identity

### Git Identity
Set your identity locally for this repository to ensure commits are signed correctly:
   dotfiles config user.name "Your Name"
   dotfiles config user.email "your@email.com"

### SSH Configuration
This repository uses SSH for authentication. Ensure your SSH agent is running and your public key is added to your GitHub account:

1. **Verify SSH agent:**
   ssh-add -l
2. **Add keys automatically:**
   Ensure your ~/.ssh/config is configured to AddKeysToAgent yes. You can load your keys via:
   ssh-add -A

## Security
- Never commit sensitive files (API keys, passwords, etc.) to the repository.
- Use .gitignore to exclude secrets.
- Manage tool-specific secrets (like LLM API keys) using the respective tool's configuration commands (e.g., llm keys set gemini).
