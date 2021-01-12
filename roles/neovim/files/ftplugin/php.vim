augroup php
  au!
  au BufNewFile,BufRead *.phtml set ft=php.html
  " au BufNewFile,BufRead,BufWinEnter *Test.php exe ":UltiSnipsAddFiletypes php.phpunit"
  " au BufNewFile,BufRead,BufWinEnter *Spec.php exe ":UltiSnipsAddFiletypes php.php-phpspec"
  " au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags php' &
  " au BufWritePost *.php silent! !eval '[ -f "../.git/hooks/ctags" ] && ../.git/hooks/ctags php' &
  " au BufWritePost *.php silent! exe ":!phpcbf --standard=~/.phpcs.xml ".expand('%:f')."; php-cs-fixer --config=.php_cs fix ".expand('%:f') | :e
  au BufWritePost *.php silent! exe "!php-cs-fixer --config=.php_cs fix ".expand('%:f') | :e
  au BufNewFile,BufRead,BufEnter *.php set tags=.git/tags.php,../.git/tags.php
augroup END

" let g:php_folding = 1
" set foldmethod=syntax
" set foldlevelstart=1
" set foldlevel=1
" set foldnestmax=2
" set nofoldenable


" nnoremap <buffer> <leader>nr :call phpactor#FindReferences()<cr>
" nnoremap <buffer> <leader>ni :call phpactor#GotoImplementations()<cr>
nnoremap <buffer> <leader>nn :call phpactor#Navigate()<cr>
nnoremap <buffer> <leader>na :call SymfonySwitchToAlternateFile()<cr>
nnoremap <buffer> <leader>rm :PhpactorMoveFile<cr>
vnoremap <buffer> <silent><leader>rev :<C-U>PhpactorExtractExpression<CR>
nnoremap <buffer> <silent><leader>rev :PhpactorExtractExpression<CR>
vnoremap <buffer> <leader>rem :<C-U>PhpactorExtractMethod<CR>
" vnoremap <buffer> <leader>rec :call PhpExtractConst()<CR>
" nnoremap <buffer> <leader>rr :<C-U>call phpactor#ContextMenu()<CR>
nnoremap <buffer> <leader>rd :call UpdatePhpDocIfExists()<CR>
nnoremap <buffer> <leader>rt :call phpactor#Transform()<CR>
nnoremap <buffer> <leader>rep :call PhpExtractClassProperty()<cr>
nnoremap <buffer> <Leader>ref :PHPExpandFQCNAbsolute<cr>
nnoremap <buffer> <leader>reu :call PhpExtractUse()<CR>
nnoremap <buffer> <leader>ru :PhpactorImportMissingClasses<cr>
" nnoremap <buffer> <Leader>u :PHPImportClass<cr>

nnoremap <buffer> <leader>c :PhpactorContextMenu<cr>

let b:ale_linters = ['php', 'phpstan']
let g:ale_php_phpstan_executable = 'vendor/bin/phpstan'
let g:ale_php_cs_fixer_options = '--config=".php_cs"'
let g:ale_php_cs_fixer_use_global = 0
let g:ale_php_phpstan_configuration = 'phpstan.neon'
let g:ale_php_phpstan_level = 'max'
let g:ale_php_phpcbf_standard='~/.phpcs.xml'
" let g:ale_php_phpcbf_standard='Symfony'
let g:ale_php_phpcs_standard='~/.phpcs.xml'
" let g:ale_php_phpcs_standard='Symfony'
let g:ale_php_phpmd_ruleset='~/.phpmd.xml'
let g:ultisnips_php_scalar_types = 1
let g:PHP_removeCRwhenUnix = 1

" function! PHPUnitSetupMethodPhake()
"   normal! oprotected function setUp()
"   normal! o{
"   normal! o}
"   normal! kp
"   while getline('.') =~ '\$'
"     normal! ==
"     :s/\(\w\+\) \(\$\w\+\),*/\2 = Phake::mock(\1::class);
"     normal! 0f$l
"     call PhpExtractClassProperty()
"     normal! j
"   endwhile
" endfunction

function! PHPUnitSetupMethod()
  normal! oprotected function setUp(): void
  normal! o{
  normal! o}
  normal! kp
  while getline('.') =~ '\$'
    normal! ==
    :s/\(\w\+\) \(\$\)\(\w\+\),*/\2this->\3 = self::createMock(\1::class);
    normal! 0f$l
    " call PhpExtractClassProperty()
    normal! j
  endwhile
  normal! O$this-> = new ABC(
  normal! p
  while getline('.') =~ '\$'
    normal! ==
    :s/\(\w\+\) \(\$\)\(\w\+\),*/\2this->\3,
    normal! 0f$l
    " call PhpExtractClassProperty()
    normal! j
  endwhile
  normal! O);
endfunction

let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_use_default_mapping = 0
" let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"

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


"function! PhpConstructorArgumentMagic2()
"    let l:currentLine = getline('.')
"    if l:currentLine !~ '\$'
"        echo "no $ found, are you on a line with an argument?"
"        return 0
"    endif

"    normal! 0f$
"    normal! mb

"    " yank variable
"    if l:currentLine =~ ','
"        normal! "ayt,
"    elseif l:currentLine =~ ')'
"        normal! "ayt)
"    else
"        normal! "ayW
"    endif

