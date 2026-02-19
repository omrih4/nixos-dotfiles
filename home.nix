{
  inputs,
  config,
  pkgs,
  ...
}:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    hypr = "hypr";
    waybar = "waybar";
  };

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
      nixos-switch = "sudo nixos-rebuild switch --flake /home/omrih/nixos-dotfiles#laptop";
    };
    profileExtra = ''
     			start-hyprland
            		'';
  };
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

  systemd.user.timers."wallpaper" = {
    Install.WantedBy = [ "timers.target" ];
    Timer = {
      OnCalendar = [
        "06:00"
        "18:00"
      ];
      Persistent = true;
      Unit = "wallpaper.service";
    };
  };

  systemd.user.services."wallpaper" = {
    Install.WantedBy = [ "default.target" ];
    Service = {
      Type = "oneshot";
      ExecStart = "/home/%u/nixos-dotfiles/config/hypr/wallpaper.sh";
    };
  };

  programs.obs-studio = {
    enable = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );
  };

  services.ludusavi.enable = true;

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
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
