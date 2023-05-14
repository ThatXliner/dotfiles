# TODO: Organize this one-liner
NEW_PATH="$PYENV_ROOT/bin:$HOME/.pyenv/shims:$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin"  # Add binary stuff

NEW_PATH="$NEW_PATH:$(echo $HOME/.bootstrap/* | sed 's/ /:/g')" # Add bootstraps
NEW_PATH="$NEW_PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"  # Add PostgreSQL stuff

# @addpath
NEW_PATH+=":$HOME/Library/Python/3.11/bin"
NEW_PATH+=":$HOME/Library/Python/3.10/bin"
NEW_PATH+=":$HOME/Applications/MuseScore 3.app/Contents/MacOS"
NEW_PATH+=":$(ls -d $HOME/Applications/Julia-*)/Contents/Resources/julia/bin"

# Fixing Ruby to use Homebrew Ruby
NEW_PATH="$NEW_PATH:$HOME/homebrew/opt/ruby/bin"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
NEW_PATH="$PNPM_HOME:$NEW_PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
NEW_PATH="$BUN_INSTALL/bin:$NEW_PATH"

# deno
export DENO_INSTALL="$HOME/.deno"
NEW_PATH="$DENO_INSTALL/bin:$NEW_PATH"

# Rakubrew
export RAKUBREW_HOME="$HOME/.rakubrew"

# Wasmtime
export WASMTIME_HOME="$HOME/.wasmtime"
NEW_PATH="$WASMTIME_HOME/bin:$NEW_PATH"

export LDFLAGS="-L$HOME/homebrew/opt/ruby/lib"
export CPPFLAGS="-I$HOME/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="$HOME/homebrew/opt/ruby/lib/pkgconfig"

NEW_PATH="$NEW_PATH:$HOME/homebrew/bin"  # Add HomeBrew last
export PATH="$NEW_PATH:$PATH"