"    " search for closing brace
"    /{
"    normal! nf{
"    normal! %O

"    " property assignment
"    normal! "apa =
"    normal! "apA;
"    s/\$/$this->/

"    " create property
"    normal! 2joprivate
"    normal! "apa;
"    " mark for adding docblock
"    normal! mc

"    " jump back into __construct
"    normal! 'b

"    " has typehint?
"    if getline('.') =~ '\s*\S\+\s\$'
"        " create docblock
"        normal! 0f$b"ayt 'c
"        normal! O/**
"        normal! o@var
"        normal! "apo/
"        " move var declaration up
"        normal! jd3kG%p%jo

"        " update phpdoc
"        if exists("*UpdatePhpDocIfExists")
"            /__construct
"            normal! n
"            :call UpdatePhpDocIfExists()
"        endif
"    endif

"    "cleanup
"    normal! gg=G
"    :w

"    " jump to where we have started
"    normal! 'b
"endfunction

" function! PhpDocOneliner()
"     let l:currentLine = getline('.')
"     if l:currentLine =~ '@'
"         normal! k
"     endif
"     if l:currentLine =~ '*/'
"         normal! 2k
"     endif
"     normal JxxJ
" endfunction

" let g:phpactor_executable = '~/.config/nvim/plugged/phpactor/bin/phpactor'
let g:phpactor_executable = '~/.local/share/nvim/site/pack/packer/opt/phpactor/bin/phpactor'

" if !exists("*PHPMoveClass")
"   function! PHPMoveClass()
"       :w
"       let l:oldPath = expand('%')
"       let l:newPath = input("New path: ", l:oldPath)
"       execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
"       execute "bd ".l:oldPath
"       execute "e ". l:newPath
"   endfunction
" endif

" if !exists("*PHPMoveDir")
"   function! PHPMoveDir()
"       :w
"       let l:oldPath = input("old path: ", expand('%:p:h'))
"       let l:newPath = input("New path: ", l:oldPath)
"       execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
"   endfunction
" endif

" if !exists("*PHPModify")
"   function! PHPModify(transformer)
"       :update
"       let l:cmd = "silent !".g:phpactor_executable." class:transform ".expand('%').' --transform='.a:transformer
"       execute l:cmd
"   endfunction
" endif

" if !exists("*PHPExtractInterface")
"   function! PHPCreateBuilder()
"       :w
"       let l:interfaceFile = substitute(expand('%'), '.php', 'Builder.php', '')
"       execute "!".g:phpactor_executable." class:inflect ".expand('%').' '.l:interfaceFile.' builder'
"       execute "e ". l:interfaceFile
"   endfunction
" endif

" let g:pdv_cfg_autoEndClass = 0
" let g:pdv_cfg_php4always = 0
" let g:pdv_cfg_autoEndFunction = 0
" let g:pdv_cfg_FunctionName = 0
" let g:pdv_cfg_Type = ""
" let g:pdv_cfg_annotation_Author = 0
" let g:pdv_cfg_annotation_Copyright = 0
" let g:pdv_cfg_annotation_License = 0
" let g:pdv_cfg_annotation_Package = 0
" let g:pdv_cfg_annotation_Version = 0
" let g:pdv_cfg_InsertFuncName = 0
" let g:pdv_cfg_InsertVarName = 0

" https://github.com/AJenbo/php-refactoring-browser

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


" changes to test/sut files
" following structure:
" sut: <dir1>/<dir2>/<dir3>/<dir4>/.../<file>.php
" test: <dir1>/<dir2>/<dir3>/Tests/<dir4>/.../<file>Test.php
"
" example:
" sut:  src/Acme/Bundle/Service/MyService.php
" test: src/Acme/Bundle/Tests/Service/MyServiceTest.php

let g:prefix_dir = ''
if !exists("*SymfonySwitchToAlternateFile")
  function! SymfonySwitchToAlternateFile()
    if !exists("g:prefix_dir")
        let g:prefix_dir = ''
    endif
    let l:f = expand('%')
    if !exists("g:switch_alternate_dirs_to_keep")
      let g:switch_alternate_dirs_to_keep = 2
    endif
    if expand('%:t') =~ "Test\."
      " remove phpunit_testroot
      let l:f = substitute(l:f, 'tests/','src/','')
      " remove 'Test.' from filename
      let l:f = substitute(l:f,'Test\.','.','')
    else
      " let l:pathParts = split(expand('%:r'), '/')
      " let l:startingPath = l:pathParts[0:g:switch_alternate_dirs_to_keep]
      " let l:endPath = l:pathParts[(g:switch_alternate_dirs_to_keep+1):]
      " let l:combinedPath = ['tests/'] + l:startingPath + l:endPath
      " if g:prefix_dir != ''
      "     let l:startingPath = l:pathParts[1:]
      "     let l:combinedPath = [g:prefix_dir] + l:startingPath
      " endif
      let l:f = substitute(l:f, 'src/','tests/','')
      let l:f = substitute(l:f, '\.php','Test.php','')
      if !filereadable(l:f)
        let l:new_dir = substitute(l:f, '/\w\+\.php', '', '')
        exe ":silent !mkdir -p ".l:new_dir
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

" setlocal tabstop=2 shiftwidth=2 et autoindent smartindent
