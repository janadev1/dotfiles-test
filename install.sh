#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"
DOTFILES_ROOT=$(pwd -P)

# Taken from CodelyTV/dotly
# red='\033[0;31m'
# green='\033[0;32m'
# purple='\033[0;35m'
# normal='\033[0m'

# Taken from holman/dotfiles
info() {
	printf "\r  [ \033[00;34m..\033[0m ] %s\n" "$1"
}

user() {
	printf "\r  [ \033[0;33m??\033[0m ] %s\n" "$1"
}

success() {
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

fail() {
	printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n" "$1"
	echo ''
	exit
}

info "This is a test dotfiles installer"

# This test consists of installing my nvim configuration
# from Github. Just that
#
# 1. Check if an nvim config is already present, and if so, back it up.
if [ -d "$HOME/.config/nvim" ]; then
	info "Neovim configuration found, backing up..."
	mv "$HOME/.config/nvim/" "$HOME/.config/nvim.bak/"
fi

# 2. Check if Neovim is already installed and if not, try to install automatically
# TODO: check if Neovim < 9.x.x is installed, remove it (Ubuntu's case) and install new one
if test "$(which nvim)"; then
	echo "Neovim isn't installed. Please provide Neovim semver (default: 0.9.4)"
	read -r version
	echo "Version selected is v$(version)"

	if ! test "$(which wget)"; then
		echo "wget isn't installed, can't download Neovim tarball."
		exit
	fi

	wget "https://github.com/neovim/neovim/releases/download/v${version:-0.9.4}/nvim-linux64.tar.gz"
	sudo tar xzvf nvim-linux64.tar.gz -C /opt/
	# TODO: check that symlink doesn't exist first(?)
	sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

	if test "$(which nvim)"; then
		echo "Neovim installed succesfully!"
	else
		echo "Something when wrong with the Neovim's installation."
	fi
fi

# 3. Create dotfiles folder and download Neovim config into it from Github
# 4. Create symlink to Neovim config
