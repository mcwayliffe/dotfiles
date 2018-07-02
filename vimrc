" ----------------------------
" Other source files
" ----------------------------

" Configure runtimepath to include files from the dotfiles repo. This assumes
" that ~/.vimrc is symlinked to <some-path>/dotfiles/vimrc and not copied
" there. But, like, who would do that?
let basedir = fnamemodify(resolve(expand('<sfile>:p')), ':p:h')
execute 'set rtp+=' . basedir

" ----------------------------
" PLUGINS
" ----------------------------
"  Plugins are managed by Vundle -- if Vundle isn't installed, then
"  don't bother with setting it up
set nocompatible
if filereadable(expand('~/.vim/bundle/Vundle.vim/README.md'))
  filetype off
  set runtimepath+=~/.vim/bundle/Vundle.vim

  call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'scrooloose/NERDTree'
  Plugin 'tpope/vim-fugitive'
  Plugin 'mtth/scratch.vim'
  call vundle#end()
endif

filetype plugin on

" Insert-Mode-Only CAPSLOCK
" To use this, type CTRL-^ (C-S-6) in either insert or search
set imsearch=-1
set keymap=caps " This lives in dotfiles/keymap/caps.vim
set iminsert=0
autocmd InsertLeave * set iminsert=0

" Colors
set t_Co=256
colorscheme desert

" ----------------------------
" Settings
" ----------------------------
" Why is this not a default?
syntax on
" Set reasonable tabbing behavior
set expandtab tabstop=2 shiftwidth=2 shiftround
" Turn on line numbers
set number
" Turn on positioning in bottom right
set ruler
" Turn on search highlighting
set hlsearch
" Make vi search behave like EMACS's I-Search
set incsearch
" Show tabs explicitly
set list
set listchars=tab:>-

" Logical, case-insensitive searching
set ignorecase
set smartcase

" Clipboard integration
set clipboard=unnamed

" Splits open where I expect them to
set splitbelow splitright

" Simple smart indentation
set autoindent

" Show number of lines selected in Visual
set showcmd

" ----------------------------
" Useful Key Mappings
" ----------------------------

let mapleader="\<Space>"

" Toggle between relative and absolute numbering
nnoremap <silent> <Leader>n :set relativenumber!<CR>

" Open the NERDTree
nnoremap <silent> <Leader>o :NERDTreeToggle<CR>

" Quicker saves
nnoremap <silent> <Leader>w :w<CR>

" Switch tabs
nnoremap <Leader>h gT
nnoremap <Leader>l gt

" Quit
nnoremap <silent> <Leader>q :q<CR>

" Force quit
nnoremap <silent> <Leader>Q :q!<CR>

" Force reopen
nnoremap <silent> <Leader>E :e!<CR>

" More efficient line jumps
nnoremap <CR> gg
vnoremap <CR> gg

" Remove search highlighting
nnoremap <silent> <Leader>k :nohl<CR>

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

" Replace word with yank-register contents
nnoremap <Leader>p viwp

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

" ----------------------------
" Utility Functions
" ----------------------------
function! FixMarkdownNumbering()
  let numbering_start = line('.')
  let numbering_end   = line('.')
  let numbering_pat   = '^[0-9]\+\.'
  while match(getline(numbering_start), numbering_pat) != -1
    let numbering_start = numbering_start - 1
  endwhile
  let numbering_start = numbering_start + 1

  while match(getline(numbering_end), numbering_pat) != -1
    let numbering_end = numbering_end + 1
  endwhile
  let numbering_end = numbering_end - 1

  let awk_cmd = "awk -F'.' '{ $1=NR \".\" ; print $0 }'"
  let range   = string(numbering_start) . "," . string(numbering_end)
  execute range . "!" . awk_cmd
endfunction

function! CommentLine(line)
  let a:chars = split(a:line, '\zs')
  let length = len(a:chars)
  if(&ft == 'groovy' || &ft == 'java' || &ft == 'go')
    if(length == 0)
      s/^/\/\//
    elseif(a:chars[0] ==? "\/" && a:chars[1] ==? "\/")
      s/\/\///
    else
      s/^/\/\//
    endif
  elseif(&ft == 'vim')
    if(length == 0)
      s/^/"/
    elseif(a:chars[0] ==? "\"")
      s/"//
    else
      s/^/"/
    endif
  else
    if(length == 0)
      s/^/#/
    elseif(a:chars[0] ==? "#")
      s/\#//
    else
      s/^/#/
    endif
  endif
endfunction

function! GetCurWord()
  return expand("<cword">)
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

" Wordwrap in markdown files
autocmd BufRead,BufNewFile *.md setl textwidth=0

" Wordwrap in Python
autocmd BufRead,BufNewFile *.py setl textwidth=120

" Formatting using tabs for golang
autocmd BufRead,BufNewFile *.go setl nolist noet ts=4 sw=4 sts=4

" Highlight messages files
autocmd BufRead,BufNewFile messages* set filetype=messages

" Git commits + textwrapping
autocmd Filetype gitcommit setlocal textwidth=80 spell

" ----------------------------
" Helpers
" ----------------------------
" Strip trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
