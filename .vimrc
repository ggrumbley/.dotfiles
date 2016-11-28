" VUNDLE
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-endwise'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'itchyny/lightline.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'nvie/vim-flake8'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-rails'
Plugin 'rust-lang/rust.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'morhetz/gruvbox'
call vundle#end()            " required
filetype plugin indent on    " required

" Syntax Highlighting
let python_highlight_all=1
syntax on
set t_Co=256
set background=dark
colorscheme gruvbox
" call togglebg#map("<F5>")

" Misc
set encoding=utf-8
set nu
set splitbelow
set splitright
set clipboard=unnamed


"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let g:lightline = {
	\ 'colorscheme': 'gruvbox',
	\ }
set laststatus=2

"Other Indents
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set autoindent
set nosmartindent

" DelimitMate Options
let g:delimitMate_autoclose = 1
let g:delimitMate_matchpairs = "(:),[:],{:},<:>"
let g:delimitMate_jump_expansion = 0
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_inside_quotes = 1
" Setting Backup Folders
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
