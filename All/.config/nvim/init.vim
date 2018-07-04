set nocompatible


" Vundle
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#rc("~/.config/nvim/bundle")

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/Wombat'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'vimwiki'
Plugin 'tpope/vim-fugitive'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'roxma/nvim-cm-racer'
Plugin 'heavenshell/vim-pydocstring'
Plugin 'fatih/vim-go'
Plugin 'let-def/vimbufsync'
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

" YCM
" autoclose YCM's preview window
" let g:ycm_autoclose_preview_window_after_completion = 1
" default global ycm conf for c languages
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

nnoremap <leader>jd :YcmCompleter GoTo<CR>

nnoremap <leader>ts :r! date +"\%Y-\%m-\%d \%H:\%M:\%S \%Z"<cr>

noremap <F3> :Autoformat<CR><CR>

" toggle highlight search
nmap <silent> <leader>n :set invhls<CR>:set hls?<CR>

" ;wq
nnoremap ; :

" Vimwiki
let g:vimwiki_list = [{'path': '~/Sync/vimwiki/',
                        \ 'syntax': 'markdown', 'ext': '.md',
			\ 'diary_rel_path': 'journal',
			\ 'diary_index': 'journal',
			\ 'diary_header': 'Journal'}]

" Eclim
"let g:EclimCompletionMethod = 'omnifunc'
nnoremap <leader>ji :JavaImport<CR>
nnoremap <leader>js :JavaSearch<Space>
nnoremap <leader>jsc :JavaSearchContext<CR>
nnoremap <leader>jdc :JavaDocComment
nnoremap <leader>jc :JavaCorrect<CR>
nnoremap <leader>jr :JavaRename<Space>

"lua.vim
"let g:lua_complete_library = 0 " interferes with YouCompleteMe
"let g:lua_complete_dynamic = 0 " interferes with YouCompleteMe
"let g:deoplete#enable_at_startup = 1
let g:lua_complete_omni = 1
let g:lua_safe_omni_modules = 1

" Neomake upon write
"autocmd! BufWritePost * Neomake

" scroll through completion results with tab instead of shift-tab
let g:SuperTabDefaultCompletionType = "<c-n>"

set hidden
let g:racer_cmd = "/usr/bin/racer"
let g:racer_experimental_completer = 1

"jedi
"don't do stupid things like insta-insert the 'from' in 'import x from y'
let g:jedi#smart_auto_mappings = 0
