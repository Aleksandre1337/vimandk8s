#!/bin/bash

# Install vim
sudo yum install -y vim

# Create .vimrc file with the specified settings
cat <<EOL > ~/.vimrc
set ts=2
set sw=2
set et
set ai
set si
set ic
EOL

# Update .bashrc with the specified environment variables
cat <<EOL >> ~/.bashrc
export do="--dry-run=client -o yaml"
export now="--force --grace-period 0"
EOL

# Source the .bashrc to apply changes
source ~/.bashrc

echo "Vim installed, .vimrc and .bashrc updated."
