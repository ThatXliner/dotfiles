export ZSH="$HOME/.oh-my-zsh"
# shellcheck disable=SC2034
# Oh-my-zsh and P10k theme options
ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_MAGIC_FUNCTIONS="true"  # Because URLs are messed up
POWERLEVEL9K_TERM_SHELL_INTEGRATION="true"
# for direnv
export DIRENV_LOG_FORMAT=""

zstyle ':omz:update' frequency 14
zstyle ':omz:update' mode auto
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

### Plugins ###
# Plugin config
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
zstyle ':omz:plugins:nvm' lazy true  # Shaves some time
# Plugin list

# TODO: Cleanup
plugins=(
# You may also use the `add_omz_plugins` or `remove_omz_plugins` functions
# instead (if you don't, please do not remove the
# $OMZ_PLUGIN_LIST_BEGIN and $OMZ_PLUGIN_LIST_END) markers
# >>
abbrev-alias
bun
colored-man-pages
direnv
docker
fzf
gitignore
heroku
mcfly
npm
nvm
pdm
pj
please
pnpm
poetry
pyenv
rakubrew
rust
tabtab
tea
thefuck
wakatime
wasmer
web-search
you-should-use
zoxide
zsh-autosuggestions
zsh-syntax-highlighting
# <<
)

source $ZSH/oh-my-zsh.sh
