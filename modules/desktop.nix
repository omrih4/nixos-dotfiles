{ pkgs, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = "${builtins.readFile ../config/hypr/hyprland.conf}";
  };
  catppuccin.hyprland.enable = true;
  home.packages = with pkgs; [
    # Terminals
    xterm
    termius

    # Shell
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Themes
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    kdePackages.breeze.qt5
    kdePackages.breeze

    # Screenshot utilities
    grim
    slurp

    wl-clipboard
    cliphist

    fastfetch

    pwvucontrol
    
    vlc
  ];
}
