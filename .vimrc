set mouse=a
set number relativenumber
syntax on
call plug#begin()
Plug 'phanviet/vim-monokai-pro'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
call plug#end()


set termguicolors
colorscheme monokai_pro

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set nu
