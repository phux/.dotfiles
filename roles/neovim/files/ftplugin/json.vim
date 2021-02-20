setlocal foldlevel=1
setlocal foldnestmax=4
setlocal foldmethod=indent
nnoremap <buffer> <m-f> :%!python -m json.tool<cr>
