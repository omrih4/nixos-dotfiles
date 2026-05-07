{
  pkgs,
  config,
  osConfig,
  ...
}: {
  programs.bash = {
    enable = true;
    shellAliases = {
      "jarvis," = "sudo";

      btw = "echo i use nix btw";

      ls = "${pkgs.eza}/bin/eza";
      l = "${pkgs.eza}/bin/eza -lah";
      ll = "${pkgs.eza}/bin/eza -l";
      la = "${pkgs.eza}/bin/eza -a";
      lt = "${pkgs.eza}/bin/eza --tree";
      lla = "${pkgs.eza}/bin/eza -la";
    };
    profileExtra = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        start-hyprland
      fi
    '';
    bashrcExtra = ''export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"'';
  };
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";
    settings = {
      background_opacity = 0.5;
      dynamic_background_opacity = "yes";
    };
  };

  programs.direnv.enable = true;
  programs.starship.enable = true;

  programs.btop.enable = true;
  catppuccin = {
    kitty.enable = true;
    btop.enable = true;
  };

  home.packages = with pkgs; [
    eza
  ];
}
