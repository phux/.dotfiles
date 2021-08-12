let b:ale_linters = ['eslint']
let g:ale_javascript_eslint_executable = 'cd  portal && eslint_d'
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_options = '--cache'

augroup typescriptreact_ftplugin
  au!
  au BufWritePost *.tsx,*.ts,*.js,*.jsx silent! exe "!cd portal && eslint_d --fix --cache -c ../.eslintrc.json ".substitute(expand('%:f'), '^portal/', '', '') | :e
augroup END

setlocal tabstop=2 shiftwidth=2
