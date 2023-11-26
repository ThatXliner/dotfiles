# This includes installation of scripts and downloaded
# things such as SDKMAN! and possibly pnpm

## $PATH-only modifications ##
NEWPATH="$HOME/.bin:$HOME/.local/bin"
NEWPATH+=":/Applications/Postgres.app/Contents/Versions/latest/bin"  # psql
NEWPATH+=":$HOME/homebrew/bin"  # Add Homebrew last
NEWPATH+=":$HOME/Library/pnpm"
export PATH="$NEWPATH:$PATH"

## Scripts ##

# SDKMAN!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
