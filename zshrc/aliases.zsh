## Overrides ##
alias cat="bat --pager=never"
# `cd='z'` is set in index.zsh, guarded by [[ "$CLAUDECODE" != "1" ]] so it
# doesn't break Claude Code's non-interactive shell (where zoxide's `z` isn't
# loaded). Don't re-add it unguarded here.
# alias ls="ls -G -A"  # -G is the same as --color=auto
alias ls="eza --icons --all --long --no-permissions -o --no-user --no-time --smart-group --git -h"
alias what="\which"
alias which="type"
alias rm="trash"
alias convert="magick"
alias g='/usr/local/bin/github .'
alias docker="podman"
## Helpful utils ##
alias curtime='date -u +%Y-%m-%dT%H:%M:%SZ'
alias pyt2="copier copy gh:ThatXliner/pyt2 . -d author='Bryan Hu' -d username=ThatXliner -d email=thatxliner@gmail.com"
alias unquarantine="xattr -r -d com.apple.quarantine"
alias vact="source .venv/bin/activate"
alias localip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias clean='fd "\.venv|__pycache__|\.turbo|node_modules" --type=directory --exec rm -rf'
alias studio='open "http://127.0.0.1:54323"'
alias clean_zsh='zsh -f'

alias lsusb_messy='ioreg -p IOUSB -l -w 0'
alias lsusb_clean='system_profiler SPUSBDataType'
# alias claude='SHELL=/bin/bash \claude --model claude-opus-4-6'  # Use Opus 4.6 since it's 3x less tokens than 4.7
alias strongclaude='CLUADE_CODE_EFFORT_LEVEL=max CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1 CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude --dangerously-skip-permissions'
alias claudewithdiscord='claude --channels plugin:discord@claude-plugins-official --dangerously-skip-permissions "/notify-me"'
alias commit="claude --dangerously-skip-permissions --print '/x-commit'"
alias load-antidote='source $HOME/.antidote/antidote.zsh'
deepclaude() {
    export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
    export ANTHROPIC_AUTH_TOKEN=$DEEPSEEK_API_KEY
    export ANTHROPIC_MODEL=${ANTHROPIC_MODEL:-deepseek-v4-flash[1m]}
    export ANTHROPIC_DEFAULT_SONNET_MODEL=deepseek-v4-flash[1m]
    export ANTHROPIC_DEFAULT_OPUS_MODEL=deepseek-v4-pro[1m]
    export ANTHROPIC_SUBAGENT_MODEL=deepseek-v4-flash[1m]
    export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
    claude "/model $ANTHROPIC_MODEL" $@
}
deepclaudepro() {
    export ANTHROPIC_MODEL=deepseek-v4-pro[1m]
    deepclaude $@
}

alias gm='git commit -m '

gsw() {
  local current_branch=$(git rev-parse --abbrev-ref HEAD)
  local new_branch="$1"
  local stash_name="autostash:$current_branch"

  # Check if there are any changes (tracked or untracked)
  if [ -n "$(git status --porcelain)" ]; then
    echo "Stashing changes on branch $current_branch..."
    git stash push -m "$stash_name" -u
  fi

  echo "Switching to branch $new_branch..."
  git switch "$new_branch"

  # Check if there's a stash for the target branch
  local target_stash="autostash:$new_branch"
  local stash_match=$(git stash list | grep "$target_stash")

  if [ -n "$stash_match" ]; then
    echo "Popping stash for branch $new_branch..."
    git stash pop $(git stash list | grep "$target_stash" | cut -d: -f1)
  else
    echo "No matching stash for branch $new_branch."
  fi
}
_gsw() {
    _values 'branches' $(git branch --format='%(refname:short)' | tr '\n' ' ')
}
compdef _gsw gsw


# c() {
#     # if [[ -z "$1" ]]; then
#     #     code .
#     # elif [[ -d "$1" ]]; then
#     #     code "$1"
#     # elif [[ -f "$1" ]]; then
#     #     code "$(dirname "$1")"
#     # else
#     #     code .
#     # fi
#     vscode=("$HOME/Developer/Spaceless/VCAssist" "$HOME/Developer/Spaceless/FRC/WarriorDashboard")
#     intellij=("$HOME/Developer/Spaceless/FRC")

#     # Get the current working directory
#     current_dir=$(pwd)

#     # Check if the current directory is a subdirectory of any in the list
#     for dir in $vscode; do
#       if [[ $current_dir == $dir/* || $current_dir == $dir ]]; then
#         code .
#         return
#       fi
#     done
#     for dir in $intellij; do
#       if [[ $current_dir == $dir/* || $current_dir == $dir ]]; then
#         idea .
#         return
#       fi
#     done
#     zed .
# }
alias c="zed ."


sed_escape() {
    echo "$1" | sed  's/\//\\\//g'
}
rg_replace() {
    rg "$1" --files-with-matches -0 | xargs -0 sed -i '' "s/$1/$(sed_escape $2)/g"
}

