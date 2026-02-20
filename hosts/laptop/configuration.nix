{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../global.nix
  ];

  networking.hostName = "laptop";

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
}
