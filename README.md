# Dotfiles Repository

This repository contains my personal configuration files (dotfiles) organized by installation profiles. Each directory represents a complete configuration set for a specific system setup, managed with GNU Stow for easy symlink management.

## Overview

This repository uses **GNU Stow** to manage dotfiles. Stow creates symlinks from configuration files in this repository to their target locations in your home directory, making it easy to version control and manage multiple configuration profiles.

## Structure

The repository is organized into directories, each representing a complete configuration profile:

```
dotfiles/
├── omarchy/                  # Omarchy Setup - Arch Linux + Hyprland configuration
├── .stow-local-ignore        # Stow ignore patterns
└── README.md                 # This file
```

Each profile directory contains the full directory structure mirroring your home directory (e.g., `.config/`, `.bashrc`, `.zshrc`).

## Quick Start

Clone this repository:

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

For specific installation instructions for each profile, see the README in that profile's directory:

- **[Omarchy Setup](./omarchy/README.md)** - Arch Linux + Hyprland configuration

## GNU Stow Basics

**Stow** is a symlink farm manager. It reads the directory structure in each package and creates corresponding symlinks in the target directory (your home).

### Common Stow Commands

From the dotfiles directory:

```bash
# Install a package (create symlinks)
stow -d <source-directory> -t <target-directory> <package-name>

# Uninstall a package (remove symlinks)
stow -d <source-directory> -t <target-directory> -D <package-name>

# Restow a package (delete and recreate symlinks)
stow -d <source-directory> -t <target-directory> -R <package-name>

# Check what would be created (dry run)
stow -d <source-directory> -t <target-directory> --simulate <package-name>
```

Where:
- `-d .` specifies the stow directory (current directory)
- `-t ~` specifies the target directory (home directory)
- `-D` means delete/uninstall
- `-R` means restow (delete then reinstall)
- `--simulate` shows changes without applying them

### Adding New Dotfiles

1. Create the directory structure within a package folder mirroring your home directory
2. Move or copy the config file to the appropriate location
3. Run `stow -d <source-directory> -t <target-directory> <package-name>` to create symlinks

### Removing Dotfiles

```bash
stow -d <source-directory> -t <target-directory> -D <package-name>
```

