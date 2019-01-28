setlocal makeprg=pandoc\ -f\ markdown_github\ -t\ html\
      \ -o\ /var/run/user/$UID/vim-preview.html\ %\ &&\
      \ firefox\ /var/run/user/$UID/vim-preview.html
