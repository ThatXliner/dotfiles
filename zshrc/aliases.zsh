# THE LARGE WALL OF ALIASES >:)
# TODO: Clean up and document

# Fun fact: apparently if you name an executable file
# git-* (let's say... git-{{ this }})
# and add it to your $PATH,
# When you run `git {{ this }}`, it'll run that file
alias gitpf="git push --force-with-lease"
alias gits="git status -sb"
alias gitb="git branch"
alias gitbd="git branch -d"
alias gitch="git checkout"
alias gitm="git checkout master"
alias gitcb="git checkout -b"
alias gitf="git fetch"
alias gitfm='git pull; git checkout $(git remote show origin | awk "/HEAD branch/ {print \$NF}") && git pull && git branch -d @{-1} && git checkout $(git remote show origin | awk "/HEAD branch/ {print \$NF}")'
alias gitp="git pull --ff-only || echo \"FAST FORWARD FAILED: REBASING\" && git pull --rebase || { echo \"REBASING FAILED: STASHING\" && git stash && git pull --rebase && git stash pop } && echo \"DONE\""
alias gitl="git log"
alias neoneofetch="curl -s https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch | bash"
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
alias zrc="atom $__DOTFILES_ZSH_DIR"
alias szrc="omz reload"
alias vact="source .venv/bin/activate"
alias cat="bat --pager=never"
# alias code="codium"
alias ...="echo TODO"
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

add_omz_plugins() {
    for plugin in $@; do
        plugin_list_replacement=$(
            cat "$__DOTFILES_ZSH_DIR/omz.zsh" |
            rg "$OMZ_PLUGIN_LIST_BEGIN\n.+\n$OMZ_PLUGIN_LIST_END" -U --multiline-dotall |
            sed "s/$OMZ_PLUGIN_LIST_END/$plugin\n$OMZ_PLUGIN_LIST_END/"
        )
        perl -0pe \
            "s/$OMZ_PLUGIN_LIST_BEGIN.+$OMZ_PLUGIN_LIST_END/$plugin_list_replacement/s" \
            -i "$__DOTFILES_ZSH_DIR/omz.zsh"
    done
}
remove_omz_plugins() {
    for plugin in $@; do
        plugin_list_replacement=$(
            cat "$__DOTFILES_ZSH_DIR/omz.zsh" |
            rg "$OMZ_PLUGIN_LIST_BEGIN\n.+\n$OMZ_PLUGIN_LIST_END" -U --multiline-dotall |
            sed "/$plugin$/d"
        )
        perl -0pe \
            "s/$OMZ_PLUGIN_LIST_BEGIN.+$OMZ_PLUGIN_LIST_END/$plugin_list_replacement/s" \
            -i "$__DOTFILES_ZSH_DIR/omz.zsh"
    done
}
show_omz_plugins() {
    cat "$__DOTFILES_ZSH_DIR/omz.zsh" |
    rg "$OMZ_PLUGIN_LIST_BEGIN\n.+\n$OMZ_PLUGIN_LIST_END" -U --multiline-dotall |
    sed "s/#.*//g" |
    xargs |
    sed 's/ /\n/g'
}

update_git_repos() {
    for dir in $(fd ".git$" $1 --hidden --no-ignore)
    do
        git -C $(dirname $dir) pull
    done
}
update_plugins() {
    update_git_repos $ZSH_CUSTOM
}

zshrc_startup_time() {
    for x in $(seq 1 10)
    do
        /usr/bin/time zsh -ic exit
    done
}

marchive() {
    if [[ $@ =~ "-h" ]]
    then
        ...
        return 0
    fi
    if [ -z $1 ]
    then
        echo "Usage: marchive FILE"
        return 1
    fi
    file_no_ext=$(echo ${1:A} | sed 's/.mscz//')
    zip_name="${file_no_ext}.zip"
    song_name=$(basename $file_no_ext)
    if [ -f $zip_name ]
    then
        if [[ $2 =~ "-f(orce)?" ]]
        then
            rm $zip_name
        else
            echo "\x1b[1;31mArchive already exists\x1b[0m"
            return 1
        fi
    fi

    tempdir=$(mktemp -d)
    pdf_file="$tempdir/$song_name.pdf"
    mp3_file="$tempdir/Bryan Hu - $song_name.mp3"

    echo "\x1b[1;33mCreating PDFs and MP3s...\x1b[0m"
    mscore ${1:A} -o $pdf_file > /dev/null 2>&1 &
    mscore ${1:A} -o $mp3_file > /dev/null 2>&1 &
    wait

    echo "\x1b[1;33mAdding metadata and licensing information...\x1b[0m"

    id3tag --artist="Bryan Hu" --year=$(date +'%Y') --song=$song_name $mp3_file > /dev/null 2>&1
    echo 'This work is licensed under the' \
    'Attribution-NonCommercial 4.0 International (CC BY-NC 4.0).' \
    'See https://creativecommons.org/licenses/by-nc/4.0/ for more information' > $tempdir/LICENSE.txt

    echo "\x1b[1;33mCompressing...\x1b[0m"

    zip -r -9 -j $zip_name $tempdir > /dev/null 2>&1
    rm -rf $tempdir

    echo "\x1b[1;32mDone! Archived '${song_name}' successfully! (${zip_name})\x1b[0m"
}

### The following functions was stolen from https://github.com/paulmillr/dotfiles
_calcram() {
  local sum
  sum=0
  for i in `ps aux | grep -i "$1" | grep -v "grep" | awk '{print $6}'`; do
    sum=$(($i + $sum))
  done
  sum=$(echo "scale=2; $sum / 1024.0" | bc)
  echo $sum
}

# Show how much RAM application uses.
# $ ram safari
# # => safari uses 154.69 MBs of RAM
ram() {
  local sum
  local app="$1"
  if [ -z "$app" ]; then
    echo "First argument - pattern to grep from processes"
    return 0
  fi

  sum=$(_calcram $app)
  if [[ $sum != "0" ]]; then
    echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM"
  else
    echo "No active processes matching pattern '${fg[blue]}${app}${reset_color}'"
  fi
}

# Same, but tracks RAM usage in realtime. Will run until you stop it.
# $ rams safari
rams() {
  local sum
  local app="$1"
  if [ -z "$app" ]; then
    echo "First argument - pattern to grep from processes"
    return 0
  fi

  while true; do
    sum=$(_calcram $app)
    if [[ $sum != "0" ]]; then
      echo -en "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM\r"
    else
      echo -en "No active processes matching pattern '${fg[blue]}${app}${reset_color}'\r"
    fi
    sleep 1
  done
}


# 4 lulz.
compute() {
  while true; do head -n 100 /dev/urandom; sleep 0.1; done \
    | hexdump -C | grep "ca fe" --color=never
}

### END STOLEN FROM https://github.com/paulmillr/dotfiles

alias get_ports="lsof -i"
reversedns() {
    { dig -x $1 +short | rg ".+(?=\.)" -o --pcre2 --color=never } || nslookup $1
}

dns() {
    dig $1 +short
}

makeitwork() {
    chmod +x $1  # Make it executable
    if [[ "$OSTYPE" == "darwin"* ]]
    then
        xattr -r -d com.apple.quarantine $1  # Unquarantine
    fi
}
