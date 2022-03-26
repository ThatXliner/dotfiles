NEW_PATH="$PYENV_ROOT/bin:$HOME/.pyenv/shims:$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/Library/pnpm"  # Add binary stuff

NEW_PATH="$NEW_PATH:$(echo $HOME/.bootstrap/* | sed 's/ /:/g')" # Add bootstraps
NEW_PATH="$NEW_PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"  # Add PostgreSQL stuff

# @addpath
NEW_PATH+=":$HOME/Applications/MuseScore 3.app/Contents/MacOS"

# Fixing Ruby to use Homebrew Ruby
NEW_PATH="$NEW_PATH:/Users/bryanhu/homebrew/opt/ruby/bin"
export LDFLAGS="-L/Users/bryanhu/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/Users/bryanhu/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/Users/bryanhu/homebrew/opt/ruby/lib/pkgconfig"

NEW_PATH="$NEW_PATH:$HOME/homebrew/bin"  # Add HomeBrew last
export PATH="$NEW_PATH:$PATH"
