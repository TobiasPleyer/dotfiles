let
  bootstrap_pkgs = import <nixpkgs> {};
  ormolu =
    let
      source = bootstrap_pkgs.fetchFromGitHub {
        owner = "tweag";
        repo = "ormolu";
        rev = "fc64eada5c4da7a5b07d2872e253671b48aec115";
        sha256 = "1pn5nydxsz4kip60cmlcf0k4w6nf1b699dsamp26w47cjfrfax0b";
      };
    in import source { pkgs = bootstrap_pkgs; };
  ormolu_overlay = self: super:
    {
      haskell = super.haskell // {
        packages = super.haskell.packages // {
          "${ormolu.ormoluCompiler}" = super.haskell.packages.${ormolu.ormoluCompiler}.override {
            overrides = ormolu.ormoluOverlay;
          };
        };
      };
    };
  pkgs = import <nixpkgs> { overlays = [ ormolu_overlay ]; };
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
        version = "2020-02-18";
        src = fetchFromGitHub {
          owner = "TobiasPleyer";
          repo = "vim-text-utils";
          rev = "7f1dfb5d8e6fb5722434e6db1909ffddff1ee7ac";
          sha256 = "1hc7m0yapi9bf1kdv4hgqwl7nhl13yxjic8qxaiykqipd64v48m4";
        };
      };
      pss = vimUtils.buildVimPluginFrom2Nix {
        pname = "pss";
        version = "2018-09-21";
        src = fetchFromGitHub {
          owner = "bernh";
          repo = "pss.vim";
          rev = "902076331b27a59213d1973a29a018ecf7d35652";
          sha256 = "0wiq0zdp9zwdkigsav41vjpwj4az752igp5mpybgckfqr1z0pjjk";
        };
      };
      vim-ormolu = vimUtils.buildVimPluginFrom2Nix {
        pname = "vim-ormolu";
        version = "2020-01-18";
        src = fetchFromGitHub {
          owner = "sdiehl";
          repo = "vim-ormolu";
          rev = "4ae4fe11c558af33030abdeda6f2ee1f5b54da55";
          sha256 = "13yn0arxcn8ngc91lvhcqs3nl17zcdmgsw522qvqgn732cpf0ddy";
        };
      };
      matchit = vimUtils.buildVimPluginFrom2Nix {
        pname = "matchit";
        version = "2011-09-11";
        src = fetchFromGitHub {
          owner = "tmhedberg";
          repo = "matchit";
          rev = "060d9d8aa381d6a650b649d38c992b59db3ed1a3";
          sha256 = "0ky5qbimdwprdmy9n93shyrs2a41vfgm9yj7v2q2db3zfsvpynld";
        };
      };
      neoterm = vimUtils.buildVimPluginFrom2Nix {
        pname = "neoterm";
        version = "2020-11-05";
        src = fetchFromGitHub {
          owner = "kassio";
          repo = "neoterm";
          rev = "78461935fcd6888c02e4368126a2cb645b80816e";
          sha256 = "07szw3jd5vj4sxzmrdalk79pdba7cm0c7k3rvn5bw4lyjgzml7ll";
        };
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
              "ctrlp"
              "lushtags"
              "matchit"
              "nerdtree"
              "neoterm"
              "syntastic"
              "tabular"
              "tagbar"
              "text-utils"
              "vim-elm-syntax"
              "vim-hoogle"
              "vim-one"
              "vim-ormolu"
              #"vim-hindent"
              #"vim-stylish-haskell"
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
        cabal2nix
        cabal-install
        #hasktasks
        #lushtags
        hlint
        #hindent
        myHaskell
        myTexlive
        myNeovim
        #nodejs-12_x
        obelisk
        pkgs.haskell.packages.${ormolu.ormoluCompiler}.ormolu
        #stylish-haskell
        #taffybar
      ];
    });
  }
