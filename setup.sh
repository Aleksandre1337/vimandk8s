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

# Execute the environment variables in the current terminal
alias kubectl='/usr/local/bin/kubectl'
export do="--dry-run=client -o yaml"
export now="--force --grace-period 0"
echo "Environment variables set for the current terminal session"

echo "Script Complete"
