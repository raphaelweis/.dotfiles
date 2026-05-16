{
  self,
  ...
}:
{
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      # system
      boot
      user
      locale
      bluetooth
      security
      nix-ld
      qt
      nix
      networking-shared
      networking
      flatpak
      docker

      # desktop / services
      gnome
      xremap

      # programs
      steam
      zsh
      vscode
      spotify
      excalidraw
      cmdline-pkgs
      gui-pkgs

      # desktop environment
      fonts
      cursor
      xdg

      # misc
      sops
      nextcloud
    ];
  };
}
