setlocal nofoldenable

setlocal re=0

augroup gitcommit
  au!
  autocmd FileType gitcommit nnoremap <buffer> <leader>w :x<cr>
  autocmd FileType gitcommit call lexical#init({ 'spell': 1 })
augroup END