cpp() {
    clang++ "$@" --std=c++11 && ./a.out
}
docker-kill-all() {
    docker kill $(docker ps -q)
}
reversedns() {
    { dig -x $1 +short | rg ".+(?=\.)" -o --pcre2 --color=never } || nslookup $1
}
makeitwork() {
    chmod +x $1  # Make it executable
    if [[ "$OSTYPE" == "darwin"* ]]
    then
        unquarantine $1  # Unquarantine
    fi
}
dns() {
    dig $1 +short
}
whos_using_port() {
    lsof -i:$1 -P
}
## Potentially useful utils ##
t() {
    fd "$@" | tree --fromfile
}
extract () {
  if [ -f "${1}" ] ; then
    case $1 in
      *.tar.bz2)  tar xjf    "${1}"    ;;
      *.tar.gz)   tar xzf    "${1}"    ;;
      *.bz2)      bunzip2    "${1}"    ;;
      *.rar)      rar x      "${1}"    ;;
      *.gz)       gunzip     "${1}"    ;;
      *.tar)      tar xf     "${1}"    ;;
      *.tbz2)     tar xjf    "${1}"    ;;
      *.tgz)      tar xzf    "${1}"    ;;
      *.zip)      unzip      "${1}"    ;;
      *.Z)        uncompress "${1}"    ;;
      *)      echo "Unknown file type" ;;
    esac
  else
    echo "Can't access ${1}"
  fi
}
notify () {
    echo "\x1b]9;$*\x07"
}
focus () {
    echo "\x1b]1337;StealFocus\x07"
}
## Git aliases ##
# Fun fact: apparently if you name an executable file
# git-* (let's say... git-{{ this }})
# and add it to your $PATH,
# When you run `git {{ this }}`, it'll run that file
# There's also a git config option to add aliases
alias gitbd="git branch -d"
alias gitcb="git checkout -b"
# "finish merge": pull current, switch to the default branch, pull it, then
# delete the branch we came from. A branch is safe to delete when the default
# branch already contains everything it added. Two independent signals decide
# this, so squash- and rebase-merged branches (whose commits aren't ancestors
# of the default branch) are still cleaned up, while genuinely unmerged work is
# kept:
#   1. remote-gone: the branch's upstream was pruned (PR merged & deleted on
#      the remote), or
#   2. content-merged: 3-way merging the branch into the default branch yields
#      the default branch's tree unchanged — i.e. it introduces nothing new.
gitfm() {
  local def cur base merged tree gone
  autoload -Uz colors && colors

  # Don't pull cur first — we're about to leave it, and if its upstream was
  # deleted (PR merged) the pull just errors noisily. Refresh def instead.
  def=$(git remote show origin | awk '/HEAD branch/ {print $NF}')
  cur=$(git branch --show-current)
  git checkout "$def" || return 1
  git fetch --prune && git pull || return 1
  if [ "$cur" = "$def" ] || [ -z "$cur" ]; then
    echo "${fg[blue]}gitfm: already on the default branch — nothing to delete${fg[default]}"
    return 0
  fi

  # Signal 1: upstream pruned => PR merged & branch deleted on remote.
  gone=""
  if git rev-parse --verify --quiet "$cur@{upstream}" >/dev/null 2>&1; then :; else
    # No upstream resolvable now; if it once tracked one, prune marked it gone.
    git branch -vv | grep -qE "^[ *]+${cur//./\\.} .*: gone\]" && gone=1
  fi

  # Signal 2: content already in def. 3-way merge cur into def; if the merged
  # tree equals def's current tree, cur introduces nothing new (covers squash &
  # rebase merges, and is immune to def having advanced).
  merged=""
  tree=$(git merge-tree --write-tree "$def" "$cur" 2>/dev/null)
  if [ -n "$tree" ] && [ "$(git rev-parse "$tree^{tree}" 2>/dev/null)" = "$(git rev-parse "$def^{tree}")" ]; then
    merged=1
  fi

  if [ -n "$gone" ] || [ -n "$merged" ]; then
    local why=""
    [ -n "$gone" ] && why="upstream pruned"
    [ -n "$merged" ] && why="${why:+$why, }content already in $def"
    echo "${bg[green]}${fg[black]} ✓ ${fg[default]}${bg[default]}${fg[green]} $cur merged ($why) — deleting${fg[default]}"
    git branch -D "$cur"
  else
    echo "${bg[red]}${fg[black]} ✗ ${fg[default]}${bg[default]}${fg[red]} $cur has content not in $def — NOT deleting${fg[default]}"
    echo "${fg[yellow]}  unmerged changes:${fg[default]}"
    git diff "$def...$cur" --stat
  fi
}
alias gitp="git pull"
alias gitpf="git push --force-with-lease"
