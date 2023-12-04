# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/.antidote/antidote.zsh
export __DOTFILES_ZSH_DIR="${0:h}"
## Autoloads ##
# For colored-man-pages and using the color
# functions (such as fg_bold) in general
autoload -Uz colors && colors
## $PATH modifications ##
source $__DOTFILES_ZSH_DIR/path.zsh
## Constant configuration ##
source $__DOTFILES_ZSH_DIR/constants.zsh
## Plugin configuration ##
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export FZF_DEFAULT_COMMAND=fd
export PIPX_DEFAULT_PYTHON=$HOME/.asdf/installs/python/3.11.6/bin/python
export ZSH_CACHE_DIR=$HOME/.config/zsh  # For Oh-my=zsh plugins that write to cache
# For oh-my-zsh-style completion plugins
mkdir -p $ZSH_CACHE_DIR/completions
fpath+=($ZSH_CACHE_DIR/completions)
# Uncommenting this incurs a performance penalty, but may be necessary
autoload -Uz compinit && compinit
zstyle ':antidote:bundle' file $__DOTFILES_ZSH_DIR/zsh-plugins.txt
## Load plugins ##
antidote load
## Completion style ##
source $__DOTFILES_ZSH_DIR/completion.zsh
## Aliases ##
source $__DOTFILES_ZSH_DIR/aliases.zsh
## Miscellaneous ##
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
