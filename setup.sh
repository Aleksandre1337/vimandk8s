#!/bin/bash

# Get the current logged-in user
CURRENT_USER=$(whoami)

echo "Running the script as user: $CURRENT_USER"

read -p "Are you using yum or apt package manager? " packagemanager

# Install vim and ncurses
sudo $packagemanager install -y vim ncurses
echo "Vim and ncurses installed successfully"

# Create .vimrc file with the specified settings
VIMRC_PATH="/home/$CURRENT_USER/.vimrc"
cat <<EOL > "$VIMRC_PATH"
set ts=2
set sw=2
set et
set ai
set si
set ic
EOL
echo ".vimrc updated with necessary settings"

# Update .bashrc with the specified environment variables
BASHRC_PATH="/home/$CURRENT_USER/.bashrc"
cat <<EOL >> "$BASHRC_PATH"
export do="--dry-run=client -o yaml"
export now="--force --grace-period 0"
EOL
echo "Environment variables added to .bashrc"

# Source the .bashrc to apply changes as the current user
source "$BASHRC_PATH"

# Fix Kubectl Bug
alias kubectl='/usr/local/bin/kubectl'

echo "Script Complete"
