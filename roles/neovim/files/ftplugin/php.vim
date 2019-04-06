augroup php
  au!
  au BufNewFile,BufRead *.phtml set ft=php.html
  au BufNewFile,BufRead,BufWinEnter *Test.php exe ":UltiSnipsAddFiletypes php.phpunit"
  au BufNewFile,BufRead,BufWinEnter *Spec.php exe ":UltiSnipsAddFiletypes php.php-phpspec"
augroup END

let g:php_folding = 1
set foldmethod=syntax
set foldlevel=1
set foldnestmax=2
set nofoldenable

setlocal tabstop=4 shiftwidth=4


nnoremap <buffer> gn :call phpactor#Navigate()<CR>

nnoremap <buffer> <silent> <leader>W :w<cr>
nnoremap <buffer> <m-f> :call PHPUnitSetupMethod()<cr>
nnoremap <buffer> <leader>rrp :call PhpRenameClassVariable()<CR>
nnoremap <buffer> <leader>rrm :call PhpRenameMethod()<CR>
nnoremap <buffer> <leader>rlv :call PhpRenameLocalVariable()<CR>
nnoremap <buffer> <leader>reu :call PhpExtractUse()<CR>
vnoremap <buffer> <leader>rec :call PhpExtractConst()<CR>
nnoremap <buffer> <leader>rep :call PhpExtractClassProperty()<cr>
vnoremap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
vnoremap <buffer> <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
nnoremap <buffer> <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>
nnoremap <buffer> <leader>H :call PhpConstructorArgumentMagic2()<cr>
nnoremap <buffer> <leader>rcc :call PhpConstructorArgumentMagic()<cr>:sleep 300m<cr>:e<cr>
nnoremap <buffer> <leader>rmc :call PHPMoveClass()<cr>
nnoremap <buffer> <leader>rmd :call PHPMoveDir()<cr>
nnoremap <buffer> <m-m> :call phpactor#ContextMenu()<cr>
nnoremap <buffer> <leader>ric :call PHPModify("implement_contracts")<cr>
nnoremap <buffer> <leader>rap :call PHPModify("add_missing_properties")<cr>
nnoremap <buffer> <leader>rei :call PHPExtractInterface()<cr>
nnoremap <buffer> <Leader>u :PHPImportClass<cr>
nnoremap <buffer> <Leader>e :PHPExpandFQCNAbsolute<cr>
nnoremap <buffer> <Leader>E :PHPExpandFQCN<cr>
nnoremap <buffer> <leader>h :call UpdatePhpDocIfExists()<CR>
nnoremap <buffer> <leader>rdo :call PhpDocOneliner()<cr>

" nnoremap <silent> gr :call phpactor#FindReferences()<CR>
let g:neomake_php_enabled_makers = ['phpmd', 'phpcs', 'phpstan', 'php']
let g:neomake_php_phpcs_args_standard = 'PSR2'
let g:neomake_php_phpcs_maker = {
            \ 'args': ['--report=csv'],
            \ 'errorformat':
            \ '%-GFile\,Line\,Column\,Type\,Message\,Source\,Severity%.%#,'.
            \ '"%f"\,%l\,%c\,%t%*[a-zA-Z]\,"%m"\,%*[a-zA-Z0-9_.-]\,%*[0-9]%.%#',
            \ 'postprocess': function('SetWarningType'),
            \ }

let g:neomake_php_phpstan_maker = {
            \ 'args': ['analyse', '--error-format', 'raw', '--no-progress', '--level', '7'],
            \ 'errorformat': '%W%f:%l:%m',
            \ 'postprocess': function('SetWarningType'),
            \ }

let g:neomake_php_php_maker = {
            \ 'args': ['-l', '-d', 'display_errors=1', '-d', 'log_errors=0',
            \      '-d', 'xdebug.cli_color=0'],
            \ 'errorformat':
            \ '%-GNo syntax errors detected in%.%#,'.
            \ '%EParse error: %#syntax error\, %m in %f on line %l,'.
            \ '%EParse error: %m in %f on line %l,'.
            \ '%EFatal error: %m in %f on line %l,'.
            \ '%-G\s%#,'.
            \ '%-GErrors parsing %.%#',
            \ 'output_stream': 'stdout',
            \ 'postprocess': function('SetErrorType'),
            \ }

