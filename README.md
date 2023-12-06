## To install

```bash
bash <(wget -qO- https://raw.githubusercontent.com/janadev1/dotfiles-test/main/install.sh)
```

## Dependencies

**System**

- i3wm: program + config
- polybar

**Terminal, shell, etc**

- Alacritty
  - Starship
  - Zsh(?): autocompletion
  -

**Programming**

- Astronvim
  - Neovim 0.8+ (not nightly)
  - Nerd Fonts
  - Tree Sitter CLI
  - Clipboard tool
  - ripgrep
  - lazygit
- Python
  - pyenv
  - poetry
- Node.js
  - nvm

## Notes

Notes taken from the following examples:

- CodelyTV/dotly
- ...

To simplify the process as much as possible the user should have the option
to `wget` an installation script instead of having to clone the whole repo
manually.

If a package needed for installation is not found, user should be given the
option of either telling the script to install it or stop the installation and
do it manually.

Script should contemplate different package managers for different
distros (apt, pacman, etc).

Script should contain a way of installing any necessary software, even if not
in the package manager. For example, Ubuntu's Neovim repos suck, script should
be able to download lastest stable (or user given) version and install it properly, while
also giving information of what it is doing.

Information shown to the user should be abundant: make what the script is doing clear.

(Optional) The CLI should be pretty: add some colors!
