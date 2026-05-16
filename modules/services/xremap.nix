{ inputs, ... }:
{
  flake.modules.nixos.xremap =
    { ... }:
    {
      imports = [ inputs.xremap-flake.nixosModules.default ];

      services.xremap = {
        enable = true;
        withGnome = true;
        serviceMode = "user";
        config.keymap = [
          {
            name = "Terminals";
            application.only = [
              "com.mitchellh.ghostty"
              "dev.zed.Zed"
            ];
            remap = {
              "Alt_L-v" = "Ctrl-Shift-v";
              "Alt_L-c" = "Ctrl-Shift-c";
            };
          }
          {
            name = "GUI apps";
            application.not = [
              "com.mitchellh.ghostty"
              "dev.zed.Zed"
            ];
            remap = {
              "Alt_L-c" = "Ctrl-c";
              "Alt_L-v" = "Ctrl-v";
              "Alt_L-x" = "Ctrl-x";
              "Alt_L-z" = "Ctrl-z";
              "Alt_L-Shift-z" = "Ctrl-y";
              "Alt_L-a" = "Ctrl-a";
              "Alt_L-s" = "Ctrl-s";
              "Alt_L-w" = "Ctrl-w";
              "Alt_L-t" = "Ctrl-t";
              "Alt_L-f" = "Ctrl-f";
              "Alt_L-l" = "Ctrl-l";
              "Alt_L-n" = "Ctrl-n";
              "Alt_L-q" = "Alt-F4";
            };
          }
        ];
      };
    };
}
