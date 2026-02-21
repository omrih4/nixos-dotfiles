{
  pkgs,
  ...
}:
{
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
        nil
        ninja
      ]
    );
  };
}
