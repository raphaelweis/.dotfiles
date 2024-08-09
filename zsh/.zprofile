export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=adwaita-dark
export MOZ_USE_XINPUT2=1
export XCURSOR_THEME=Adwaita
export XCURSOR_SIZE=48


export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$HOME/.local/bin

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
	exec startx
fi
