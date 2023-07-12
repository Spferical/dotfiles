set nocompatible

" Vundle
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#rc("~/.config/nvim/bundle")

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'editorconfig/editorconfig-vim'
call vundle#end()

syntax on
filetype plugin indent on

colorscheme wombat256mod

" nicer <leader>
let mapleader=","

" 'nicer' statusline
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
" always display statusline
set laststatus=2

" enables the mouse
set mouse=a

set backspace=indent,eol,start

"automatically indent
set autoindent

"min lines between bottom visible line and cursor
set scrolloff=5

"highlight search while typing
set incsearch
"highlight all matches in search
set hlsearch
"highlight matching brackets
set showmatch
"lines remembered in history
set history=1000
"alias unnamed register to + (X window clipboard)
set clipboard=unnamedplus
" case insensitive if search is all lowercase
set ignorecase
set smartcase
"line numbers
set number
"easier buffer switching
set wildchar=<Tab> wildmenu wildmode=full
" break lines at word boundaries (don't cut words when wrapping)
set linebreak

"prevents lagging when inserting parens and brackets in large files
"(http://www.reddit.com/r/vim/comments/1p0e46)
let g:matchparen_insert_timeout=5

" store all swap files in a single directory
" stops dropbox syncing the files every single edit
set directory=~/.vimswap

command RemoveTrailingWhitespace %s/\s\+$//e

nnoremap <leader>ts :r! date +"\%Y-\%m-\%d \%H:\%M:\%S \%Z"<cr>

" toggle highlight search
nmap <silent> <leader>n :set invhls<CR>:set hls?<CR>

" ;wq
nnoremap ; :
