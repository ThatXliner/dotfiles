# This includes installation of scripts and downloaded
# things such as SDKMAN! and possibly pnpm

## $PATH-only modifications ##
NEWPATH="$HOME/.bin:$HOME/.local/bin"
NEWPATH+=":/Applications/Postgres.app/Contents/Versions/latest/bin"  # psql
NEWPATH+=":$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
NEWPATH+=":$HOME/.cargo/bin"  # Rust
NEWPATH+=":$HOME/.gem/ruby/2.6.0/bin"  # macOS default Ruby
# Bun and globally installed tools using Bun
NEWPATH+=":$HOME/.bun/bin"
# pnpm installation
# (JS tools should only be installed via Bun)
export PNPM_HOME="$HOME/Library/pnpm"
NEWPATH+=":$PNPM_HOME"
# JetBrains Toolbox
NEWPATH+=":$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
export PATH="$NEWPATH:$PATH"

## Scripts ##

# asdf-direnv
export DIRENV_LOG_FORMAT=""
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
# I don't know the relationship between asdf and direnv
# but I'm guessing it's pretty complicated (just like me and K!)

# SDKMAN!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
