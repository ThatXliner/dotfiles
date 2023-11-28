# This includes installation of scripts and downloaded
# things such as SDKMAN! and possibly pnpm

## $PATH-only modifications ##
NEWPATH="$HOME/.bin:$HOME/.local/bin"
NEWPATH+=":/Applications/Postgres.app/Contents/Versions/latest/bin"  # psql
# Bun and globally installed tools using Bun
NEWPATH+=":$HOME/.bun/bin"
# pnpm installation
# (JS tools should only be installed via Bun)
export PNPM_HOME="$HOME/Library/pnpm"
NEWPATH+=":$PNPM_HOME"
export PATH="$NEWPATH:$PATH"

## Scripts ##

# SDKMAN!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
