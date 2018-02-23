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
" show search results while typing
set incsearch
" higlight all matches in search
set hlsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
" use color scheme from https://github.com/raphamorim/lucario
colorscheme lucario
" indenting
set autoindent
set smarttab
set backspace=indent,eol,start
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
" lightline config
let g:lightline = {
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
" highlight yanked region
if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif
autocmd FileType tex nnoremap ,, :VoomToggle latex <CR> 
autocmd FileType markdown nnoremap ,, :VoomToggle markdown <CR> 
autocmd FileType python nnoremap ,, :VoomToggle python <CR> 
