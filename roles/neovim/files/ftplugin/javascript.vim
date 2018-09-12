nnoremap <buffer> gd :TernDef<cr>
nnoremap <buffer> <leader>m :TernDocBrowse<cr>

let g:javaScript_fold = 1
set foldmethod=syntax
set foldlevel=0
set foldnestmax=1

let b:ale_fixers = ['prettier', 'eslint']
