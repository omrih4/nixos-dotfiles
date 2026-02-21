{
  config,
  osConfig,
  ...
}:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nix btw";
      nixos-switch = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/dotfiles#${osConfig.networking.hostName}";
    };
    profileExtra = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        start-hyprland
      fi
    '';
  };
  programs.direnv.enable = true;
  programs.starship.enable = true;
}
