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
" Why is this not a default?
syntax on
" Set reasonable tabbing behavior
set expandtab tabstop=2 shiftwidth=2
" Turn on line numbers
set number
" Turn on positioning in bottom right
set ruler
" Turn on search highlighting
set hlsearch
" Make vi search behave like EMACS's I-Search
set incsearch

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

let mapleader="\<Space>"

" Quicker saves using only right hand
nnoremap <silent> <Leader>j :w<CR>

" Right-handed 'goto-characters'
nnoremap <Leader>h F
nnoremap <Leader>y T
nnoremap <Leader>k f
nnoremap <Leader>i t


" More efficient line jumps
nnoremap <CR> gg
vnoremap <CR> gg

" Remove search highlighting
nnoremap <silent> <Leader>l :nohl<CR>

" Force screen redraw
nnoremap <silent> <Leader>r :redraw!<CR>

" Insert newline
nnoremap <C-n> O<Esc>

" Scroll from the home row (except can't use <C-l>
" because that's for tmux, so leave <C-u> as up
" since that's a comfortable default anyway)
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>
nnoremap <C-h> <C-d>

" Insert a single character at cursor
nnoremap <Leader>i i_<Esc>r

" Insert single character at end of line
nnoremap <Leader>$ $a_<Esc>r

" Replace word with yank-register contents
nnoremap <Leader>p viwp

" Bracket word
nnoremap <Leader>b( ea)<Esc>Bi(<Esc>i
nnoremap <Leader>b) ea)<Esc>Bi(<Esc>i
nnoremap <Leader>b[ ea]<Esc>Bi[<Esc>i
nnoremap <Leader>b] ea)<Esc>Bi[<Esc>i

" Quote stuff
nnoremap <Leader>b" ea"<Esc>Bi"<Esc>
nnoremap <Leader>b' ea'<Esc>Bi'<Esc>

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

" Prepend to selection
nnoremap <silent> <Leader>I :call PrependToLines()<CR>
vnoremap <silent> <Leader>I :'<,'>call PrependToLines()<CR>

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

function! PrependToLines() range
  let str = escape(input("Prepend: "), '\/.*$^~[]')
	execute a:firstline . "," . a:lastline . 'substitute/^/' . str .'/'
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
