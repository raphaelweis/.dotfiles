{ inputs, ... }:
{
  flake.modules.nixos.gui-pkgs =
    { pkgs, ... }:
    {
      environment.systemPackages =
        with pkgs;
        [
          pavucontrol
          postman
          nautilus
          quickshell
          netflix
          chromium
          google-chrome
          thunderbird
          zed-editor
          zathura
          keepassxc
          ghostty
          modrinth-app
          (callPackage ../packages/helium.nix { })
        ]
        ++ [
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
    };
}
