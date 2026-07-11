#!/bin/bash

# This script sets up keyd configuration.
# It assumes your dotfiles are managed in a bare git repo
# with $HOME as the working directory.

# Get the directory where this script resides
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "--- Setting up keyd ---"

# Check if keyd is installed
if ! command -v keyd &> /dev/null; then
    echo "ERROR: keyd is not installed. Please install it first."
    exit 1
fi

# Ensure /etc/keyd directory exists
echo "Creating /etc/keyd directory..."
sudo mkdir -p /etc/keyd

# Link the config file from your dotfiles repo to /etc/keyd/default.conf
# This assumes your dotfiles folder structure is: ~/etc/keyd/default.conf
echo "Linking configuration..."
sudo ln -sf "$HOME/etc/keyd/default.conf" /etc/keyd/default.conf

# Reload, enable, and restart the service
echo "Reloading keyd service..."
sudo systemctl enable keyd
sudo systemctl restart keyd

echo "Keyd setup complete."

