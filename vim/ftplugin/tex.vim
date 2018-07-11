" vimtex
let tex_flavor='latex'  " force TEX filetype for empty .tex files
setlocal foldmethod=expr
setlocal foldexpr=vimtex#fold#level(v:lnum)
setlocal foldtext=vimtex#fold#text()
map <silent><buffer> <localleader>lz <plug>(vimtex-labels-open)
nmap <silent><buffer> <localleader>lZ <plug>(vimtex-labels-toggle)

function! Lacheck()
  let g:vimtex_enabled=0
  setlocal makeprg=lacheck\ %
  setlocal errorformat=
        \ '%-G** %f:,' .
        \ '%E"%f"\, line %l: %m'
  make!
  let g:vimtex_enabled=1
  cwindow
endfunction

command! Lacheck :call Lacheck()
