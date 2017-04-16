so ~/.projects.private.vim

function! Zf1(...) abort
    let g:ale_php_phpcs_standard = '~/code/ruleset_zend.xml'
    let g:ultisnips_php_scalar_types = 0

    " let g:deoplete#omni_patterns = {}
    " let g:deoplete#omni_patterns.php =
    "             \ '$\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

    nnoremap <c-s> :update<cr>:Silent php-cs-fixer fix %:p --rules=@Symfony<cr>:e<cr>


    nnoremap <silent> <leader>w :ALEDisable<cr>:w<cr>

    nnoremap <silent> <leader>tu :call SwitchBetweenFiles('php', 'tests/', 'library/', 'Test')<cr>
    nnoremap <silent> <leader>tsu <c-w>v:call SwitchBetweenFiles('php', 'tests/', 'library/', 'Test')<cr>
endfunction

function! Symfony(...) abort
    let g:ale_php_phpcs_standard = '~/code/ruleset_sf3.xml'
    let g:ultisnips_php_scalar_types = 1

    nnoremap <silent> <c-s> :update<cr>:Silent php-cs-fixer fix %:p --rules=@Symfony<cr>:Silent phpcbf --standard=Symfony3Custom %:p > /dev/null<cr>:e<cr>

    nnoremap <leader>tu :call SymfonySwitchToAlternateFile()<cr>
    nnoremap <leader>tsu <c-w>v:call SymfonySwitchToAlternateFile()<cr>
endfunction
