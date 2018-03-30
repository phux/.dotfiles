set noexpandtab tabstop=4 shiftwidth=4 

nnoremap <m-c> :GoCoverageToggle<cr>
nnoremap <leader>h :call GoComment()<cr>
nnoremap <silent> <m-a> :GoAlternate!<cr>
" run :GoBuild or :GoTestCompile based on the go file
nnoremap <m-b> :<C-u>call <SID>build_go_files()<CR>
nnoremap <m-t> :GoTest!<cr>
nnoremap <m-f> :GoTest!<cr>
nnoremap <leader>gi :GoImplements<cr>
nnoremap <leader>gr :GoRename <c-r><c-w>
nnoremap gr :GoReferrers<cr>
nnoremap <buffer> <leader>w :w<cr>
vnoremap <leader>em :Refactor extract 
vnoremap <leader>ev :call GoExtractVariable()<cr>
nnoremap <m-m> :GoMetaLinter<cr>

let g:cm_auto_popup=1

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Inserts comment boilerplate
function! GoComment()
  let l:currentLine = getline(".")
  if l:currentLine =~ "^type "
    normal! 0wywO// 
    normal! pa.
  endif
  if l:currentLine =~ "^func "
    normal! 0w
    if l:currentLine =~ "^func \("
      normal! %w
    endif
    normal! ywO// 
    normal! pa .
  endif
  startinsert
endfunction


" visually mark the code you want to extract into variable
" (for now only works with single line selection)
function! GoExtractVariable()
  let l:name = input("Name of new variable: ")
  normal! gvx
  execute "normal! i ".l:name
  execute "normal! O".l:name." := "
  normal! p
  normal! bgr
endfunction

let g:pdv_cfg_InsertFuncName = 0
let g:pdv_cfg_InsertVarName = 0

" https://github.com/AJenbo/php-refactoring-browser
let g:php_refactor_command='php ~/compiles/php-refactoring-browser/refactor.phar'

let g:go_list_type = "locationlist"
let g:go_bin_path = expand("~/.gvm/gos/go1.10/bin")
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_metalinter_autosave = 0
let g:go_metalinter_deadline = '10s'
let g:go_metalinter_enabled = ["deadcode", "unconvert", "gocyclo", "maligned", "dupl", "ineffassign", "goconst", "megacheck", "interfacer", "vet", "varcheck", "structcheck"]
" let g:go_metalinter_enabled = ["unconvert", "gocyclo", "maligned", "ineffassign", "goconst"]

let g:go_term_enabled=0
let g:go_disable_autoinstall = 0

let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

let g:neomake_go_gometalinter_maker = {
  \ 'args': [
  \   '--enable-all',
  \   '--tests',
  \   '--disable=lll',
  \   '--disable=dupl',
  \   '--concurrency=8',
  \   '--fast',
  \   '%:p:h',
  \ ],
  \ 'cwd': '%:h',
  \ 'append_file': 0,
  \ 'errorformat':
  \   '%E%f:%l:%c:%trror: %m,' .
  \   '%W%f:%l:%c:%tarning: %m,' .
  \   '%E%f:%l::%trror: %m,' .
  \   '%W%f:%l::%tarning: %m'
\ }
let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
