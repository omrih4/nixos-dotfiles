{
  inputs,
  config,
  pkgs,
  ...
}:

let
  fluxer = import ./apps/fluxer.nix { inherit pkgs; };
in
{
  home.username = "omrih";
  home.homeDirectory = "/home/omrih";
  home.stateVersion = "25.11";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nix btw";
      nixos-switch = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/omrih/nixos-dotfiles#laptop";
    };
    profileExtra = ''
      start-hyprland
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''${builtins.readFile ./config/hypr/hyprland.conf}'';
  };
  catppuccin.hyprland.enable = true;
  programs.starship.enable = true;

  programs.direnv.enable = true;
  home.packages = with pkgs; [
    vesktop
    prismlauncher
    jetbrains.idea-oss
    inputs.helium.packages.x86_64-linux.default
    zoom-us
    moonlight-qt
    blockbench
    vlc
    termius

    fluxer

    davinci-resolve
  ];

  programs.obs-studio = {
    enable = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (
      ps: with ps; [
        clang
        clang-tools
        llvm
        lld
        cmake
        nixfmt
        nixd
        ninja
      ]
    );
  };
}
