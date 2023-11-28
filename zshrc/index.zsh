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
export ZSH_CACHE_DIR=$HOME/.config/zsh  # For Oh-my=zsh plugins that write to cache
# For oh-my-zsh-style completion plugins
mkdir -p $ZSH_CACHE_DIR/completions
zstyle ':antidote:bundle' file $__DOTFILES_ZSH_DIR/zsh-plugins.txt
## Load plugins ##
antidote load
## Completion style ##
source $__DOTFILES_ZSH_DIR/completion.zsh
# autoload -Uz compinit && compinit
# # See https://github.com/mattmc3/antidote/issues/24
# # or else completion-definers (such as the asdf plugin)
# # won't work
# autoload -Uz compinit
# ZSH_COMPDUMP=$HOME/.zcompdump

# # cache .zcompdump for about a day
# if [[ $ZSH_COMPDUMP(#qNmh-20) ]]; then
#   compinit -C -d "$ZSH_COMPDUMP"
# else
#   compinit -i -d "$ZSH_COMPDUMP"; touch "$ZSH_COMPDUMP"
# fi
# {
#   # compile .zcompdump
#   if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
#     zcompile "$ZSH_COMPDUMP"
#   fi
# } &!
## Aliases ##
source $__DOTFILES_ZSH_DIR/aliases.zsh
## Miscellaneous ##
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# # Run cached prompt
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
#
# # Activate the primitive requisites
# source "$__DOTFILES_ZSH_DIR/constants.zsh"  # Very critical stuff
# source "$__DOTFILES_ZSH_DIR/path.zsh"  # Compiler flags, $PATH, etc
# # Activate the juicy stuff
# source "$__DOTFILES_ZSH_DIR/omz.zsh"  # Oh-my-zsh configuration
# source "$__DOTFILES_ZSH_DIR/aliases.zsh"  # My aliases and functions and chwpd hook lol

# # Add nnn stuff
# source "$__DOTFILES_ZSH_DIR/nnn-config.zsh"

# # rm -rf $HOME/temp  # TODO: Make cron tab
# rm -rf $HOME/.pylint.d

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# unalias _

# export PATH="$(echo $HOME/.nvm/versions/node/*$(cat ~/.nvm/alias/default)*/bin):$PATH"
# alias rm="trash"

# # THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!


# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
