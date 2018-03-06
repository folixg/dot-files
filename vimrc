" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" appearence
set laststatus=2      " always show status line
set noshowmode        " hide mode, since it is shwon in lightline
syntax on             " syntax highlighting
set mouse=a           " enable mouse support in all modes
set number            " show line numbers
set cursorline        " higlight current line
set colorcolumn=80    " show marker for textwidth
set incsearch         " show search results while typing
set hlsearch          " higlight all matches in search
set wildmode=list:longest   " list possible completions
colorscheme lucario   " colorscheme from https://github.com/raphamorim/lucario
set guifont=Source\ Code\ Pro\ 11     " gvim font 

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
" use ä to navigate paragraphps
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

" netrw
noremap <silent> <F1> :Lexplore<CR>
augroup netrw
  autocmd!
  autocmd FileType netrw nnoremap <silent> <buffer> <F1> :q<CR>
  autocmd FileType netrw setl bufhidden=delete " delete hidden buffers
augroup END
let netrw_banner = 0          " don't show info
let netrw_winsize = 25        " default size 25%

" syntastic
let syntastic_always_populate_loc_list = 1
let syntastic_auto_loc_list = 1
let syntastic_check_on_open = 1
let syntastic_check_on_wq = 0
let syntastic_python_checkers = ['flake8']

" vimtex
let vimtex_view_method='zathura'
let vimtex_index_split_pos = 'vert belowright'

" lightline
let lightline = {
  \ 'colorscheme': 'OldHope',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \ 'gitbranch': 'fugitive#statusline'
  \ },
  \}

" gitgutter
set updatetime=250

" fugitive 
command -bar -bang -nargs=* Gci :Gcommit<bang> -v <args>

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
