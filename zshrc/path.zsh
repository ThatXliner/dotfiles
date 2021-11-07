NEW_PATH="$PYENV_ROOT/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.gem/ruby/2.6.0/bin"  # Add binary stuff
NEW_PATH="$NEW_PATH:$(echo $HOME/.bootstrap/* | sed 's/ /:/g')" # Add bootstraps
NEW_PATH="$NEW_PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"  # Add PostgreSQL stuff
NEW_PATH="$NEW_PATH:$HOME/homebrew/bin"  # Add HomeBrew last
export PATH="$NEW_PATH:$PATH"

eval "$(pyenv init --path)"
