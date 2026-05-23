# This includes installation of scripts and downloaded
# things such as SDKMAN! and possibly pnpm

## $PATH-only modifications ##
NEWPATH="$HOME/bin:$HOME/.local/bin"
NEWPATH+=":$HOME/Applications/Postgres.app/Contents/Versions/latest/bin"  # psql
NEWPATH+=":$HOME/.cargo/bin"  # Rust
# JetBrains Toolbox
NEWPATH+=":$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
# Docker binaries
NEWPATH+=":$HOME/.docker/bin"
# Julia
NEWPATH+=":$HOME/.juliaup/bin"
# Darktable & RawTherapee
NEWPATH+=":$HOME/Applications/darktable.app/Contents/MacOS"
NEWPATH+=":/Applications/RawTherapee.app/Contents/MacOS"
# Bun (these scripts have auto-updaters bro)
NEWPATH+=":$HOME/.bun/bin"
# Wasmer
export WASMER_DIR="$HOME/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
export PATH="$NEWPATH:$PATH"
