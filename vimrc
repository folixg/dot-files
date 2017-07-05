" use pathogen
execute pathogen#infect()

" syntax highlighting
syntax on
" don't select line numbers when selecting with the mouse
set mouse=a
" show line numbers
set number
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
" automatically write last modified timestamp
autocmd Bufwritepre,filewritepre * execute "normal ma"
autocmd Bufwritepre,filewritepre * exe "1," . 10 . "g/Last modified:.*/s/Last modified:.*/Last modified: " .strftime("  %c")
autocmd bufwritepost,filewritepost * execute "normal `a"
" template for C files
autocmd bufnewfile *.c* so ~/.vim/templates/c.txt
autocmd bufnewfile *.c* exe "1," . 10 . "g/File:.*/s//File Name:       " .expand("%")
autocmd bufnewfile *.c* exe "1," . 10 . "g/Created:.*/s//Created:         " .strftime("%d-%m-%Y")
autocmd bufnewfile *.c* execute "normal G"
" don't use vim-go templates
let g:go_template_autocreate = 0
" use this instead
autocmd bufnewfile *.go so ~/.vim/templates/go.txt
autocmd bufnewfile *.go exe "1," . 10 . "g/File:.*/s//File Name:       " .expand("%")
autocmd bufnewfile *.go exe "1," . 10 . "g/Created:.*/s//Created:         " .strftime("%d-%m-%Y")
autocmd bufnewfile *.go execute "normal G"
" template for python files
autocmd bufnewfile *.py* so ~/.vim/templates/python.txt
autocmd bufnewfile *.py* exe "1," . 10 . "g/File:.*/s//File Name:       " .expand("%")
autocmd bufnewfile *.py* exe "1," . 10 . "g/Created:.*/s//Created:         " .strftime("%d-%m-%Y")
autocmd bufnewfile *.py* execute "normal G"
" template for bash files
autocmd bufnewfile *.sh so ~/.vim/templates/bash.txt
autocmd bufnewfile *.sh exe "1," . 10 . "g/File:.*/s//File Name:       " .expand("%")
autocmd bufnewfile *.sh exe "1," . 10 . "g/Created:.*/s//Created:         " .strftime("%d-%m-%Y")
autocmd bufnewfile *.sh execute "normal G"
" template for vhdl files
autocmd bufnewfile *.vhd* so ~/.vim/templates/vhdl.txt
autocmd bufnewfile *.vhd* exe "1," . 10 . "g/File:.*/s//File Name:       " .expand("%")
autocmd bufnewfile *.vhd* exe "1," . 10 . "g/Created:.*/s//Created:         " .strftime("%d-%m-%Y")
autocmd bufnewfile *.vhd* execute "normal G"
" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
