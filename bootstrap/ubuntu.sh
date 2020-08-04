#!/bin/bash

echo "Installing Fish..."
sudo apt-get install --no-install-recommends -y fish

echo "Downloading Fish configuration..."
mkdir -p ~/.config/fish
wget https://raw.githubusercontent.com/brendan-src/config/master/config.fish
mv config.fish ~/.config/fish

echo "Setting Fish as default shell..."
chsh -s /usr/bin/fish

echo "Configuring SSH"
ssh-keygen -t rsa -b 4096 -f ~/.ssh/github

echo "Installing standard packages"
sudo apt-get install -y --no-install-recommends vim git

echo "Restarting shell"
exec fish
