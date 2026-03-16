{
  lib,
  config,
  ...
}: {
  imports = [
    ./core.nix
    ./theme.nix
    ./lsp.nix
    ./formatting.nix
    ./autocomplete.nix
    ./languages.nix
    ./plugins
  ];
  programs.nvf.enable = true;
}
