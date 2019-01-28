setlocal makeprg=pandoc\ -f\ rst\ -t\ html\
      \ -o\ /var/run/user/$UID/vim-preview.html\ %\ &&\
      \ firefox\ /var/run/user/$UID/vim-preview.html
