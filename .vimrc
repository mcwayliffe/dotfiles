" ----------------------------
" VUNDLE
" ----------------------------
set nocompatible " Don't allow running as vi
filetype plugin on

" ----------------------------
" Settings
" ----------------------------

syntax on " Why is this not a default?
set expandtab tabstop=2 shiftwidth=2 " Set reasonable tabbing behavior
set number " Turn on line numbers
set ruler " Turn on positioning in bottom right
set hlsearch " Turn on search highlighting
set incsearch " Make vi search behave like EMACS's I-Search

" Logical, case-insensitve searching
set ignorecase
set smartcase

" Clipboard integration
set clipboard=unnamed

" ----------------------------
" Useful Key Mappings
" ----------------------------

let mapleader=","

" Use ctrl-c to get rid of search highlighting
nnoremap <Leader>l :nohl<CR>

" ctrl-n inserts newline
nnoremap <C-n> O<Esc>

" Ctrl-t" to change tabs
nnoremap <C-t> gt

" Scroll from the home row (except can't use <C-l>
" because that's for tmux, so leave <C-u> as up
" since that's a comfortable default anyway)
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>
nnoremap <C-h> <C-d>

" Insert a single character with space bar
nnoremap <Space> i_<Esc>r

" Make backspace key work on Linux
set backspace=2

" Make arrow keys into scroll keys
noremap <Up> <C-y>
noremap <Down> <C-e>
noremap <Left> <C-u>
noremap <Right> <C-d>

" ----------------------------
" New Commands
" ----------------------------

" ----------------------------
" Autocommands
" ----------------------------

" Highlight gradle files correctly
autocmd BufRead,BufNewFile *.gradle setlocal syntax=groovy

" Strip trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
