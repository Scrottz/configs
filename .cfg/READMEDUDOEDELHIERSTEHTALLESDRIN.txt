To manage the bare repository, the following alias must be present in the shell configuration:

alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
Daily Workflow

The repository is configured to ignore untracked files by default. Modifications are only visible once a file or directory has been explicitly tracked.
Check Repository Status

Shows tracked modifications and staged files:
dotfiles status
Scan Workspace (The Spotlight)

Temporarily bypasses the filter to see any untracked files in a specific directory:
dotfiles status -u ~/.config/
Track a New File or Directory

Explicitly adds a file or entire folder structure to the index:
dotfiles add ~/.config/target-dir/
Commit and Push Changes

Freezes the staged state locally and ships it to GitHub:
dotfiles commit -m "Your precise structural commit message"
dotfiles push
Repository Initialization from Scratch

If you ever need to purge the entire setup and build the bare repository completely from the ground up locally:

    Delete any existing configuration folder safely:
    rm -rf ~/.cfg

    Initialize the fresh bare repository:
    git init --bare $HOME/.cfg

    Apply the security standard to ignore untracked files completely (The Life Insurance):
    dotfiles config --local status.showUntrackedFiles no

    Link your remote target architecture:
    dotfiles remote add origin git@github.com:Scrottz/configs.git

System Recovery and Provisioning (Deployment)

To restore this exact repository structure onto a clean operating system installation or a second machine:

    Export the control alias temporarily into your current active shell session:
    alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

    Clone the remote repository directly into the target bare directory structure:
    git clone --bare git@github.com:Scrottz/configs.git $HOME/.cfg

    Inject the local safety standard to ensure your fresh home directory stays clean:
    dotfiles config --local status.showUntrackedFiles no

    Materialize the configuration files into the home working tree:
    dotfiles checkout

    Note: If stock system templates (such as a default .bashrc) collide with the repository files during checkout, remove or move those local files out of the way, then execute the checkout command again.