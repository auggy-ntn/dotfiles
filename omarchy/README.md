# Omarchy Configuration

This directory contains configuration files specifically tailored for **Omarchy** - an opinionated Arch Linux installation with Hyprland as the window manager.

## About Omarchy

Omarchy is a custom Arch Linux setup optimized for:
- **Hyprland** - Modern, fast tiling window manager
- **Wayland** - Modern display protocol
- **Performance** - Minimal, efficient configurations
- **Developer Experience** - Tools for coding, version control, containerization

This configuration package includes all the dotfiles needed to replicate this setup on an Arch Linux system.

## Contents

```
omarchy/
├── .bashrc                   # Bash shell configuration
├── .zshrc                    # Zsh shell configuration
├── .config/
│   ├── alacritty/           # GPU-accelerated terminal emulator
│   ├── btop/                # System resource monitor
│   ├── fastfetch/           # System information tool
│   ├── fontconfig/          # Font rendering configuration
│   ├── hypr/                # Hyprland window manager config
│   ├── lazydocker/          # Docker TUI client
│   ├── lazygit/             # Git TUI client
│   ├── starship.toml        # Shell prompt configuration
│   ├── walker/              # Application launcher
│   ├── waybar/              # Wayland status bar
│   ├── brave-flags.conf     # Brave browser launch flags
│   ├── chromium-flags.conf  # Chromium browser launch flags
│   ├── user-dirs.dirs       # XDG user directory definitions
│   └── user-dirs.locale     # User locale settings
└── README.md                # This file
```

## Installation

### Prerequisites

Ensure you have the following installed on your Arch system:
- `stow` - symlink farm manager
- `zsh` - shell (or modify `.bashrc` section if using bash only)
- `git` - version control

Install prerequisites:

```bash
sudo pacman -S stow zsh git
```

### Setup Steps

1. Clone or navigate to your dotfiles repository:

```bash
cd ~/.dotfiles
```

2. Install the omarchy configuration:

```bash
stow -d . -t ~ omarchy
```

This creates symlinks for all configuration files from the `omarchy` directory to your home directory.

3. Verify installation:

```bash
# Check that symlinks were created
ls -la ~/.config/hypr
ls -la ~/.bashrc
ls -la ~/.zshrc
```

## Workflow

### Installing the Configuration

```bash
cd ~/.dotfiles
stow -d . -t ~ omarchy
```

### Making Changes

1. Edit configuration files directly in `~/.config/`, `~/.bashrc`, etc.
2. These changes are automatically reflected in the repository (since they're symlinks)
3. Commit changes to git:

```bash
cd ~/.dotfiles
git add .
git commit -m "Update configuration"
git push
```

### Updating the Configuration

After pulling changes from the repository:

```bash
cd ~/.dotfiles
git pull
stow -d . -t ~ -R omarchy  # Restow to refresh symlinks
```

### Temporarily Disabling the Configuration

To remove all symlinks without deleting the actual configuration files:

```bash
cd ~/.dotfiles
stow -d . -t ~ -D omarchy
```

Your actual configuration files remain in `~/.dotfiles/omarchy/` and can be restored by restowing.

### Re-enabling the Configuration

```bash
cd ~/.dotfiles
stow -d . -t ~ omarchy
```

## Common Stow Commands for Omarchy

From the dotfiles directory:

```bash
# Install omarchy configuration
stow -d . -t ~ omarchy

# Remove omarchy configuration
stow -d . -t ~ -D omarchy

# Restow (refresh all symlinks)
stow -d . -t ~ -R omarchy

# Simulate/preview changes (dry run)
stow -d . -t ~ --simulate omarchy
```

### Handy Aliases

Add these to your shell config for quicker stow management:

```bash
# For omarchy
alias stow-omarchy='stow -d ~/.dotfiles -t ~ omarchy'
alias unstow-omarchy='stow -d ~/.dotfiles -t ~ -D omarchy'
alias restow-omarchy='stow -d ~/.dotfiles -t ~ -R omarchy'
```

## Customization

Feel free to customize configurations to match your preferences:

1. Edit files in their respective directories
2. Changes take effect immediately for most applications
3. Some applications (like Hyprland) may need to be restarted
4. Shell configuration changes require reloading the shell (`exec $SHELL`)

## Applications Included

- **Shell**: Zsh with Starship prompt
- **Terminal**: Alacritty (GPU-accelerated)
- **Window Manager**: Hyprland (tiling Wayland WM)
- **Status Bar**: Waybar
- **Application Launcher**: Walker
- **System Monitor**: Btop
- **System Info**: Fastfetch
- **Git Client**: Lazygit (TUI)
- **Docker Client**: Lazydocker (TUI)
- **Browsers**: Brave, Chromium

## Notes

- Configurations are symlinked, not copied, so edits are reflected in the repository
- Always test changes before committing to avoid breaking your system
- Some configurations may require specific packages to be installed
- Hyprland-specific configs require Hyprland and Wayland dependencies

## Troubleshooting

### Stow conflicts

If you get conflicts when running stow (e.g., file exists), you have options:

```bash
# See what would happen (dry run)
stow -d . -t ~ --simulate omarchy

# Force overwrite (use carefully!)
stow -d . -t ~ --adopt omarchy
```

### Symlinks not working

Verify symlinks are created:

```bash
ls -la ~/.config/hypr
ls -la ~/.bashrc
```

If they're regular files instead of symlinks, remove them and restow:

```bash
cd ~/.dotfiles
rm -rf ~/.config/hypr ~/.bashrc ~/.zshrc
stow -d . -t ~ omarchy
```

### Changes not taking effect

Some applications cache configurations:

- **Shell**: Run `exec $SHELL` or restart terminal
- **Hyprland**: Reload with `$mod + Shift + R`
- **Waybar**: Run `pkill -SIGUSR1 waybar` or restart
