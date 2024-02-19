# Dotfiles

These are my personal dotfiles, used to configure both my desktop and laptop arch systems.

# 1. Configs

Here are a set of instructions for all the configuration files contained in this repository. All the steps detailed in this section need to be done before following [setup](#2-setup). These instructions you will have at least installed the programs mentionned below.

## Git

Nothing to do. Go to [setup](#2-setup)

## Alacritty

You need to first create a file called `font-size.toml` in `~$HOME/.config/alacritty`.

In it, put the following:
```toml
[font]
size = FONT_SIZE
```
Replace FONT_SIZE which the font-size of your liking. This file is ignored in this repository. Use it to define different default font-sizes for different machines

## Nvim

You will need to manually install the language servers et formatters that are configured. It is more convenient to just wait until you need something to install it. Python3 and the neovim python module may also be required for latex files.

Additionaly, my nvim configuration is in a git submodule, so that I can use it standalone. After cloning this repository, run:
```bash
git submodule init && git submodule update
```
to also clone the nvim configuration.

## i3status

Nothing to do. Go to [setup](#2-setup)

## sway

Make sure to install `sway-bg`, `wmenu`, `alacritty` and `tmux` before starting sway.

## zsh

Install [oh-my-zsh](https://ohmyz.sh/#install) first, then make sure to remove the generated .zshrc before symlinking.

## 2. Setup

After installing stow you can run the following commands to symlink the different files to their respective places.

```bash
mkdir -p ~/.config/git && stow -t ~/.config/git git
mkdir -p ~/.config/alacritty && stow -t ~/.config/alacritty alacritty
mkdir -p ~/.config/nvim && stow -t ~/.config/nvim nvim
mkdir -p ~/.config/i3status && stow -t ~/.config/i3status i3status
mkdir -p ~/.config/sway && stow -t ~/.config/sway sway
stow zsh
```
