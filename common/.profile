# POSIX login-shell config (sh, dash, and bash when no ~/.bash_profile exists).
# zsh does NOT read this file — see ~/.zprofile.

[ -f "$HOME/.config/shell/env.sh" ] && . "$HOME/.config/shell/env.sh"
