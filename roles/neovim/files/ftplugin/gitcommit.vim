setlocal regexpengine=0

augroup gitcommit
  au!
  autocmd FileType gitcommit nnoremap <buffer> <leader>w :x<cr>
augroup END

hi link diffAdded DiffAdd
hi link diffRemoved DiffDelete
