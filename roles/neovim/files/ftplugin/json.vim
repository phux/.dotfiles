setlocal foldlevel=1
setlocal foldnestmax=4
setlocal foldmethod=indent
setlocal conceallevel=0
nnoremap <m-f> :%!python3 -m json.tool<cr>
