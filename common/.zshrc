# Created by newuser for 5.9

# -1. Set cursor (beam)
precmd() { echo -ne '\e[5 q' }  # Beam cursor

# 0. Initialize Completion System
autoload -Uz compinit
compinit

# 1. Plugins syntax & autocompletion
# Paths differ per distro (Arch: /usr/share/zsh/plugins, Debian: /usr/share,
# Fedora: /usr/share/zsh-*), so try each and skip silently if absent.
for plugin_dir in /usr/share/zsh/plugins /usr/share /usr/local/share; do
  [[ -f "$plugin_dir/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] \
    && source "$plugin_dir/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    && break
done
for plugin_dir in /usr/share/zsh/plugins /usr/share /usr/local/share; do
  [[ -f "$plugin_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] \
    && source "$plugin_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    && break
done
unset plugin_dir


##### Packages and Plugins #####

# Each block is guarded so a machine missing the tool still gets a working
# shell instead of an error on every prompt.

# 1. fzf (fuzzy finder)
if command -v fzf &> /dev/null; then
  source <(fzf --zsh) # Set up fzf key bindings and fuzzy completion
  export FZF_DEFAULT_OPTS_FILE="$HOME/.config/.fzfrc"
fi

# 2. Atuin (history manager)
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh --disable-ctrl-r)" # Initialise Atuin
fi

# 3. Starship (prompt)
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# 4. zoxide (better cd)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init --cmd cd zsh)" # The --cmd cd flag is to replace the default cd with zoxide
  export _ZO_FZF_OPTS='--preview "ls -la $(echo {} | cut -f2-)"' # Preview variable for cdi
fi


################################


# 2. Command at launch
if ! [[ "$TERM_PROGRAM" == "vscode" ]] && command -v fastfetch &> /dev/null; then
	fastfetch
fi


# 3. Keyboard bindings
# Ctrl + Arrow keys to skip words
bindkey "^[[1;5C" forward-word      # Ctrl + Right
bindkey "^[[1;5D" backward-word     # Ctrl + Left

# Ctrl + Delete to delete word forward
bindkey "^[[3;5~" kill-word         # Ctrl + Delete

# Ctrl + Backspace to delete word backward
bindkey "^H" backward-kill-word     # Ctrl + Backspace


# 4. Aliases

# System update. Uses yay when present (covers the AUR too), pacman otherwise.
if command -v yay &> /dev/null; then
  alias update='yay -Syu'
  alias update_and_clean='yay -Syu && yay -Yc && yay -Sc --noconfirm'  # -Yc drops orphans, -Sc trims the package cache
else
  alias update='sudo pacman -Syu'
  alias update_and_clean='sudo pacman -Syu && sudo pacman -Rns $(pacman -Qtdq) ; sudo pacman -Sc --noconfirm'
fi

# Everything: repos/AUR, then Flatpak.
if command -v flatpak &> /dev/null; then
  alias fullupdate='update_and_clean && flatpak update -y && flatpak uninstall --unused -y'
else
  alias fullupdate='update_and_clean'
fi

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

# PATH additions and tool env files live in one place, shared with bash.
# Add new exports there, not here.
[[ -f "$HOME/.config/shell/env.sh" ]] && source "$HOME/.config/shell/env.sh"

