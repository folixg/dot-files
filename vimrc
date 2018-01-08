" use pathogen
execute pathogen#infect()

" hide mode, since it is shwon in lightline
set noshowmode
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
" higlight all matches in search
set hlsearch
" use color scheme from https://github.com/raphamorim/lucario
colorscheme lucario
" indenting
set expandtab softtabstop=2 shiftwidth=2
filetype plugin indent on
au FileType python set expandtab softtabstop=4 shiftwidth=4
au FileType go set noexpandtab tabstop=4 shiftwidth=4
" nerdtree shortcut
map <C-n> :NERDTreeToggle<CR>
" syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
" vimtex
let g:vimtex_enabled = 1
let g:vimtex_view_method='zathura'
" lightline colorscheme
let g:lightline = {
     \ 'colorscheme': 'OldHope',
      \ }
