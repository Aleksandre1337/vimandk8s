#!/bin/bash

# Get the current logged-in user
CURRENT_USER=$(whoami)

echo "Running the script as user: $CURRENT_USER"

read -p "Are you using yum or apt package manager? " packagemanager

# Install vim
sudo $packagemanager install -y vim

# Create .vimrc file with the specified settings
if [ ! -f /home/$CURRENT_USER/.vimrc ]; then
  cat <<EOL > /home/$CURRENT_USER/.vimrc
set ts=2
set sw=2
set et
set ai
set si
set ic
EOL
else
  echo ".vimrc already exists, moving on"
fi

# Update .bashrc with the specified environment variables
if ! grep -q "export do=" /home/$CURRENT_USER/.bashrc; then
  cat <<EOL >> /home/$CURRENT_USER/.bashrc
export do="--dry-run=client -o yaml"
export now="--force --grace-period 0"
EOL
else
  echo "Environment variables already set in .bashrc, moving on"
fi

# Source the .bashrc to apply changes as the current user
sudo -u $CURRENT_USER -i bash -c "source /home/$CURRENT_USER/.bashrc"

echo "Vim installed, .vimrc and .bashrc updated."
