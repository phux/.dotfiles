so ~/.projects.private.vim

function! Zf1(...) abort
    let g:ultisnips_php_scalar_types = 0

    nnoremap <c-s> :update<cr>:Silent php-cs-fixer fix %:p --rules=@Symfony<cr>:Silent phpcbf --standard=Symfony3Custom %:p > /dev/null<cr>:e<cr>

    nnoremap <silent> <leader>w :w<cr>

    nnoremap <silent> <leader>tu :call SwitchBetweenFiles('php', 'tests/', 'library/', 'Test')<cr>
    nnoremap <silent> <leader>tsu <c-w>v:call SwitchBetweenFiles('php', 'tests/', 'library/', 'Test')<cr>
    " set omnifunc=LanguageClient#complete
    " autocmd FileType php LanguageClientStart
    nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
    let g:cm_auto_popup=0 " disable nvim-completion-manager
    call deoplete#enable()

    " au filetype php set omnifunc=phpcomplete#CompletePHP
endfunction

function! Symfony(...) abort
    call deoplete#disable()
    let g:ultisnips_php_scalar_types = 1

    nnoremap <silent> <c-s> :update<cr>:Silent php-cs-fixer fix %:p --rules=@Symfony<cr>:Silent phpcbf --standard=Symfony3Custom %:p > /dev/null<cr>:e<cr>
    " nnoremap <silent> <c-s> gg=G:update<cr>:Silent php-cs-fixer fix %:p<cr>:Silent phpcbf --standard=Symfony3Custom %:p > /dev/null<cr>:e<cr>:w<cr>
    " nnoremap <silent> <c-s> :update<cr>:Silent php-cs-fixer fix %:p<cr>:Silent phpcbf %:p > /dev/null<cr>:e<cr>:w<cr>

    nnoremap <leader>tu :call SymfonySwitchToAlternateFile()<cr>
    nnoremap <leader>tsu <c-w>v:call SymfonySwitchToAlternateFile()<cr>
    nnoremap <silent> gd :call phpactor#GotoDefinition()<CR>
    nnoremap <silent> gr :call phpactor#FindReferences()<CR>
    vnoremap <leader>rem :call phpactor#ExtractMethod()<cr>
    let g:deoplete#sources.php = []
    au filetype php set omnifunc=phpactor#Complete
endfunction
