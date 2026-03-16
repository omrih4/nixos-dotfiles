{pkgs, ...}: {
  programs.nvf.settings.vim = {
    languages = {
      enableFormat = true;
      enableTreesitter = true;

      nix.enable = true;
      java.enable = true;
    };
    comments = {
      comment-nvim.enable = true;
    };
  };
}
