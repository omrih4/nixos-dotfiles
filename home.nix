{
  inputs,
  config,
  osConfig,
  pkgs,
  ...
}:

{
  imports = [ ./modules/default.nix ];

  home.username = "omrih";
  home.homeDirectory = "/home/omrih";
  home.stateVersion = "25.11";
}
