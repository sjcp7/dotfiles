{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      coc-sh coc-html coc-css coc-json coc-eslint
      coc-solargraph coc-rust-analyzer
    ];

    coc = {
      enable = true;
      settings = {
        languagueserver = {
          ccls = {
            command = "ccls";
            filetypes = [ "c" "cpp" "cuda" "objc" "objcpp" ];
            rootPatterns = [ ".ccls-root" "compile_commands.json" ];
            initializationOptions = {
              cache = {
                directory = ".ccls-cache";
              };

              client = {
                snippertSupport = true;
              };
            };
          };

        };

      };

    };

    # these are installed globally
    # extraPackages = with pkgs; [
    #   nodejs
    #   rubyPackages.solargraph
    #   rust-analyzer
    #   ccls
    # ];



  };
}
