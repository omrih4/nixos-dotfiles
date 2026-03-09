{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );
  };
  home.packages = with pkgs; [
    v4l-utils
  ];
}
