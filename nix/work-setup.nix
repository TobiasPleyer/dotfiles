let
  bootstrap_pkgs = import <nixpkgs> {};
  fetchFromGitHubJSONGen = pkgs: jsonPath:
    let jsonInfo = pkgs.lib.importJSON jsonPath;
    in pkgs.fetchFromGitHub {inherit (jsonInfo) owner repo rev sha256;};
  fetchFromGitHubJSON = fetchFromGitHubJSONGen bootstrap_pkgs;
  pkgs = import <nixpkgs> { overlays = [
           ((import ./overlays/neovim.nix) fetchFromGitHubJSON)
           ((import ./overlays/alacritty.nix) fetchFromGitHubJSON)
           ]; };
  ormolu = (import (fetchFromGitHubJSON ./sources/ormolu.json) {inherit pkgs; ormoluCompiler = "ghc865";}).ormolu;
in
  with pkgs;
  rec {
    setPrio = num: drv: lib.addMetaAttrs { priority = num; } drv;

    myTexlive = texlive.combine {
      inherit (texlive)
      babel
      filecontents
      graphics
      makecell
      pdfx
      scheme-small
      siunitx
      symbol
      tools
      wasy
      #wasy2-ps
      wasysym
      xcolor
      xmpincl;
      };

    myVimPlugins = vimPlugins // {
      text-utils = vimUtils.buildVimPluginFrom2Nix {
        pname = "text-utils";
        version = "master";
        src = fetchFromGitHubJSON ./sources/text-utils.json;
      };
      matchit = vimUtils.buildVimPluginFrom2Nix {
        pname = "matchit";
        version = "master";
        src = fetchFromGitHubJSON ./sources/matchit.json;
      };
      neoterm = vimUtils.buildVimPluginFrom2Nix {
        pname = "neoterm";
        version = "master";
        src = fetchFromGitHubJSON ./sources/neoterm.json;
      };
      vim-ormolu = vimUtils.buildVimPluginFrom2Nix {
        pname = "vim-ormolu";
        version = "master";
        src = fetchFromGitHubJSON ./sources/vim-ormolu.json;
      };
      vim-ripgrep = vimUtils.buildVimPluginFrom2Nix {
        pname = "vim-ripgrep";
        version = "master";
        src = fetchFromGitHubJSON ./sources/vim-ripgrep.json;
      };
    };

    myNeovim = neovim.override {
      configure = {
        customRC = import ./vimrc.nix;
        vam.knownPlugins = myVimPlugins;
        vam.pluginDictionaries = [
          { names = [ 
              "bufexplorer"
              "coc-nvim"
              "dhall-vim"
              "haskell-vim"
              "fzf-vim"
              "goyo-vim"
              "limelight-vim"
              "lushtags"
              "matchit"
              "neoterm"
              "nerdtree"
              "plenary-nvim"
              "popup-nvim"
              "rust-vim"
              "tabular"
              "nvim-treesitter"
              "telescope-fzy-native-nvim"
              "telescope-nvim"
              "text-utils"
              "vim-abolish"
              "vim-airline"
              "vim-airline-themes"
              "vim-elm-syntax"
              "vim-fugitive"
              "gv-vim"
              "vim-go"
              "vim-hoogle"
              "vim-javascript"
              "vim-ormolu"
              "vim-ripgrep"
              "vim-vinegar"
              "vim-which-key"
              #colors
              "gruvbox-community"
              "seoul256-vim"
              "vim-colors-solarized"
              "vim-one"
            ];
          }
        ];
      };
    };

    myHaskell = haskellPackages.ghcWithPackages (
      pkgs: with pkgs; [ 
        containers
        hasktags
        text
        xmonad
        xmonad-contrib
    ]);

    devEnv = setPrio 4 (pkgs.buildEnv { 
      name = "dev-env";
      ignoreCollisions = true;
      paths = [
        alacritty
        fzf
        nix-prefetch-github
        ripgrep
        ormolu
        #myHaskell
        #myTexlive
        myNeovim
      ];
    });
  }
