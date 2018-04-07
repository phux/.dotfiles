setlocal noexpandtab tabstop=4 shiftwidth=4

nnoremap <silent><buffer> <leader>w :lclose<cr>:w<cr>

nnoremap <buffer> <leader>gr :GoRename <c-r><c-w>
vnoremap <buffer> <leader>em :Refactor extract 
vnoremap <buffer> <leader>ev :Refactor var 
noremap <buffer> <leader>: :Refactor toggle<cr> 
noremap <buffer> <leader>h :Refactor godoc<cr>
" nnoremap <buffer> <leader>h :call GoComment()<cr>

nnoremap <buffer> gr :GoReferrers<cr>
nnoremap <buffer> gi :GoImplements<cr>

nnoremap <leader>d :GoDeclsDir<cr>
nnoremap <buffer> <silent> <m-a> :GoAlternate!<cr>
nnoremap <buffer> <m-c> :GoCoverageToggle<cr>
" disable vet as before testing 
nnoremap <buffer> <m-f> :GoTest! -short -vet off<cr>
nnoremap <buffer> <m-m> :GoMetaLinter<cr>
" run :GoBuild or :GoTestCompile based on the go file
nnoremap <buffer> <m-b> :<C-u>call <SID>build_go_files()<CR>

" let g:delve_new_command = 'new'
" let g:delve_backend = "native"
nnoremap <buffer> <f5> :DlvDebug<cr>
nnoremap <buffer> <f6> :DlvTest<cr>
nnoremap <buffer> <f7> :DlvToggleBreakpoint<cr>
nnoremap <buffer> <f8> :DlvToggleTracepoint<cr>


" command! -nargs=* -bang GoDebug call godebug#debug(<bang>0, 0, <f-args>)
" nnoremap <f5> :GoDebug<cr>
" command! -nargs=* -bang GoDebugTestNvim call godebug#debugtest(<bang>0, 0, <f-args>)
" nnoremap <f6> :GoDebugTestNvim<cr>
" command! -nargs=* -bang GoToggleBreakpointNvim call godebug#toggleBreakpoint(expand('%:p'), line('.'), <f-args>)
" nnoremap <f7> :GoToggleBreakpointNvim<cr>


let g:cm_auto_popup=1

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
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

" let g:go_list_type = "locationlist"
let g:go_bin_path = expand("~/.gvm/gos/go1.10.1/bin")
" Enable syntax highlighting per default
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_metalinter_autosave = 0
let g:go_metalinter_deadline = '20s'
let g:go_metalinter_enabled = [ "gas", "goconst", "gocyclo", "golint", "ineffassign", "interfacer", "maligned", "megacheck", "misspell", "structcheck", "unconvert", "varcheck", "vet"]
" let g:go_metalinter_enabled = ["unconvert", "gocyclo", "maligned", "ineffassign", "goconst"]

" let g:go_auto_sameids = 1
" let g:go_auto_type_info = 1

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


let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
  " \ '--enable=gocyclo',

  " \ '--enable=gas',
  " \ '--enable=goconst',
  " \ '--enable=golint',
  " \ '--enable=ineffassign',
  " \ '--enable=interfacer',
  " \ '--enable=maligned',
  " \ '--enable=megacheck',
  " \ '--enable=misspell',
  " \ '--enable=structcheck',
  " \ '--enable=unconvert',
  " \ '--enable=varcheck',
  " \ '--enable=vet',
        " \ '--fast',
        " \ '--enable=megacheck',
  " \ '--disable=deadcode',
  " \ '--disable=dupl',
  " \ '--disable=errcheck',
  " \ '--disable=gocyclo',
  " \ '--disable=goimports',
  " \ '--disable=gotype',
  " \ '--disable=unused',



  " \ '--enable=gas',
  " \ '--enable=goconst',
  " \ '--enable=golint',
  " \ '--enable=ineffassign',
  " \ '--enable=interfacer',
  " \ '--enable=maligned',
  " \ '--enable=megacheck',
  " \ '--enable=misspell',
  " \ '--enable=structcheck',
  " \ '--enable=unconvert',
  " \ '--enable=varcheck',
  " \ '--enable=vet',
  " \ '--exclude=unexported',
let g:neomake_go_gometalinter_maker = {
  \ 'exe': 'zb',
  \ 'args': [
  \   'lint',
  \   '--exclude=unexported',
  \   '--fast',
  \ ],
  \ 'cwd': '%:h',
  \ 'append_file': 0,
  \ 'errorformat':
  \   '%E%f:%l:%c:%trror: %m,' .
  \   '%W%f:%l:%c:%tarning: %m,' .
  \   '%E%f:%l::%trror: %m,' .
  \   '%W%f:%l::%tarning: %m'
\ }
