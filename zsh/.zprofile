export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=adwaita-dark
export MOZ_USE_XINPUT2=1
export XCURSOR_THEME=Adwaita
export ANDROID_HOME=$HOME/Android/Sdk

if [ "$(hostname)" = "rDesktop" ]; then
  export XCURSOR_SIZE=24
else
  export XCURSOR_SIZE=48
fi

export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$HOME/.local/bin

if ! tmux run 2>/dev/null; then
  tmux new-session -d -s Default
fi

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec startx
fi
