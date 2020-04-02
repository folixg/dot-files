" Vim needs a POSIX compatible shell
if &shell =~# 'fish$'
    set shell=zsh
endif

" pathogen
if !has('packages')
  runtime pack/misc/start/vim-pathogen/autoload/pathogen.vim
  execute pathogen#infect()
endif

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
set mouse=a                         " enable mouse support in all modes
set number                          " show line numbers
set cursorline                      " highlight current line
set colorcolumn=80                  " show marker for textwidth
set incsearch                       " show search results while typing
set hlsearch                        " highlight all matches in search
set wildmode=list:longest,full      " list possible completions
packadd! matchit                    " improve jumping with %
set scrolloff=5                     " keep 5 lines above/below current line
set nofoldenable                    " don't fold by default
set modeline                        " read modeline options from files
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set list                            " show whitespace

" dracula color scheme https://github.com/dracula/vim
packadd! dracula
let g:dracula_colorterm=0
colorscheme dracula

" change cursor based on mode
if &term =~ '^xterm.*'
  " blinking vertical bar for insert mode
  let &t_SI .= "\<Esc>[5 q"
  " solid block
  let &t_EI .= "\<Esc>[2 q"
endif

" indenting
set autoindent
set smarttab
set backspace=indent,eol,start
set expandtab softtabstop=2 shiftwidth=2
filetype plugin indent on
" enable syntax higlighting
" (after loading filetype plugin as adviced by :help vimtex_syntax_filetype)
syntax on

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
let netrw_banner = 0          " don't show info
let netrw_winsize = 25        " default size 25%
let netrw_hide = 1
let netrw_list_hide= '^\..*'

" fzf
set rtp+=~/.fzf
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" vimtex
if has('mac')
  let vimtex_view_method='skim'
else
  let vimtex_view_method='zathura'
endif
let vimtex_index_split_pos = 'vert belowright'

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

" quickly switch between dark and light colorscheme
function! LightSwitch()
  if g:colors_name == 'dracula'
    set background=light
    colorscheme snow
  else
    set background=dark
    colorscheme dracula
  endif
endfunction
noremap <silent> <F4> :call LightSwitch()<CR>

" Mute vim-go warning for older vim versions
let g:go_version_warning = 0

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

