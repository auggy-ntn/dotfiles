# Created by newuser for 5.9

# 0. Initialize Completion System
autoload -Uz compinit
compinit

# 1. Plugins syntax & autocompletion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh # autosuggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # syntax highlighting


##### Packages and Plugins #####

# 1. fzf (fuzzy finder)
source <(fzf --zsh) # Set up fzf key bindings and fuzzy completion
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/.fzfrc"

# 2. Atuin (history manager)
eval "$(atuin init zsh --disable-ctrl-r)" # Initialise Atuin

# 3. Starship (prompt) 
eval "$(starship init zsh)"

# 4. zoxide (better cd)
eval "$(zoxide init --cmd cd zsh)" # The --cmd cd flag is to replace the default cd with zoxide
export _ZO_FZF_OPTS='--preview "ls -la $(echo {} | cut -f2-)"' # Preview variable for cdi


################################


# 2. Command at launch
if ! [[ "$TERM_PROGRAM" == "vscode" ]];
then
	eval fastfetch
fi

# 3. Keyboard bindings
bindkey '^[[1;5D' backward-word # Ctrl + Left arrow
bindkey '^[[1;5C' forward-word # Ctrl + Right arrow
bindkey '^H' backward-kill-word # Ctrl + Backspace

# 4. Aliases
alias update_and_clean='sudo dnf upgrade --refresh && sudo dnf autoremove && sudo dnf clean all'
alias fullupdate='sudo dnf upgrade --refresh && flatpak update -y' # Update from Flatpak and dnf repos

# File system
if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
  alias lsz='/usr/bin/ls -Z'
fi

# 5. Environment variables
export EDITOR="code"
