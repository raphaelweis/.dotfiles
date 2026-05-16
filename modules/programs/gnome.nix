{
  flake.modules.nixos.gnome =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = with pkgs; [
        nautilus
        gnomeExtensions.appindicator
        gnomeExtensions.just-perfection
        gnomeExtensions.xremap
      ];

      services = {
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
        gvfs.enable = true;
        udev.packages = [ pkgs.gnome-settings-daemon ];
        gnome = {
          core-apps.enable = true;
          gnome-online-accounts.enable = true;
          gnome-keyring.enable = true;
        };
      };

      environment.sessionVariables = {
        QT_QPA_PLATFORM = "wayland;xcb";
        NIXOS_OZONE_WL = 1;
      };

      programs.dconf = {
        enable = true;
        profiles.user.databases = [
          {
            settings = {
              "org/gnome/shell" = {
                enabled-extensions = with pkgs.gnomeExtensions; [
                  appindicator.extensionUuid
                  just-perfection.extensionUuid
                  xremap.extensionUuid
                ];
                favorite-apps = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
              };
              "org/gnome/shell/app-switcher" = {
                current-workspace-only = true;
              };
              "org/gnome/desktop/input-sources" = {
                sources = [
                  (pkgs.lib.gvariant.mkTuple [
                    "xkb"
                    "us+intl"
                  ])
                ];
              };
              "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
                show-battery-percentage = true;
                enable-hot-corners = false;
                accent-color = "green";
              };
              "org/gnome/desktop/peripherals/mouse" = {
                accel-profile = "flat";
              };
              "org/gnome/shell/keybindings" = {
                "show-screenshot-ui" = [ "<Shift><Super>s" ];
                "screenshot" = [ "Print" ];
                "toggle-overview" = [ "<Alt>space" ];
                "switch-to-application-1" = [ "" ];
                "switch-to-application-2" = [ "" ];
                "switch-to-application-3" = [ "" ];
                "switch-to-application-4" = [ "" ];
                "switch-to-application-5" = [ "" ];
                "switch-to-application-6" = [ "" ];
                "switch-to-application-7" = [ "" ];
                "switch-to-application-8" = [ "" ];
                "switch-to-application-9" = [ "" ];
              };
              "org/gnome/settings-daemon/plugins/media-keys" = {
                custom-keybindings = [
                  "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
                ];
              };
              "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
                binding = "<Super>e";
                command = "nautilus --new-window";
                name = "Nautilus";
              };
              "org/gnome/desktop/background" = {
                color-shading-type = "solid";
                picture-options = "zoom";
                picture-uri = "file://${../../assets/the_solo_traveller_wallpaper.png}";
                picture-uri-dark = "file://${../../assets/the_solo_traveller_wallpaper.png}";
                primary-color = "#241f31";
                secondary-color = "#000000";
              };
              "org/gnome/mutter" = {
                dynamic-workspaces = false;
              };
              "org/gnome/desktop/wm/preferences" = {
                num-workspaces = "10";
              };
              "org/gnome/desktop/wm/keybindings" = {
                switch-to-workspace-1 = [ "<Super>1" ];
                switch-to-workspace-2 = [ "<Super>2" ];
                switch-to-workspace-3 = [ "<Super>3" ];
                switch-to-workspace-4 = [ "<Super>4" ];
                switch-to-workspace-5 = [ "<Super>5" ];
                switch-to-workspace-6 = [ "<Super>6" ];
                switch-to-workspace-7 = [ "<Super>7" ];
                switch-to-workspace-8 = [ "<Super>8" ];
                switch-to-workspace-9 = [ "<Super>9" ];
                switch-to-workspace-10 = [ "<Super>0" ];
                move-to-workspace-1 = [ "<Shift><Super>1" ];
                move-to-workspace-2 = [ "<Shift><Super>2" ];
                move-to-workspace-3 = [ "<Shift><Super>3" ];
                move-to-workspace-4 = [ "<Shift><Super>4" ];
                move-to-workspace-5 = [ "<Shift><Super>5" ];
                move-to-workspace-6 = [ "<Shift><Super>6" ];
                move-to-workspace-7 = [ "<Shift><Super>7" ];
                move-to-workspace-8 = [ "<Shift><Super>8" ];
                move-to-workspace-9 = [ "<Shift><Super>9" ];
                move-to-workspace-10 = [ "<Shift><Super>0" ];
                switch-applications = [ "" ];
                switch-applications-backward = [ "" ];
                switch-windows = [ "<Alt>Tab" ];
                switch-windows-backward = [ "<Shift><Alt>Tab" ];
              };
              "org/gnome/shell/extensions/just-perfection" = {
                workspace-popup = false;
              };
            };
          }
        ];
      };
    };
}
