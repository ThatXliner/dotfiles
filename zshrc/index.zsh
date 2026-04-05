# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export __DOTFILES_ZSH_DIR="${0:h}"
## $PATH modifications ##
source $__DOTFILES_ZSH_DIR/path.zsh
## Constant configuration ##
source $__DOTFILES_ZSH_DIR/constants.zsh
## Plugin configuration ##
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export FZF_DEFAULT_COMMAND=fd
export ZSH_CACHE_DIR=$HOME/.config/zsh  # For Oh-my-zsh plugins that write to cache
# The vast majority of people don't use mise
setopt interactivecomments  # Zsh configuration
bindkey -e  # Emacs keybindings

# For oh-my-zsh-style completion plugins
mkdir -p $ZSH_CACHE_DIR/completions
fpath+=($ZSH_CACHE_DIR/completions)
## Autoloads ##
# For colored-man-pages and using the color
# functions (such as fg_bold) in general
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
## Load plugins ##
# Static bundle — regenerate with: antidote bundle < zsh-plugins.txt > zsh-plugins.zsh
source $__DOTFILES_ZSH_DIR/zsh-plugins.zsh
## Completion style ##
source $__DOTFILES_ZSH_DIR/completion.zsh
## Aliases ##
source $__DOTFILES_ZSH_DIR/aliases.zsh
## Miscellaneous ##
# I might put these in a separate repo
# and package them as ZSH plugins for Antidote
# to manage
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
