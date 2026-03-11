augroup yaml
  au!
  au BufNewFile,BufRead,BufEnter *.yml.jinja,*.yaml.jinja set ft=yaml
augroup END

setlocal tabstop=2 sts=2 sw=2 expandtab

nnoremap <buffer> <Leader>ref :PHPExpandFQCNAbsolute<cr>
nnoremap <buffer> <Leader>E :PHPExpandFQCN<cr>
