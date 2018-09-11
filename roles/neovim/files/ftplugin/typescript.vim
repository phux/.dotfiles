nnoremap <buffer> gd :TernDef<cr>
nnoremap <buffer> <leader>m :TernDocBrowse<cr>

setlocal tabstop=4
setlocal shiftwidth=4

let g:javaScript_fold = 1

let b:ale_fixers = ['prettier', 'eslint']
