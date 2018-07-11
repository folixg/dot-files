" vimtex
let tex_flavor='latex'  " force TEX filetype for empty .tex files
setlocal foldmethod=expr
setlocal foldexpr=vimtex#fold#level(v:lnum)
setlocal foldtext=vimtex#fold#text()
map <silent><buffer> <localleader>lz <plug>(vimtex-labels-open)
nmap <silent><buffer> <localleader>lZ <plug>(vimtex-labels-toggle)

function! Lacheck()
  let old_makeprg=&l:makeprg
  let old_efm=&l:errorformat
  setlocal makeprg=lacheck\ %
  setlocal errorformat=
        \ '%-G** %f:,' .
        \ '%E"%f"\, line %l: %m'
  make!
  let &l:makeprg=old_makeprg
  let &l:errorformat=old_efm
  cwindow
endfunction

command! Lacheck :call Lacheck()
