#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Login-shell environment. Sourced after .bashrc, which returns early when
# non-interactive — so a non-interactive login bash still gets its PATH.
[ -f "$HOME/.config/shell/env.sh" ] && . "$HOME/.config/shell/env.sh"
