nnoremap <buffer> gd :TernDef<cr>
nnoremap <buffer> gr :TernRefs<cr>
nnoremap <buffer> <leader>gr :TernRename<cr>
nnoremap <buffer> <leader>m :TernDocBrowse<cr>

setlocal tabstop=4 shiftwidth=4
let g:javaScript_fold = 1
setlocal foldmethod=syntax
setlocal foldlevel=0
setlocal foldnestmax=1

let b:ale_fixers = ['prettier', 'eslint']
let b:ale_linters = ['eslint']
