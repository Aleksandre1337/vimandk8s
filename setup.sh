#!/bin/bash

# Get the current logged-in user
CURRENT_USER=$(whoami)

echo "Running the script as user: $CURRENT_USER"

read -p "Are you using yum or apt package manager? " packagemanager

# Install vim and ncurses
if ! command -v vim &> /dev/null; then
  sudo $packagemanager install -y vim
  echo "Vim installed successfully"
elif ! command -v clear &> /dev/null; then
  sudo $packagemanager install -y ncurses
  echo "Ncurses package installed, you can use clear command now"
else
  echo "Packages are already installed, moving on"
fi

# Create .vimrc file with the specified settings
VIMRC_PATH="/home/$CURRENT_USER/.vimrc"
if [ ! -f "$VIMRC_PATH" ]; then
  cat <<EOL > "$VIMRC_PATH"
set ts=2
set sw=2
set et
set ai
set si
set ic
EOL
  echo ".vimrc created"
else
  echo ".vimrc already exists, moving on"
fi

# Update .bashrc with the specified environment variables and alias
BASHRC_PATH="/home/$CURRENT_USER/.bashrc"
if ! grep -q "export do=" "$BASHRC_PATH"; then
  cat <<EOL >> "$BASHRC_PATH"
export do="--dry-run=client -o yaml"
export now="--force --grace-period 0"
EOL
  echo "Environment variables added to .bashrc"
else
  echo "Environment variables already set in .bashrc, moving on"
fi

if ! grep -q "alias k=" "$BASHRC_PATH"; then
  echo 'alias k=/usr/local/bin/kubectl' >> "$BASHRC_PATH"
  echo "Alias added to .bashrc"
else
  echo "Alias already set in .bashrc, moving on"
fi

# Source the .bashrc to apply changes as the current user
sudo -u $CURRENT_USER -i bash -c "source $BASHRC_PATH"

echo "Vim installed, .vimrc and .bashrc updated."
