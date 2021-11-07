# THE LARGE WALL OF ALIASES >:)
# TODO: Clean up
alias gitpf="git push --force-with-lease"
alias gits="git status"
alias gitb="git branch"
alias gitbd="git branch -d"
alias gitch="git checkout"
alias gitm="git checkout master"
alias gitcb="git checkout -b"
alias gitf="git fetch"
alias gitfm='git pull; git checkout master && git pull && git branch -d @{-1} && git checkout master'
alias gitp="git pull --ff-only || echo \"FAST FORWARD FAILED: REBASING\" && git pull --rebase || { echo \"REBASING FAILED: STASHING\" && git stash && git pull --rebase && git stash pop } && echo \"DONE\""
alias gitl="git log"
alias neofetch="curl -s https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch | bash"
alias publicip='curl http://ipecho.net/plain; echo'
alias sha256="shasum -a 256"
alias ipip="pipx inject ipython"
alias atomd="/usr/local/bin/atom ."
alias ls="ls -Ga"
alias pyenv="CFLAGS=\"-I$(brew --prefix xz)/include\" LDFLAGS=\"-L$(brew --prefix xz)/lib\" PYTHON_CONFIGURE_OPTS=\"--enable-framework\" pyenv"
alias cd..='cd ..'
alias cd='z'
alias rldr='tldr'
alias wihc='which'
alias zrc="atom ${0:h}"
alias szrc="omz reload"
alias vact="source .venv/bin/activate"
alias cat="bat --pager=never"
alias code="codium"

notify () {
    echo "\x1b]9;$*\x07"
}
focus () {
    echo "\x1b]1337;StealFocus\x07"
}
pjs() {
    pjo $1
    pj $1
}
_pjs () {
    emulate -L zsh

    typeset -a projects
    for basedir ($PROJECT_PATHS); do
        projects+=(${basedir}/*(/N))
    done

    compadd ${projects:t}
}
compdef _pjs pjs

update_custom_git() {for i in *; do {{ cd $i && git pull > /dev/null 2 &> 1; cd - } &}; done; wait}
targz() {
  d="${1}"
  if [ -d "${d}" ]
  then
    if [ $(stat -f --printf="%a * %s / 1024\n" . | bc) -gt $(du -sk ./"${d}" | awk '{print $1}') ]
    then
      tar cvfz "${d}.tgz" "${d}"
    else
      echo "Low space in $(pwd)"
    fi
  else
    echo "Can't access ${d}"
  fi
}
gitio () {
    if [ $(expr "$#" = 1 2> /dev/null) ]
    then
       curl -si "https://git.io" -F "url=$1" | grep "Location:" | awk '{ print $2 }'
   else
       curl -si "https://git.io" -F "url=$1" -F "code=$2" 1> /dev/null
       echo "https://git.io/$2"
    fi
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
size() {
  # du -scBM | sort -n
  du -shck "$@" | sort -rn | awk '
      function human(x) {
          s="kMGTEPYZ";
          while (x>=1000 && length(s)>1)
              {x/=1024; s=substr(s,2)}
          return int(x+0.5) substr(s,1,1)
      }
      {gsub(/^[0-9]+/, human($1)); print}'
}
each() {
  for dir in *; do
    # echo "${dir}:"
    cd $dir
    eval "$@"
    cd ..
  done
}
