# My `~/.zshrc`

TODO: Maybe make use of `.zshenv` (always loaded) or `.zprofile` (login only). See https://stackoverflow.com/questions/18186929/what-are-the-differences-between-a-login-shell-and-interactive-shell

Hello :wave:! This is my Zsh configuration. It should load in less than 2 seconds, but it currently loads in 4-5 seconds. I'm working hard on shaving that time down.

<!-- ## Installation

Requirements:
  - Oh-My-Zsh
    - zsh-syntax-highlighting
    - zsh-autosuggestions
  - Powerlevel10k

---

Clone this repo somewhere and replace your current `~/.zshrc` file with:

```sh
source "/where/did/you/clone/the/repo/index.zsh"
``` -->

## Structure

```
.
├── README.md - This file you are currently reading
├── aliases.zsh - Where I put all my aliases and functions
├── constants.zsh - Where I put my constants and other stuff in ALL CAPS
├── index.zsh - The main file to source in *your* `.zshrc`
├── omz.zsh - Oh-my-zsh-related stuff including my plugin list
└── path.zsh - $PATH-related stuff

0 directories, 6 files
```
