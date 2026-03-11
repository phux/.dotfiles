augroup typescriptreact_ftplugin
  au!
  au BufWritePost *.tsx,*.ts,*.js,*.jsx silent! exe "!cd portal && eslint_d --fix --cache -c ../.eslintrc.json ".substitute(expand('%:f'), '^portal/', '', '') | :e
augroup END

setlocal tabstop=2 shiftwidth=2
