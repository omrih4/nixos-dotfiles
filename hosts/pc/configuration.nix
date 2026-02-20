{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Import a host-specific hardware config (copy/adjust of generated file).
  imports = [ 
    ./hardware-configuration.nix
    ../../global.nix
  ];

  networking.hostname = "pc";

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
}
