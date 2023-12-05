#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"
DOTFILES_ROOT=$(pwd -P)

# Taken from CodelyTV/dotly
red='\033[0;31m'
green='\033[0;32m'
purple='\033[0;35m'
normal='\033[0m'

# Taken from holman/dotfiles
info() {
	printf "\r  [ \033[00;34m..\033[0m ] %s\n" "$1"
}

user() {
	printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success() {
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

fail() {
	printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n" "$1"
	echo ''
	exit
}

_w() {
	local -r text="${1-}"
	echo -e "$text"
}

# Shamelessly taken from CodelyTV/dotly
_w "  ┌────────────────────────────────────────────┐"
_w "~ │ 🚀 Welcome to the ${green}dotfiles test${normal} installer! │ ~"
_w "  └────────────────────────────────────────────┘"
_w

# This test consists of installing my nvim configuration
# from Github. Just that
#
# 1. Check if an nvim config is already present, and if so, back it up.
if [ -d "$HOME/.config/nvim" ]; then
	info "Neovim configuration found, backing up..."
	mv "$HOME/.config/nvim/" "$HOME/.config/nvim.bak/"
fi

# 2. Check if Neovim is already installed and if not, try to install automatically.
# TODO: check if Neovim < 9.x.x is installed, remove it (Ubuntu's case) and install new one
info "Checking applications to restore..."
if test ! "$(which nvim)"; then

	# Ask for version
	read -rp "$(user "  Neovim isn't installed. Please provide Neovim semver to install (default: 0.9.4):")" version
	version=${version:=0.9.4}
	info "  Neovim version selected is v${version}."

	# Download tarball and extract with tar on /opt/
	info "  Downloading and extracting Neovim tarball..."
	wget -qO- "https://github.com/neovim/neovim/releases/download/v${version:-0.9.4}/nvim-linux64.tar.gz" |
		sudo tar xz -C /opt/

	# Create the symlink to it's accessible from PATH
	# We know the symlink doesn't exist because of `which nvim` returning non-zero
	info "  Creating symlink on /usr/local/bin/..."
	sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

	if test "$(which nvim)"; then
		success "  Neovim installed succesfully!"
	else
		fail "  Something when wrong with the Neovim's installation."
	fi
else
	info "  Neovim already installed, version $(nvim --version | sed -n 's/^NVIM v\(.*\)/\1/p') found."
fi

info "All applications restored."
echo ""

# 3. Create dotfiles folder and download Neovim config into it from Github
info "(TODO) Installing configuration files..."
# 4. Create symlink to Neovim config

success "Dotfiles installation completed succesfully!"
