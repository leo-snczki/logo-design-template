# logo-design-template

A project with the [logo-design](https://github.com/kaankiziltug/logo-design-skill) Claude Code skill and the Python tools its scripts use.

Template repository: create a project from it with **Use this template** on
GitHub, then:

```sh
direnv allow   # or: nix develop
claude
```

The devShell links the skill from the Nix store into `.claude/skills/`
(gitignored). The input follows the skill repo's main branch: the `flake.lock`
that `nix develop` creates pins the commit, and `nix flake update` moves it.
To stay on a release, add its tag to the input URL in `flake.nix`.

