{
  inputs,
  pkgs,
  ...
}: let
  fluxer = import ./fluxer.nix {inherit pkgs;};
in {
  imports = [
    ./desktop.nix
    ./shell.nix
    ./obs.nix
    ./vim
    ./vscode.nix
    ./games.nix
  ];

  home.packages = with pkgs; [
    inputs.helium.packages.x86_64-linux.default

    gh
    mongodb-compass
    jetbrains.idea

    equibop

    blockbench

    zoom-us
    moonlight-qt

    qbittorrent

    fluxer

    kdePackages.kdenlive
    davinci-resolve
  ];
}
