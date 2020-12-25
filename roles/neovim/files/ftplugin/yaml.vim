augroup yaml
  au!
  au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags yaml' &
  au BufWritePost *.php silent! !eval '[ -f "../.git/hooks/ctags" ] && ../.git/hooks/ctags yaml' &
  au BufNewFile,BufRead,BufEnter *.yaml,*.yml set tags=.git/tags.php,../.git/tags.php,.git/tags.yaml,../.git/tags.yaml
augroup END

" setlocal tabstop=2 sts=2 sw=2 expandtab

nnoremap <buffer> <Leader>ref :PHPExpandFQCNAbsolute<cr>
nnoremap <buffer> <Leader>E :PHPExpandFQCN<cr>
