{
  config,
  lib,
  pkgs,
  ...
}: {
  # Import a host-specific hardware config (copy/adjust of generated file).
  imports = [
    ./hardware-configuration.nix
    ../../global.nix
  ];

  networking.hostName = "pc";

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
    openFirewall = true;
  };
  # needed for sunshine input
  hardware.uinput.enable = true;

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = true;
}
