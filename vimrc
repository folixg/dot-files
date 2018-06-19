set nocompatible  " as advised by ':help E10'

" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" statusline
set statusline=%.30F                      " full path (limited to 30 chars)
set statusline+=%(\ [%H%M%R%W]%)          " flags
set statusline+=\ 
set statusline+=%{fugitive#statusline()}  " git status
set statusline+=%=                        " move to right
set statusline+=%([%{&fenc}%Y]%)          " file encoding and type
set statusline+=\ 
set statusline+=%3l                       " current line
set statusline+=:
set statusline+=%-2v                      " (virtual) column
set statusline+=\ 
set statusline+=%P                        " percentage through file
set laststatus=2                          " always show status line

" general appearance and behavior
syntax on                           " syntax highlighting
set mouse=a                         " enable mouse support in all modes
set number                          " show line numbers
set cursorline                      " highlight current line
set colorcolumn=80                  " show marker for textwidth
set incsearch                       " show search results while typing
set hlsearch                        " highlight all matches in search
set wildmode=list:longest           " list possible completions
colorscheme lucario                 " https://github.com/raphamorim/lucario
set guifont=Source\ Code\ Pro\ 11   " gvim font 
packadd! matchit                    " improve jumping with %
set scrolloff=5                     " keep 5 lines above/below current line
set nofoldenable                    " don't fold by default
set modeline                        " read modeline options from files

" indenting
set autoindent
set smarttab
set backspace=indent,eol,start
set expandtab softtabstop=2 shiftwidth=2
filetype plugin indent on

" mappings
let mapleader="\<Space>"
let maplocalleader=","
" exit insert mode
inoremap jk <ESC>
" put/yank from/to clipboard
nnoremap <Leader>p "+P
noremap <Leader>y "+y
" use ü to navigate tags
nnoremap ü <C-]>
nnoremap Ü <C-T>
" use ö to navigate sentences
noremap Ö (
noremap ö )
" use ä to navigate paragraphs
noremap ä }
noremap Ä {
" navigate sections
noremap <Leader>ö ]]
noremap <Leader>Ö [[
noremap <Leader>ä ][
noremap <Leader>Ä []
" force window redrawing
noremap <silent> <F5> :redraw!<CR>
" clear hlsearch highlighting
nnoremap <silent> <Leader>c :nohlsearch<CR>
" spell checking
nnoremap <silent> <F3> :set spell!<CR>
nnoremap <Localleader>f ]s
nnoremap <Localleader>d [s
nnoremap <Localleader>g z=

" netrw
noremap <silent> <F1> :Lexplore<CR>
augroup netrw
  autocmd!
  autocmd FileType netrw nnoremap <silent> <buffer> <F1> :q<CR>
  autocmd FileType netrw setl bufhidden=delete " delete hidden buffers
augroup END
let netrw_banner = 0          " don't show info
let netrw_winsize = 25        " default size 25%
let netrw_hide = 1
let netrw_list_hide= '^\..*'

" syntastic
let syntastic_always_populate_loc_list = 1
let syntastic_auto_loc_list = 1
let syntastic_check_on_open = 1
let syntastic_check_on_wq = 0
let syntastic_python_checkers = ['flake8']

" vimtex
let tex_flavor='latex'  " force TEX filetype for empty .tex files
let vimtex_view_method='zathura'
let vimtex_index_split_pos = 'vert belowright'
augroup vimtex
  autocmd!
  autocmd Filetype tex set foldmethod=expr
  autocmd Filetype tex set foldexpr=vimtex#fold#level(v:lnum)
  autocmd Filetype tex set foldtext=vimtex#fold#text()
  autocmd Filetype tex nmap <silent><buffer> <localleader>lz <plug>(vimtex-labels-open)
  autocmd Filetype tex nmap <silent><buffer> <localleader>lZ <plug>(vimtex-labels-toggle)
augroup END

" gitgutter
set updatetime=250

" fugitive 
command! -bar -bang -nargs=* Gci :Gcommit<bang> -v <args>

" highlightedyank
if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif

" indentLine
let indentLine_char = '┊'
let indentLine_leadingSpaceChar = '·'
let indentLine_setConceal = 0

" tagbar
noremap <silent> <F2> :Tagbar<CR>
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }
let tagbar_zoomwidth = 0
let tagbar_autofocus = 1

" folding for python
augroup python
  autocmd!
  autocmd FileType python set foldmethod=indent
augroup END

" quickly switch between dark and light colorscheme
function! LightSwitch()
  if g:colors_name == 'lucario'
    colorscheme PaperColor
    set background=light
  else
    colorscheme lucario
  endif
endfunction
noremap <silent> <F4> :call LightSwitch()<CR>
