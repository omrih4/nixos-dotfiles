{
  inputs,
  pkgs,
  ...
}:
let
  fluxer = import ./fluxer.nix { inherit pkgs; };
in
{
  imports = [
    ./desktop.nix
    ./obs.nix
    ./bash.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    inputs.helium.packages.x86_64-linux.default

    gh
    mongodb-compass
    jetbrains.idea

    vesktop

    prismlauncher
    blockbench

    zoom-us
    moonlight-qt

    fluxer

    davinci-resolve
  ];
}
