augroup php
  au!
  au BufNewFile,BufRead *.phtml set ft=php.html
  au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags php' &
  au BufWritePost *.php silent! !eval '[ -f "../.git/hooks/ctags" ] && ../.git/hooks/ctags php' &
  au BufWritePost *.php silent! exe "!php-cs-fixer --config=".getcwd()."/.php-cs-fixer.php fix ".expand('%:f') | :e
  au BufNewFile,BufRead,BufEnter *.php set tags=.git/tags.php,../.git/tags.php
augroup END

setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4


nnoremap <buffer> <leader>nn :call phpactor#Navigate()<cr>
nnoremap <buffer> <leader>na :call SymfonySwitchToAlternateFile()<cr>
nnoremap <buffer> <leader>rm :PhpactorMoveFile<cr>
vnoremap <buffer> <leader>rem :<C-U>PhpactorExtractMethod<CR>
nnoremap <buffer> <leader>rd :call UpdatePhpDocIfExists()<CR>
nnoremap <buffer> <leader>rt :PhpactorTransform<CR>
nnoremap <buffer> <leader>rep :call PhpExtractClassProperty()<cr>
nnoremap <buffer> <Leader>ref :PhpactorClassExpand<cr>
nnoremap <buffer> <leader>reu :call PhpExtractUse()<CR>
nnoremap <buffer> <leader>ru :PhpactorImportMissingClasses<cr>

nnoremap <buffer> <leader>c :PhpactorContextMenu<cr>
vnoremap <buffer> <leader>c :PhpactorContextMenu<cr>

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



" let g:phpactor_executable = '~/.config/nvim/plugged/phpactor/bin/phpactor'
let g:phpactor_executable = '~/.local/share/nvim/site/pack/packer/opt/phpactor/bin/phpactor'


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
