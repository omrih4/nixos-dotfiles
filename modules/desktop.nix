{ pkgs, config, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    systemd.variables = ["--all"];
    extraConfig = "${builtins.readFile ../config/hypr/hyprland.conf}";
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk 
      xdg-desktop-portal-hyprland
    ];
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

    libnotify

    wl-clipboard
    cliphist

    fastfetch

    pwvucontrol
    
    vlc
  ];
}
