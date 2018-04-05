so ~/.projects.private.vim

function! Zf1(...) abort
    let g:ultisnips_php_scalar_types = 0

    " nnoremap <c-s> :update<cr>:Silent php-cs-fixer fix %:p --rules=@Symfony<cr>:Silent phpcbf --standard=Symfony3Custom %:p > /dev/null<cr>:e<cr>
    " nnoremap <c-s> :update<cr>:Silent php-cs-fixer fix %:p --rules=@Symfony<cr>:Silent phpcbf %:p > /dev/null<cr>:e<cr>
    nnoremap <c-s> :update<cr>:Silent ecs check --fix %:p -c ~/.dotfiles/.easy-coding-standard5.yml<cr>
    nnoremap <silent> <leader>w :w<cr>

    nnoremap <silent> <m-a> :call SwitchBetweenFiles('php', 'tests/', 'library/', 'Test')<cr>
    nnoremap <silent> <leader>tsu <c-w>v:call SwitchBetweenFiles('php', 'tests/', 'library/', 'Test')<cr>
    " autocmd FileType php set omnifunc=phpcd
    nnoremap <silent> gd g<c-]>

    vnoremap <leader>rem :call PhpRefactorExtractMethodDirectly()<CR>
    let g:cm_auto_popup=0 " disable nvim-completion-manager
    call deoplete#enable()

    let g:neomake_php_enabled_makers = ['php', 'phpmd', 'phpcs']
    let g:neomake_open_list = 2

    " au filetype php set omnifunc=phpcomplete#CompletePHP
endfunction

function! Symfony(...) abort
    call deoplete#disable()
    let g:ultisnips_php_scalar_types = 1

    " nnoremap <silent> <c-s> :update<cr>:Silent php-cs-fixer fix %:p --rules=@Symfony<cr>:Silent phpcbf --standard=Symfony3Custom %:p > /dev/null<cr>:e<cr>

    nnoremap <c-s> :update<cr>:Silent ecs check --fix %:p -c ~/.dotfiles/.easy-coding-standard7.yml<cr>
    " nnoremap <silent> <c-s> gg=G:update<cr>:Silent php-cs-fixer fix %:p<cr>:Silent phpcbf --standard=Symfony3Custom %:p > /dev/null<cr>:e<cr>:w<cr>
    " nnoremap <silent> <c-s> :update<cr>:Silent php-cs-fixer fix %:p<cr>:Silent phpcbf %:p > /dev/null<cr>:e<cr>:w<cr>

    nnoremap <m-a> :call SymfonySwitchToAlternateFile()<cr>
    nnoremap <leader>tsu <c-w>v:call SymfonySwitchToAlternateFile()<cr>
    nnoremap <silent> gd :call phpactor#GotoDefinition()<CR>
    nnoremap <silent> gr :call phpactor#FindReferences()<CR>
    vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
    nnoremap <leader>tt :call phpactor#Transform()<cr>

    let g:deoplete#sources.php = []
    au filetype php set omnifunc=phpactor#Complete
    let g:neomake_php_enabled_makers = ['php', 'phpmd', 'phpcs', 'phpstan']
    let g:neomake_php_enabled_makers = ['php', 'phpmd', 'phpcs']
    let g:neomake_open_list = 2
endfunction
