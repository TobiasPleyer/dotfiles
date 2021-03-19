fetchFromGitHubJSON: self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: {
      src = fetchFromGitHubJSON ../sources/neovim.json;
      version = "nightly";
      cmakeFlags = old.cmakeFlags ++ [
          "-DTreeSitter_INCLUDE_DIR=${self.tree-sitter}/include"
          "-DTreeSitter_LIBRARY=${self.tree-sitter}/lib/libtree-sitter.so.0.0"
        ];
    });
}
