so ~/.projects.private.vim

function! Zf1(...) abort
    let g:neomake_php_phpcs_args_standard="Zend"
    let g:neomake_php_php_exe = 'php5.6'
    let g:ultisnips_php_scalar_types = 0

    nnoremap <c-s> :update<cr>:Silent php-cs-fixer fix %:p --rules=@Symfony<cr>:e<cr>

    nnoremap <silent> <leader>tu :call SwitchBetweenFiles('php', 'tests/', 'library/', 'Test')<cr>
    nnoremap <silent> <leader>tsu <c-w>v:call SwitchBetweenFiles('php', 'tests/', 'library/', 'Test')<cr>
endfunction

function! Symfony(...) abort
    let g:neomake_php_php_exe = 'php'
    let g:neomake_php_phpcs_args_standard="~/code/ruleset.xml"
    let g:ultisnips_php_scalar_types = 1

    nnoremap <silent> <c-s> :update<cr>:Silent php-cs-fixer fix %:p --rules=@Symfony<cr>:Silent phpcbf --standard=Symfony3Custom %:p > /dev/null<cr>:e<cr>

    nnoremap <leader>tu :call SymfonySwitchToAlternateFile()<cr>
    nnoremap <leader>tsu <c-w>v:call SymfonySwitchToAlternateFile()<cr>
endfunction
