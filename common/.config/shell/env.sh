# Shared shell environment — sourced by bash and zsh alike.
#
# Single source of truth for PATH additions and tool env files. Everything
# here must be POSIX-compatible, and must stay safe to source more than once.
#
# Sourced from: ~/.zshrc, ~/.zprofile, ~/.bashrc, ~/.profile, ~/.bash_profile

# uv / Python tooling (installs to ~/.local/bin)
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# LM Studio CLI (lms)
case ":$PATH:" in
  *":$HOME/.lmstudio/bin:"*) ;;
  *) [ -d "$HOME/.lmstudio/bin" ] && PATH="$PATH:$HOME/.lmstudio/bin" ;;
esac

export PATH
