" use pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
" always show status line
set laststatus=2
" hide mode, since it is shwon in lightline
set noshowmode
" use menu for completion
set wildmenu
" font to use with gvim
set guifont=Source\ Code\ Pro\ 11
" syntax highlighting
syntax on
" don't select line numbers when selecting with the mouse
set mouse=a
" show line numbers
set number
" higlight current line
set cursorline
" show print area
set colorcolumn=80
" use space as leader
let mapleader="\<Space>"
let maplocalleader="\<Space>"
" use <C-P> and <C-Y> to print/yank to from clipboard
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
" shortcut for window redrawing
noremap <silent> <F5> :redraw!<CR>
" show search results while typing
set incsearch
" higlight all matches in search
set hlsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
nnoremap <silent> <C-L> :nohlsearch<CR>
" use color scheme from https://github.com/raphamorim/lucario
colorscheme lucario
" indenting
set autoindent
set smarttab
set backspace=indent,eol,start
set expandtab softtabstop=2 shiftwidth=2
filetype plugin indent on
" netrw setup
noremap <silent> <F1> :Lexplore<CR>
autocmd FileType netrw nnoremap <silent> <buffer> <F1> :q<CR>
autocmd FileType netrw setl bufhidden=delete " delete hidden buffers
let netrw_banner = 0          " don't show info
let netrw_winsize = 25        " default size 25%
" syntastic settings
let syntastic_always_populate_loc_list = 1
let syntastic_auto_loc_list = 1
let syntastic_check_on_open = 1
let syntastic_check_on_wq = 0
let syntastic_python_checkers = ['flake8']
" vimtex
let vimtex_view_method='zathura'
let vimtex_index_split_pos = 'vert belowright'
" lightline config
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
" faster updatetime, so gitgutter works smoother
set updatetime=250
" alias for verbose git commit
command -bar -bang -nargs=* Gci :Gcommit<bang> -v <args>
" highlight yanked region
if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif
" configure indentLine plugin
let indentLine_char = '┊'
let indentLine_leadingSpaceChar = '·'
let indentLine_setConceal = 0
" toggle tagbar
noremap <silent> <F2> :Tagbar<CR>
" markdown support for tagbar
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }
let g:tagbar_zoomwidth = 0
let g:tagbar_autofocus = 1
