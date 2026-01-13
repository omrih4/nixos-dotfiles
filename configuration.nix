{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jerusalem";

  services.getty.autologinUser = "omrih";

  services.flatpak.enable = true;

  services.nixos-cli.enable = true;

  services.gnome.gnome-keyring.enable = true;

  programs.hyprland = {
	enable = true;
	xwayland.enable = true;
	withUWSM = true;
  };
	
  programs.steam = {
	enable = true;
  };

  services.xserver.videoDrivers = ["modesettings" "nvidia" ];
  hardware = {
	graphics.enable = true;
	nvidia = {
		open = true;
		prime = {
			offload.enable = true;

			intelBusId = "PCI:0:2:0";
			nvidiaBusId = "PCI:1:0:0";
		};
	};
  };

  services.libinput.enable = true;
  users.users.omrih = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
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
    waybar
    git
    hyprpaper
    mako
    rofi
    pwvucontrol
    grim
    slurp
    wl-clipboard
    gh
    mongodb-compass
    hyprpolkitagent
  ];

  programs.java.enable = true;
  programs.java.package = pkgs.javaPackages.compiler.temurin-bin.jdk-25;

  services.mongodb.enable = true;
  services.mongodb.package = pkgs.mongodb-ce;

  fonts.packages = with pkgs; [
	font-awesome
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
 system.stateVersion = "25.11"; # Did you read the comment?
}

