# Common Configuration

Machine-independent config: shell, CLI tooling, editors, agents. Nothing here assumes Omarchy, Hyprland, Wayland, or this specific hardware — this package should stow cleanly onto any Linux box.

Machine-specific config lives in a sibling package (currently only [`omarchy`](../omarchy/README.md)). Both stow into `~` and coexist.

## Contents

```
common/
├── .zshrc                          # primary interactive shell config
└── .config/
    ├── git/{config,ignore}         # aliases, rebase-on-pull, rerere, histogram diffs
    ├── tmux/tmux.conf              # C-Space prefix, vi copy mode
    ├── atuin/config.toml           # shell history
    ├── mise/config.toml            # runtime version pins
    ├── gh/config.yml               # GitHub CLI (hosts.yml holds the token — NOT tracked)
    ├── micro/bindings.json         # TUI editor keybindings
    ├── starship.toml               # shell prompt
    ├── .fzfrc                      # fuzzy finder
    ├── btop/btop.conf              # system monitor (themes/current.theme ignored by stow)
    ├── lazygit/config.yml
    ├── lazydocker/config.yml
    ├── fontconfig/fonts.conf
    └── Code/User/{settings,keybindings,mcp}.json
└── .claude/                        # Claude Code
    ├── settings.json               # model, hooks, plugins, statusline
    ├── CLAUDE.md, RTK.md           # global instructions
    └── skills/spaced-repetition-learning/
```

## Install

```bash
cd ~/dotfiles
stow -d . -t ~ --simulate -v common   # ALWAYS dry-run first
stow -d . -t ~ common
```

Restow after a `git pull` (picks up newly added files):

```bash
stow -d . -t ~ -R common
```

## Dependencies

Expected on PATH for `.zshrc` to work fully:

```
zsh zsh-autosuggestions zsh-syntax-highlighting
starship atuin zoxide fzf eza bat fastfetch
```

Plus, for the rest of the package: `tmux git gh mise micro btop lazygit lazydocker`.

On Arch: `sudo pacman -S zsh zsh-autosuggestions zsh-syntax-highlighting starship atuin zoxide fzf eza bat fastfetch tmux git github-cli mise micro btop lazygit`

## Caveats

- **`.zshrc` sources the zsh plugins by absolute Arch path** (`/usr/share/zsh/plugins/...`). Other distros place them elsewhere; those two `source` lines are unguarded and will error on shell start.
- **`.zshrc` still carries Fedora `dnf` aliases** (`update_and_clean`, `fullupdate`) — dead on Arch.
- **`btop.conf` sets `color_theme = "current"`**, which resolves to an Omarchy-managed theme file. Elsewhere btop falls back to its default theme; harmless.
- **`.claude/settings.json` is rewritten by Claude Code itself.** If it ever replaces the symlink with a real file, restow.
- **No secrets are tracked.** SSH keys and `gh` `hosts.yml` are deliberately excluded and must be provisioned per machine.

## Excluded from this package

`.stow-local-ignore` (regexes, not globs) skips:

| Pattern | Why |
|---|---|
| `\.config/btop/themes/current\.theme` | Theme-manager owned |
| `README\.md` | This file |

> A package ignore file **replaces** Stow's built-in defaults rather than adding to them — which is why `README\.md` has to be listed explicitly.
