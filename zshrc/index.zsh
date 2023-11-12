# Run cached prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export __DOTFILES_ZSH_DIR="${0:h}"
# Activate the primitive requisites
source "$__DOTFILES_ZSH_DIR/constants.zsh"  # Very critical stuff
source "$__DOTFILES_ZSH_DIR/path.zsh"  # Compiler flags, $PATH, etc
# Activate the juicy stuff
source "$__DOTFILES_ZSH_DIR/omz.zsh"  # Oh-my-zsh configuration
source "$__DOTFILES_ZSH_DIR/aliases.zsh"  # My aliases and functions and chwpd hook lol

# Add nnn stuff
source "$__DOTFILES_ZSH_DIR/nnn-config.zsh"

# rm -rf $HOME/temp  # TODO: Make cron tab
rm -rf $HOME/.pylint.d

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
unalias _

export PATH="$(echo $HOME/.nvm/versions/node/*$(cat ~/.nvm/alias/default)*/bin):$PATH"
alias rm="trash"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
