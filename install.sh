#!/usr/bin/env bash

echo "This is a test dotfiles installer"

# This test consists of installing my nvim configuration
# from Github. Just that
#
# 1. Check if an nvim config is already present, and if so, back it up.
if [ -d "$HOME/.config/nvim" ]; then
	echo "Neovim configuration found, backing up..."
	mv "$HOME/.config/nvim/" "$HOME/.config/nvim.bak/"
fi

# 2. Check if Neovim is already installed and if not, try to install automatically
if test ! "$(which nvim)"; then
	echo "Neovim isn't installed. Please provide Neovim semver:"
	read -r version
	echo "Version selected is v$(version)"

	if ! test "$(which wget)"; then
		echo "wget isn't installed, can't download Neovim tarball."
	fi

	wget "https://github.com/neovim/neovim/releases/download/v${version:-0.9.4}/nvim-linux64.tar.gz"
	sudo tar xzvf nvim-linux64.tar.gz -C /opt/
	sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

	if test "$(which nvim)"; then
		echo "Neovim installed succesfully!"
	else
		echo "Something when wrong with the Neovim's installation."
	fi
fi

# 3. Create dotfiles folder and download Neovim config into it from Github
# 4. Create symlink to Neovim config
