so ~/.projects.private.vim

function! Zf1(...) abort
    let g:ultisnips_php_scalar_types = 0

    " let g:deoplete#omni_patterns = {}
    " let g:deoplete#omni_patterns.php =
    "             \ '$\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

    nnoremap <c-s> :update<cr>:Silent php-cs-fixer fix %:p --rules=@Symfony<cr>:Silent phpcbf --standard=Symfony3Custom %:p > /dev/null<cr>:e<cr>

    nnoremap <silent> <leader>w :w<cr>

    nnoremap <silent> <leader>tu :call SwitchBetweenFiles('php', 'tests/', 'library/', 'Test')<cr>
    nnoremap <silent> <leader>tsu <c-w>v:call SwitchBetweenFiles('php', 'tests/', 'library/', 'Test')<cr>
    setlocal omnifunc=LanguageClient#complete
endfunction

function! Symfony(...) abort
    let g:ultisnips_php_scalar_types = 1

    nnoremap <silent> <c-s> :update<cr>:Silent php-cs-fixer fix %:p --rules=@Symfony<cr>:Silent phpcbf --standard=Symfony3Custom %:p > /dev/null<cr>:e<cr>
    " nnoremap <silent> <c-s> gg=G:update<cr>:Silent php-cs-fixer fix %:p<cr>:Silent phpcbf --standard=Symfony3Custom %:p > /dev/null<cr>:e<cr>:w<cr>
    " nnoremap <silent> <c-s> :update<cr>:Silent php-cs-fixer fix %:p<cr>:Silent phpcbf %:p > /dev/null<cr>:e<cr>:w<cr>

    nnoremap <leader>tu :call SymfonySwitchToAlternateFile()<cr>
    nnoremap <leader>tsu <c-w>v:call SymfonySwitchToAlternateFile()<cr>
    setlocal omnifunc=phpactor#Complete
endfunction
