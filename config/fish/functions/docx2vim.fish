# Defined in /tmp/fish.3Zr6sK/docx2vim.fish @ line 2
function docx2vim
    pandoc -f docx -t markdown $argv | view -c ":set filetype=markdown" -
end
