so ~/.projects.private.vim

function! Zf1(...) abort
    let g:ultisnips_php_scalar_types = 0

    nnoremap <silent> <c-s> :update<cr>:Silent ecs check --config ~/.easy-coding-standard5.yml --fix %:p <cr>

    nnoremap <silent> <leader>w :w<cr>

    nnoremap <silent> <m-a> :call SwitchBetweenFiles('php', 'tests/', 'library/', 'Test')<cr>
    nnoremap <silent> <leader>tsa <c-w>v:call SwitchBetweenFiles('php', 'tests/', 'library/', 'Test')<cr>

    " let g:cm_auto_popup=0 " disable nvim-completion-manager
    " call deoplete#enable()

    let g:ale_fixers['php'] = []
    let g:ale_linters['php'] = ['php', 'phpmd', 'phpcs']
    let g:ale_php_phpcbf_standard='Symfony'
    let g:ale_php_phpcs_standard='phpcs.xml.dist'
    let g:ale_php_phpmd_ruleset='phpmd.xml'
endfunction

function! Symfony(...) abort
    let g:ultisnips_php_scalar_types = 1

    " nnoremap <silent> <c-s> :update<cr>:Silent php-cs-fixer fix %:p --rules=@Symfony<cr>:Silent phpcbf --standard=Symfony %:p > /dev/null<cr>:e<cr>
    nnoremap <silent> <c-s> :update<cr>:Silent ecs check --config ~/.easy-coding-standard7.yml --fix %:p <cr>

    nnoremap <m-a> :call SymfonySwitchToAlternateFile()<cr>
    nnoremap <silent> gd :call phpactor#GotoDefinition()<CR>
    nnoremap <silent> gr :call phpactor#FindReferences()<CR>
    nnoremap <leader>tt :call phpactor#Transform()<cr>

    augroup completion_php
      au filetype php set omnifunc=phpactor#Complete
    augroup end

    " let g:ale_fixers['php'] = ['phpcbf', 'php_cs_fixer']
    " let g:ale_php_phpcbf_standard='Symfony'
    " let g:ale_php_phpcs_standard='phpcs.xml.dist'
    " let g:ale_php_phpmd_ruleset='phpmd.xml'
endfunction

function! PhpAllDisabled(...) abort
    let g:ultisnips_php_scalar_types = 0

    nnoremap <silent> <c-s> :update<cr>:Silent php-cs-fixer fix %:p --rules=@Symfony<cr>:Silent phpcbf --standard=Symfony %:p > /dev/null<cr>:e<cr>

    nnoremap <m-a> :call SymfonySwitchToAlternateFile()<cr>
    nnoremap <leader>tsa <c-w>v:call SymfonySwitchToAlternateFile()<cr>
    nnoremap <silent> gd :call phpactor#GotoDefinition()<CR>
    nnoremap <silent> gr :call phpactor#FindReferences()<CR>
    nnoremap <leader>tt :call phpactor#Transform()<cr>

    let g:neomake_php_enabled_makers = ['php', 'phpmd', 'phpcs', 'phpstan']
    let g:neomake_php_enabled_makers = ['php']
    let g:neomake_open_list = 2
endfunction