let g:neomake_php_phpmd_maker = {
            \ 'args': ['%:p', 'text', 'cleancode,codesize,design,unusedcode,naming'],
            \ 'errorformat': '%W%f:%l%\s%\s%#%m',
            \ 'postprocess': function('SetMessageType'),
            \ }

" let g:ale_php_phpcbf_standard='PSR2'
" let g:ale_php_phpcbf_standard='Symfony'
" let g:ale_php_phpcs_standard='phpcs.xml.dist'
" let g:ale_php_phpmd_ruleset='phpmd.xml'
let g:ultisnips_php_scalar_types = 1
let g:PHP_removeCRwhenUnix = 1
let g:php_manual_online_search_shortcut = '<leader>m'

" nnoremap <buffer> <m-a> :call SymfonySwitchToAlternateFile()<cr> " set via projects.public.vim
" nnoremap <buffer> <leader>tsa <c-w>v:call SymfonySwitchToAlternateFile()<cr>

function! PHPUnitSetupMethod()
  normal! oprotected function setUp()
  normal! o{
  normal! o}
  normal! kp
  while getline('.') =~ '\$'
    normal! ==
    :s/\(\w\+\) \(\$\w\+\),*/\2 = Phake::mock(\1::class);
    normal! 0f$l
    call PhpExtractClassProperty()
    normal! j
  endwhile
endfunction

let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_use_default_mapping = 0
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"

function! PhpConstructorArgumentMagic()
    " update phpdoc
    if exists("*UpdatePhpDocIfExists")
        normal! gg
        /__construct
        normal! n
        :call UpdatePhpDocIfExists()
        :w
    endif
    :call PHPModify("complete_constructor")
endfunction


