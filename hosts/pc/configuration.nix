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

  boot.kernelParams = ["drm.edid_firmware=HDMI-A-1:edid/EDID.bin" "video=HDMI-A-1:1920x1080@120D"];
  hardware.firmware = [
    (
      pkgs.runCommand "EDID.bin" {} ''
        mkdir -p $out/lib/firmware/edid
        cp ${./EDID.bin} $out/lib/firmware/edid/EDID.bin
      ''
    )
  ];

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
