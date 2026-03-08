{
  config,
  lib,
  pkgs,
  ...
}:

{
  nix.package = pkgs.lixPackageSets.stable.lix;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # Enable access to epomaker keyboard
  services.udev.extraRules = ''KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"'';

  services.usbmuxd.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };

  programs.virt-manager.enable = true;

  virtualisation.docker.enable = true;
  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  time.timeZone = "Asia/Jerusalem";

  services.getty.autologinUser = "omrih";

  services.flatpak.enable = true;

  programs.seahorse.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = true;

  services.tailscale.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  programs.gamemode.enable = true;

  services.libinput.enable = true;
  users.users.omrih = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "libvirtd"
      "docker"
      "gamemode"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget

    uv
    nodejs
    nodePackages.pnpm

    wineWow64Packages.stable
    protontricks

    dnsmasq

    # Allow mounting iphone
    libimobiledevice
  ];
  environment.localBinInPath = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      (pkgs.runCommand "steamrun-lib" { } "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
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
