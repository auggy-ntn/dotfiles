# Common Configuration

Machine-independent config: shell, CLI tooling, editors, agents. Nothing here assumes Omarchy, Hyprland, Wayland, or this specific hardware — this package should stow cleanly onto any Linux box.

Machine-specific config lives in a sibling package (currently only [`omarchy`](../omarchy/README.md)). Both stow into `~` and coexist.

## Contents

```
common/
├── .zshrc                          # primary interactive shell config
├── .zprofile                       # login zsh — zsh never reads .profile
├── .profile                        # login sh/dash
├── .bash_profile                   # login bash
└── .config/
    ├── shell/env.sh                # PATH + tool env, shared by bash AND zsh
                                    #   ^ add new exports HERE, nowhere else
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
    ├── Code/User/{settings,keybindings,mcp}.json
    └── Code/extensions.txt          # VS Code extension list (repo-only, not stowed)
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

## Post-install steps

Two things stow cannot do for you:

```bash
# 1. Make zsh the login shell (prompts for your password)
chsh -s /usr/bin/zsh

# 2. Restore VS Code extensions
xargs -n1 code --install-extension < ~/dotfiles/common/.config/Code/extensions.txt
```

Refresh the extension list after installing new ones:

```bash
code --list-extensions > ~/dotfiles/common/.config/Code/extensions.txt
```

## Shell startup, in order

```
login zsh     →  .zprofile  →  .zshrc   ─┐
login bash    →  .bash_profile → .bashrc ├→  .config/shell/env.sh
login sh      →  .profile             ───┘
```

`env.sh` is idempotent and the only place PATH is touched. An interactive bash
that starts anyway `exec`s into zsh (see `omarchy/.bashrc`); bypass with
`BASH_TO_ZSH=1 bash`.

## Caveats

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
