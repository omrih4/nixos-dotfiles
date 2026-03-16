{pkgs, ...}: {
  programs.nvf.settings.vim = {
    startPlugins = with pkgs.vimPlugins; [
      telescope-ui-select-nvim
    ];

    telescope = {
      enable = true;
      setupOpts = {
        extensions = {
          "ui-select" = {};
        };
      };
    };

    # Load the ui-select extension
    luaConfigRC.telescope-ui-select = ''
      require("telescope").load_extension("ui-select")
    '';
  };
}
