" To get the currently selected text in visual
" mode, use @* -- :call Bracket(@*, '(')
function! Bracket(selection, bracket_char)
  let a:chars = split(a:selection, '\zs')
  let a:begin = getpos("'<")
  if (a:bracket_char ==? '(' || bracket_char ==? ')')
    return "(" + a:selection + ")"
  endif
endfunction

" If I only used Linux, I could shorthand this by
" just using @*, but sadly I also use Mac and
" there is not X11 support :(
function! GetVisualSelection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

