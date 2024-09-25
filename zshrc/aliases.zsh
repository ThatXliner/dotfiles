## Overrides ##
alias cat="bat --pager=never"
alias cd='z'
alias docker='podman'
# alias ls="ls -G -A"  # -G is the same as --color=auto
alias ls="eza --icons --all --long --no-permissions -o --no-user --no-time --smart-group --git -h"
alias what="\which"
alias which="type"
alias rm="trash"
alias convert="magick"
alias g='/usr/local/bin/github .'
## Helpful utils ##
alias curtime='date -u +%Y-%m-%dT%H:%M:%SZ'
alias pyt2="copier copy gh:ThatXliner/pyt2 . -d author='Bryan Hu' -d username=ThatXliner -d email=thatxliner@gmail.com"
alias unquarantine="xattr -r -d com.apple.quarantine"
alias vact="source .venv/bin/activate"
alias localip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias clean='fd "\.venv|__pycache__|\.turbo|node_modules" --type=directory --exec rm -rf'

alias clean_zsh='zsh -f'

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
  git checkout "$new_branch"

  # Check if there's a stash for the target branch
  local target_stash="autostash:$new_branch"
  local stash_match=$(git stash list | grep "$target_stash")

  if [ -n "$stash_match" ]; then
    echo "Popping stash for branch $new_branch..."
    git stash pop $(git stash list | grep -n "$target_stash" | cut -d: -f1)
  else
    echo "No matching stash for branch $new_branch."
  fi
}

c() {
    if [[ "$(pwd)" == /Users/bryanhu/projects/Spaceless/FRC* ]]; then
        code .
    else
        zed .
    fi
}
# Bibbity bobbity your alias is now my property
# (from https://github.com/ajeetdsouza/zoxide/issues/34#issuecomment-2099442403)
zf () {
  cd $(zoxide query --list --score | fzf --height 40% --layout reverse --info inline --border --preview "eza --all --group-directories-first --header --long --no-user --no-permissions --color=always {2}" --no-sort | awk '{print $2}')
}

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
alias gitfm='git pull; git checkout $(git remote show origin | awk "/HEAD branch/ {print \$NF}") && git pull && git branch -d @{-1} && git checkout $(git remote show origin | awk "/HEAD branch/ {print \$NF}")'
alias gitp="git pull"
alias gitpf="git push --force-with-lease"
