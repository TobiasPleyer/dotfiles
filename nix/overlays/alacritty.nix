fetchFromGitHubJSON: self: super:
  let nixGL = (import (fetchFromGitHubJSON ../sources/nixGL.json) {}).nixGLIntel;
      alacritty = super.alacritty;
      alacrittyWrapped = 
        super.stdenv.mkDerivation {
          inherit nixGL alacritty;

          name = "alacritty";

          buildCommand = ''
          echo $alacritty
          echo $nixGL
          mkdir -p "$out/bin"
          local wrapper="$out/bin/alacritty"
          echo "#!/usr/bin/sh" > "$wrapper"
          echo "$nixGL/bin/nixGLIntel $alacritty/bin/alacritty \"\$@\"" >> "$wrapper"
          chmod +x "$wrapper"
          '';

          preferLocalBuild = true;

          buildInputs = [ alacritty nixGL ];
          passthru = { unwrapped = alacritty; };

          meta = alacritty.meta // {
            description = "The alacritty binary wrapped with a call to nixGLIntel";
          };
        };
  in
  {
    alacritty = alacrittyWrapped;
  }
