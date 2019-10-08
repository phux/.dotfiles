" we don't want quickfix buffers to pop up when doing :bn or :bp
set nobuflisted
nnoremap <silent> <buffer> s <C-w><CR>

" open entry in a new horizontal window
nnoremap <silent> <buffer> s <C-w><CR>

" open entry in a new vertical window.
nnoremap <silent> <expr> <buffer> v &splitright ? "\<C-w>\<CR>\<C-w>L\<C-w>p\<C-w>J\<C-w>p" : "\<C-w>\<CR>\<C-w>H\<C-w>p\<C-w>J\<C-w>p"
