# This includes installation of scripts and downloaded
# things such as SDKMAN! and possibly pnpm

## $PATH-only modifications ##
NEWPATH="$HOME/bin:$HOME/.local/bin"
NEWPATH+=":$HOME/Applications/Postgres.app/Contents/Versions/latest/bin"  # psql
NEWPATH+=":$HOME/.cargo/bin"  # Rust
# Darktable
NEWPATH+=":$HOME/Applications/darktable.app/Contents/MacOS"
# Bun (these scripts have auto-updaters bro)
NEWPATH+=":$HOME/.bun/bin"
export PATH="$NEWPATH:$PATH"
