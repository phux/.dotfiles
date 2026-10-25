setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4

nnoremap <buffer> <leader>na :call SymfonySwitchToAlternateFile()<cr>
nnoremap <buffer> <leader>rd :call UpdatePhpDocIfExists()<CR>

let g:PHP_removeCRwhenUnix = 1

function! PHPUnitSetupMethod()
  normal! oprotected function setUp(): void
  normal! o{
  normal! o}
  normal! kp
  while getline('.') =~ '\$'
    normal! ==
    :s/\(\w\+\) \(\$\)\(\w\+\),*/\2this->\3 = self::createMock(\1::class);
    normal! 0f$l
    normal! j
  endwhile
  normal! O$this-> = new ABC(
  normal! p
  while getline('.') =~ '\$'
    normal! ==
    :s/\(\w\+\) \(\$\)\(\w\+\),*/\2this->\3,
    normal! 0f$l
    normal! j
  endwhile
  normal! O);
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
