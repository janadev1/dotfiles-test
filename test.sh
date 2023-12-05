#!/usr/bin/env bash

cd "$(dirname "$0")" || exit
DOTFILES_ROOT=$(pwd -P)

echo "$DOTFILES_ROOT"

for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink' -not -path '*.git*'); do
	dst="$HOME/.$(basename "${src%.*}")"
	echo "$src"
	echo "$dst"
	# link_file "$src" "$dst"
done
