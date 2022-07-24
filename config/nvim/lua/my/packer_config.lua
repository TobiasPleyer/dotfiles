return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"

  use { "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  --use { "nvim-telescope/telescope-rs.nvim" }
  --use { "nvim-telescope/telescope-fzf-writer.nvim" }
  --use { "nvim-telescope/telescope-file-browser.nvim" }

  use "romainl/vim-qf"

  use "folke/zen-mode.nvim"
  use "folke/twilight.nvim"

  use { "elzr/vim-json", ft = "json" }

  -- Cool tags based viewer
  --   :Vista  <-- Opens up a really cool sidebar with info about file.
  --use { "liuchengxu/vista.vim", cmd = "Vista" }

  -- Find and replace
  use "windwp/nvim-spectre"

  use "pechorin/any-jump.vim"

  -- TEXT MANIUPLATION
  use "godlygeek/tabular" -- Quickly align text by pattern
  use "tpope/vim-repeat" -- Repeat actions better
  use "tpope/vim-abolish" -- Cool things with words!

  use { "AndrewRadev/splitjoin.vim", keys = { "gJ", "gS" } }

  use "tpope/vim-surround" -- Surround text objects easily

  use "TimUntersberger/neogit"

  -- Floating windows are awesome :)
  use { "rhysd/git-messenger.vim", keys = "<Plug>(git-messenger)" }

  use "ThePrimeagen/harpoon"

  use { "junegunn/fzf", run = "./install --all" }
  use { "junegunn/fzf.vim" }

  use "kyazdani42/nvim-web-devicons"
  use "yamatsum/nvim-web-nonicons"

  use { "neovimhaskell/haskell-vim", ft = "haskell" }
  use "kassio/neoterm"
  use "jremmen/vim-ripgrep"
  use "jlanzarotta/bufexplorer"
  use { "neoclide/coc.nvim", branch = "release" }
  use "junegunn/gv.vim"
  use "junegunn/seoul256.vim"
  use "vim-airline/vim-airline"
  use "vim-airline/vim-airline-themes"
  use "tpope/vim-fugitive"
  use "tpope/vim-vinegar"
  use "Twinside/vim-hoogle"
  use "liuchengxu/vim-which-key"
  use "gruvbox-community/gruvbox"
  use "rakr/vim-one"
  use "altercation/vim-colors-solarized"
  use { "sdiehl/vim-ormolu", lock = true }
  use { "/home/tobias/plugins/bufexplorer.nvim" }
end)
