{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = "${builtins.readFile ../config/hypr/hyprland.conf}";
  };
  catppuccin.hyprland.enable = true;
  home.packages = with pkgs; [
    # Terminals
    kitty
    xterm
    termius

    # Shell
    quickshell
    noctalia-shell

    hyprpolkitagent

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

    pwvucontrol
    
    vlc
  ];
}
