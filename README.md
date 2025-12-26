# Dotfiles

## Setup

```
stow .
touch ~/.config/hypr/hyprland-machine-specific.conf
```

## Setup default fonts

`/etc/fonts/local.conf`:

```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>

  <!-- Default Sans Serif -->
  <alias>
    <family>sans-serif</family>
    <prefer>
      <family>Roboto</family>
    </prefer>
  </alias>

  <!-- Default Serif -->
  <alias>
    <family>serif</family>
    <prefer>
      <family>Roboto Serif</family>
    </prefer>
  </alias>

  <!-- Default Monospace -->
  <alias>
    <family>monospace</family>
    <prefer>
      <family>JetBrainsMonoNL Nerd Font</family>
    </prefer>
  </alias>

</fontconfig>
```
