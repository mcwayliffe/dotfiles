" ----------------------------
" VUNDLE 
" ----------------------------
set nocompatible " Don't allow running as vi
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" ----------------------------
" Settings 
" ----------------------------

syntax on " Why is this not a default?
set expandtab tabstop=2 shiftwidth=2 " Set reasonable tabbing behavior
set mouse=a " Turn on mouse interaction for all modes
set number " Turn on line numbers
set ruler " Turn on positioning in bottom right 
set hlsearch " Turn on search highlighting
set incsearch " Make vi search behave like EMACS's I-Search

" Logical, case-insensitve searching
set ignorecase
set smartcase

" ----------------------------
" Useful Key Mappings
" ----------------------------

let mapleader="," 

" Use ctrl-c to get rid of search highlighting
nnoremap <Leader>l :nohl<CR> 

" ctrl-n inserts newline
nnoremap <C-n> O<Esc> 

" Ctrl-" to change tabs
nnoremap <C-t> gt

" ----------------------------
" New Commands
" ----------------------------

" ----------------------------
" Autocommands  
" ----------------------------

" Highlight gradle files correctly
autocmd BufRead,BufNewFile *.gradle setlocal syntax=groovy 
