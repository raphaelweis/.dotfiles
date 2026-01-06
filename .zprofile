# Auto start Hyprland on TTY1
# if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
#     exec Hyprland
# fi
if [ "$(uname)" = "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
