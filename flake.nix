{
  description = "Project template with the logo-design Claude Code skill";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    logo-design-skill = {
      url = "github:kaankiziltug/logo-design-skill";
      flake = false;
    };
  };

  outputs = { nixpkgs, logo-design-skill, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          # The skill's scripts are standard-library Python; render_png.py uses
          # the first renderer it finds (cairosvg, rsvg-convert, ...).
          packages = [
            (pkgs.python3.withPackages (ps: [ ps.cairosvg ]))
            pkgs.librsvg
          ];

          # Link the skill into the project's .claude/skills (gitignored).
          shellHook = ''
            root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
            mkdir -p "$root/.claude/skills"
            ln -sfn ${logo-design-skill}/skills/logo-design "$root/.claude/skills/logo-design"
          '';
        };
      });
    };
}
