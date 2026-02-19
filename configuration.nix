{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  time.timeZone = "Asia/Jerusalem";

  services.getty.autologinUser = "omrih";

  services.flatpak.enable = true;

  services.nixos-cli.enable = true;

  programs.seahorse.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = true;

  services.tailscale.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true;

  programs.steam = {
    enable = true;
  };
  
  services.xserver.videoDrivers = [
    "modesettings"
    "nvidia"
  ];
  hardware = {
    graphics.enable = true;
    nvidia = {
      open = true;
      prime = {
        offload.enable = true;
	offload.enableOffloadCmd = true;

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  services.libinput.enable = true;
  users.users.omrih = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    kitty

    # Shell
    quickshell
    noctalia-shell
    # waybar
    hyprpaper
    mako
    rofi
    hyprpolkitagent

    xterm

    pwvucontrol

    grim
    slurp
    wl-clipboard

    gh
    git

    uv
    mongodb-compass
    nodejs
    nodePackages.pnpm

    wineWow64Packages.stable
    protontricks

    # Themes
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    kdePackages.breeze.qt5
    kdePackages.breeze
  ];
  environment.localBinInPath = true;
  programs.nix-ld = {
	enable = true;
	libraries = with pkgs; [
		(pkgs.runCommand "steamrun-lib" {} "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
	];
  };

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  programs.java.enable = true;
  programs.java.package = pkgs.javaPackages.compiler.temurin-bin.jdk-25;

  services.mongodb.enable = true;
  services.mongodb.package = pkgs.mongodb-ce;

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.fira-code
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.11"; # Did you read the comment?
}
