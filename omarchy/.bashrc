# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# Zsh is the shell of record. If an interactive bash starts anyway (a terminal
# with a hardcoded bash, a tool spawning $SHELL before chsh took effect, a
# recovery console), hand over to zsh rather than sitting in a bare shell.
#
# Guarded three ways: only interactive, only if zsh exists, and only once —
# BASH_TO_ZSH stops any chance of a loop.
#
# To get a real bash on purpose:  BASH_TO_ZSH=1 bash
if [[ -z "$BASH_TO_ZSH" ]] && command -v zsh &> /dev/null; then
  export BASH_TO_ZSH=1
  exec zsh
fi

# --- below here only runs if zsh is unavailable or was explicitly bypassed ---

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
[[ -f ~/.local/share/omarchy/default/bash/rc ]] && source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

# PATH additions and tool env files are shared with zsh — edit that file, not this one.
[[ -f "$HOME/.config/shell/env.sh" ]] && source "$HOME/.config/shell/env.sh"
