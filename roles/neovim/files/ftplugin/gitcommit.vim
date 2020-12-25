" setlocal nofoldenable

setlocal re=0

augroup gitcommit
  au!
  autocmd FileType gitcommit nnoremap <buffer> <leader>w :x<cr>
augroup END
