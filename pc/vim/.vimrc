" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Add numbers to each line on the left-hand side.
set number

" Use space characters instead of tabs.
set expandtab

set tabstop=4

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

set encoding=UTF-8

set mouse=a

set termguicolors

set laststatus=2

if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {'colorscheme': 'catppuccin_mocha'}

syntax on

colorscheme catppuccin_mocha

let g:colorizer_auto_color = 1

" plugins {{{

call plug#begin('~/.vim/plugged')
   Plug 'catppuccin/vim', { 'as': 'catppuccin' }
   Plug 'itchyny/lightline.vim'
   Plug 'dense-analysis/ale'
   Plug 'preservim/nerdtree'
   Plug 'ryanoasis/vim-devicons'
   Plug 'chrisbra/Colorizer' 
call plug#end()

" }}}

" " vscripts {{{

" This will enable code folding.
" Use: the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" }}}
