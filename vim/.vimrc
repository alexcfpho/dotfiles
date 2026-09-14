set backspace=indent,eol,start
syntax enable
call plug#begin('~/.vim/plugged')
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()
set termguicolors
colorscheme catppuccin_frappe
set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2
set modelines=1
filetype indent on
filetype plugin on
set autoindent smartindent
set number
set showcmd
set nocursorline
set showmatch
set wildmenu
set incsearch
set hlsearch
nnoremap j gj
se mouse+=a
