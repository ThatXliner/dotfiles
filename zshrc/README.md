# My `~/.zshrc`

TODO: Maybe make use of `.zshenv` (always loaded) or `.zprofile` (login only). See https://stackoverflow.com/questions/18186929/what-are-the-differences-between-a-login-shell-and-interactive-shell

TODO: Strip down unnecessary plugins, try other managers such as [Antidote](https://github.com/mattmc3/antidote) (supposedly better than Antigen), [Zplug](https://github.com/zplug/zplug), or [Zinit](https://github.com/zdharma-continuum/zinit) and benchmark using [zsh-bench](https://github.com/romkatv/zsh-bench).

Hello :wave:! This is my Zsh configuration. It should load in less than ~~2 seconds, but it currently loads in 4-5 seconds. I'm working hard on shaving that time down.~~ **half a second.**

## Features

(and I guess therefore requirements)

- Zoxide
- Thef\*ck
- Powerlevel10k
- ASDF
- Fzf

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
