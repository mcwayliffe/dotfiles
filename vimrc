set nocompatible
filetype plugin on

" Configure runtimepath to include files from the dotfiles repo. This assumes
" that ~/.vimrc is a symlink to <some-path>/dotfiles/vimrc and not a copy.
let basedir = fnamemodify(resolve(expand('<sfile>:p')), ':p:h')
execute 'set rtp+=' . basedir

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
" Turn on 'bash' -- who uses 'sh' any more?
let g:is_bash=1
" Why is this not a default?
syntax on
" Set reasonable tabbing behavior
set expandtab tabstop=2 shiftwidth=2 shiftround
" Turn on line numbers
set number
" Turn on positioning in bottom right
set ruler
" Make vi search behave like EMACS's I-Search
set incsearch
" Show tabs explicitly
set list
set listchars=tab:>-

" Logical, case-insensitive searching
set ignorecase
set smartcase

" Clipboard integration
set clipboard=unnamedplus

" Splits open where I expect them to
set splitbelow splitright

" Simple smart indentation
set autoindent

" Show number of lines selected in Visual
set showcmd

" ----------------------------
" Grep configuration (also quickfix)
" ----------------------------
set grepprg=git\ grep\ -n

" ----------------------------
" Useful Key Mappings
" ----------------------------

let mapleader="\<Space>"

" Visual line navigation, because I don't write code that much any more
nnoremap j gj
nnoremap k gk

" Toggle between relative and absolute numbering
nnoremap <silent> <Leader>n :set relativenumber!<CR>

" Open the NERDTree
nnoremap <silent> <Leader>o :NERDTreeToggle<CR>

" Switch tabs
nnoremap <Leader>h gT
nnoremap <Leader>l gt

" Insert newline
nnoremap <C-n> O<Esc>

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

function! MaybeStripTrailingWhitespace()
  " Don't strip whitespace in Markdown files
  if (&ft == 'markdown')
    return
  endif
  %s/\s\+$//e
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
autocmd BufWritePre * call MaybeStripTrailingWhitespace()
