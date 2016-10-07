" ----------------------------
" PLUGINS
" ----------------------------
"  Plugins are managed by Vundle -- if Vundle isn't installed, then
"  don't bother with setting it up
set nocompatible
if filereadable(expand('~/.vim/bundle/Vundle.vim/README.md'))
  filetype off

  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  Plugin 'VundleVim/Vundle.vim'

  " Solarized plugin
"  Plugin 'altercation/vim-colors-solarized'
"  syntax enable
"  set background=dark
"  colorscheme solarized

  call vundle#end()
endif
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

" Logical, case-insensitive searching
set ignorecase
set smartcase

" Clipboard integration
set clipboard=unnamed

" Splits open where I expect them to
set splitbelow splitright

" ----------------------------
" Useful Key Mappings
" ----------------------------

let mapleader=","

" Shortcut to remove search highlighting
nnoremap <silent> <Leader>l :nohl<CR>

" Shortcut to force screen redraw
nnoremap <silent> <Leader>r :redraw!<CR>

" Add single character at end of line
nnoremap <Leader>a $a_<Esc>r

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

" Add a way to comment a selection of lines
nnoremap <silent> <Leader>/ :call CommentLine(getline('.'))<CR>
vnoremap <silent> <Leader>/ :call CommentLine(getline('.'))<CR>

" Convenient way to copy to and paste from the clipboard register
nnoremap <Leader>c "+
vnoremap <Leader>c "+
nnoremap <Leader>v "+p
vnoremap <Leader>v "+p

" Append a line to the clipboard
nnoremap <silent> <Leader>C :let @+=@+.getline('.')<CR>

" ----------------------------
" Utility Functions
" ----------------------------
function! CommentLine(line)
  let a:chars = split(a:line, '\zs')
  if(&ft == 'groovy' || &ft == 'java')
    if(a:chars[0] ==? "\/" && a:chars[1] ==? "\/")
      s/\/\///
    else
      s/^/\/\//
    endif
  elseif(&ft == 'vim')
    if(a:chars[0] ==? "\"")
      s/"//
    else
      s/^/"/
    endif
  else
    if(a:chars[0] ==? "#")
      s/\#//
    else
      s/^/#/
    endif
  endif
endfunction

" ----------------------------
" Filetypes
" ----------------------------

" Highlight gradle files correctly
autocmd BufRead,BufNewFile *.gradle set filetype=groovy

" Highlight messages files
autocmd BufRead,BufNewFile messages* set filetype=messages


" ----------------------------
" Helpers
" ----------------------------
" Strip trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
