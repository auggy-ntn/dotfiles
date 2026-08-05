# Login-shell config for zsh.
#
# zsh does NOT read ~/.profile, so without this file a login zsh (which is
# what Alacritty spawns: `zsh --login`) would get its environment only by
# accident, from ~/.zshrc duplicating it.

[ -f "$HOME/.config/shell/env.sh" ] && . "$HOME/.config/shell/env.sh"
