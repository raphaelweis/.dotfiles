# Dotfiles

These are my personal dotfiles, used to configure both my desktop and laptop arch systems.

# 1. Configs

Here are a set of instructions for all the configuration files contained in this repository. All the steps detailed in this section need to be done before following [setup](#2-setup). These instructions you will have at least installed the programs mentionned below.

## Alacritty

You need to create `~/.config/alacritty/alacritty-extra.conf` with the following contents :

```toml
[font]
size = 10
```

You can add or change lines in this files according to your host's configuration. This file is ignored.

## Tmux

Make sure to install the tmux plugin manager:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Once you start tmux for the first time, you will also need to trigger the plugin install with `<prefix>I`

## Nvim

Run `checkhealth` after installing plugins to find out about missing dependencies, notably for mason.

## sway

Make sure to install `sway-bg`, `wmenu`, `alacritty` and `tmux` before starting sway.

## zsh

Install [oh-my-zsh](https://ohmyz.sh/#install) first, then make sure to remove the generated .zshrc before symlinking.

You also need to clone some additionals plugins :

```bash
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## Hyprland

You need to create `~/.config/hypr/hyprextra.conf` with the following contents :

```
env=GDK_SCALE, 2
```

You can add or change lines in this files according to your host's configuration. This file is ignored.

## Wezterm

If you are using wezterm on windows, you will have to symlink the config file using powershell.
In a new **PowerShell Administrator Window**, run:
```powershell
New-Item -ItemType SymbolicLink -Path "C:\Users\rapha\.wezterm.lua" -Target "\\wsl$\Ubuntu\home\raphaelw\.dotfiles\wezterm\.wezterm.lua"
```

## Bin

Make sure the `.local/bin` folder is on your path.

## 2. Setup

After installing stow you can run the following commands to symlink the different files to their respective places.

```bash
mkdir -p ~/.config/git && stow -t ~/.config/git git
mkdir -p ~/.config/alacritty && stow -t ~/.config/alacritty alacritty
mkdir -p ~/.config/nvim && stow -t ~/.config/nvim nvim
mkdir -p ~/.config/i3status && stow -t ~/.config/i3status i3status
mkdir -p ~/.config/sway && stow -t ~/.config/sway sway
mkdir -p ~/.config/rofi && stow -t ~/.config/rofi rofi
mkdir -p ~/.config/i3 && stow -t ~/.config/i3 i3
mkdir -p ~/.config/picom && stow -t ~/.config/picom picom
mkdir -p ~/.local/bin && stow -t ~/.local/bin bin
stow -t /etc/X11/xorg.conf.d xorg.conf.d
stow wezterm
stow zsh
stow tmux
```

## 3. Helpful commands

The following commands might be helpful:

```bash
# Copy icons into home to fix cursor issues in certain apps.
cp /usr/share/icons ~/.icons -r
```