function! PhpConstructorArgumentMagic2()
    let l:currentLine = getline('.')
    if l:currentLine !~ '\$'
        echo "no $ found, are you on a line with an argument?"
        return 0
    endif

    normal! 0f$
    normal! mb

    " yank variable
    if l:currentLine =~ ','
        normal! "ayt,
    elseif l:currentLine =~ ')'
        normal! "ayt)
    else
        normal! "ayW
    endif

    " search for closing brace
    /{
    normal! nf{
    normal! %O

    " property assignment
    normal! "apa =
    normal! "apA;
    s/\$/$this->/

    " create property
    normal! 2joprivate
    normal! "apa;
    " mark for adding docblock
    normal! mc

    " jump back into __construct
    normal! 'b

    " has typehint?
    if getline('.') =~ '\s*\S\+\s\$'
        " create docblock
        normal! 0f$b"ayt 'c
        normal! O/**
        normal! o@var
        normal! "apo/
        " move var declaration up
        normal! jd3kG%p%jo

        " update phpdoc
        if exists("*UpdatePhpDocIfExists")
            /__construct
            normal! n
            :call UpdatePhpDocIfExists()
        endif
    endif

    "cleanup
    normal! gg=G
    :w

    " jump to where we have started
    normal! 'b
endfunction

function! PhpDocOneliner()
    let l:currentLine = getline('.')
    if l:currentLine =~ '@'
        normal! k
    endif
    if l:currentLine =~ '*/'
        normal! 2k
    endif
    normal JxxJ
endfunction

" visually mark the code you want to extract into variable
" (for now only works with single line selection)
function! PHPExtractVariable()
    let l:name = input("Name of new variable: $")
    normal! gvx
    execute "normal! i$".l:name
    execute "normal! O$".l:name." = "
    normal! pa;
    normal! bgr
endfunction

let g:phpactor_executable = '~/.config/nvim/plugged/phpactor/bin/phpactor'

if !exists("*PHPMoveClass")
  function! PHPMoveClass()
      :w
      let l:oldPath = expand('%')
      let l:newPath = input("New path: ", l:oldPath)
      execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
      execute "bd ".l:oldPath
      execute "e ". l:newPath
  endfunction
endif

if !exists("*PHPMoveDir")
  function! PHPMoveDir()
      :w
      let l:oldPath = input("old path: ", expand('%:p:h'))
      let l:newPath = input("New path: ", l:oldPath)
      execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
  endfunction
endif

if !exists("*PHPModify")
  function! PHPModify(transformer)
      :update
      let l:cmd = "silent !".g:phpactor_executable." class:transform ".expand('%').' --transform='.a:transformer
      execute l:cmd
  endfunction
endif

if !exists("*PHPExtractInterface")
  function! PHPExtractInterface()
      :w
      let l:interfaceFile = substitute(expand('%'), '.php', 'Interface.php', '')
      execute "!".g:phpactor_executable." class:inflect ".expand('%').' '.l:interfaceFile.' interface'
      execute "e ". l:interfaceFile
  endfunction
endif

if !exists("*PHPExtractInterface")
  function! PHPCreateBuilder()
      :w
      let l:interfaceFile = substitute(expand('%'), '.php', 'Builder.php', '')
      execute "!".g:phpactor_executable." class:inflect ".expand('%').' '.l:interfaceFile.' builder'
      execute "e ". l:interfaceFile
  endfunction
endif

function! LegacyExtractInterface()
    let l:file_path = expand('%:p:h')
    let l:baseFile = expand('%')
    let l:name = inputdialog("Name of new interface:")
    exe "normal Gointerface " . name . "\<Cr>{}\<c-o>i\<cr>"
    :g/const/ :normal yyGP
    ":g/public \$/ :normal yyGP
    :g/public function \(__construct\)\@!/ :normal yyGP$a;
    exe "normal! G?{\<cr>"
    normal "adGdd
    exe ":e ".l:file_path."/".l:name.".php"
    exe ":w"
    exe "normal i<?php\<cr>\<cr>interface ".l:name
    exe "normal! ?interface\<cr>jdG"
    normal "ap
    exe ":e ".l:baseFile
    exe "normal! gg/{\<cr>k"
    if getline('.') =~ ' implements '
        let l:interfaceImplementation = "A, ".l:name
    else
        let l:interfaceImplementation = "$a implements ".l:name
    endif
    exe "normal! ".l:interfaceImplementation
    exe ":w"
endfunction

let g:pdv_cfg_autoEndClass = 0
let g:pdv_cfg_php4always = 0
let g:pdv_cfg_autoEndFunction = 0
let g:pdv_cfg_FunctionName = 0
let g:pdv_cfg_Type = ""
let g:pdv_cfg_annotation_Author = 0
let g:pdv_cfg_annotation_Copyright = 0
let g:pdv_cfg_annotation_License = 0
let g:pdv_cfg_annotation_Package = 0
let g:pdv_cfg_annotation_Version = 0
let g:pdv_cfg_InsertFuncName = 0
let g:pdv_cfg_InsertVarName = 0

" https://github.com/AJenbo/php-refactoring-browser
let g:php_refactor_command='php ~/compiles/php-refactoring-browser/refactor.phar'


function! UpdatePhpDocIfExists()
    normal! k
    if getline('.') =~ '/'
        normal! V%d
    else
        normal! j
    endif
    call PhpDocSingle()
    normal! k^%k$
    if getline('.') =~ ';'
        exe "normal! $svoid"
    endif
endfunction


" SymfonySwitchToAlternateFile {{{

" changes to test/sut files
" following structure:
" sut: <dir1>/<dir2>/<dir3>/<dir4>/.../<file>.php
" test: <dir1>/<dir2>/<dir3>/Tests/<dir4>/.../<file>Test.php
"
" example:
" sut:  src/Acme/Bundle/Service/MyService.php
" test: src/Acme/Bundle/Tests/Service/MyServiceTest.php

if !exists("*SymfonySwitchToAlternateFile")
  function! SymfonySwitchToAlternateFile()
    let l:f = expand('%')
    if !exists("g:switch_alternate_dirs_to_keep")
      let g:switch_alternate_dirs_to_keep = 2
    endif
    let l:is_test = expand('%:t') =~ "Test\."
    if l:is_test
      " remove phpunit_testroot
      let l:f = substitute(l:f, 'Tests/','','')
      " remove 'Test.' from filename
      let l:f = substitute(l:f,'Test\.','.','')
    else
      let l:pathParts = split(expand('%:r'), '/')
      let l:startingPath = l:pathParts[0:g:switch_alternate_dirs_to_keep]
      let l:endPath = l:pathParts[(g:switch_alternate_dirs_to_keep+1):]
      let l:combinedPath = l:startingPath + ['Tests'] + l:endPath
      let l:f = join(l:combinedPath, '/') . 'Test.php'
      if !filereadable(l:f)
        let l:new_dir = substitute(l:f, '/\w\+\.php', '', '')
        exe ":!mkdir -p ".l:new_dir
      endif
    endif
    " is there window with alternate file open?
    let win = bufwinnr(l:f)
    if l:win > 0
      execute l:win . "wincmd w"
    else
      execute ":e " . l:f
    endif
  endfunction
endif
" }}}

