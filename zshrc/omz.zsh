export ZSH="/Users/bryanhu/.oh-my-zsh"

# Oh-my-zsh options
ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
export UPDATE_ZSH_DAYS=13

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins
# TODO: Cleanup
plugins=(
    git
    pyenv
    zsh-syntax-highlighting
    zsh-autosuggestions
    nvm
    npm
    poetry
    pipx
    pj
    zoxide
    rustup
    cargo
    thefuck
    gh
    # zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh
