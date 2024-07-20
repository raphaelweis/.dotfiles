export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=adwaita-dark

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
	exec Hyprland
fi
