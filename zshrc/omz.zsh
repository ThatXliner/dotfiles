export ZSH="/Users/bryanhu/.oh-my-zsh"

# Oh-my-zsh options
ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

zstyle ':omz:update' frequency 14
zstyle ':omz:update' mode auto
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

### Plugins ###
# Plugin config
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export NVM_LAZY=1  # Shaves some time
# Plugin list

# TODO: Cleanup
plugins=(
# DO NOT MANUALLY EDIT THIS LIST!!
# Use `add_omz_plugins` or `remove_omz_plugins` instead
# >>
git
pyenv
zsh-autosuggestions
nvm
npm
poetry
pj
zoxide
rust
thefuck
docker
zsh-syntax-highlighting
# <<
)

source $ZSH/oh-my-zsh.sh
