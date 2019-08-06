setlocal noexpandtab tabstop=4 shiftwidth=4
set nofoldenable
set foldmethod=syntax
set foldlevel=1
set foldnestmax=1

let b:ale_linters = ['gofmt', 'govet', 'gobuild', 'gotype']
let b:ale_linters = ['gobuild', 'revive']
let b:ale_linters = ['gobuild', 'revive', 'golangci-lint']
let g:ale_go_golangci_lint_package=0

let g:revive_config_file = '.revive.toml'
if !filereadable('.revive.toml')
  let g:revive_config_file = '~/.revive.toml'
endif
call ale#linter#Define('go', {
\   'name': 'revive',
\   'output_stream': 'both',
\   'executable': 'revive',
\   'read_buffer': 0,
\   'command': 'revive -config '.g:revive_config_file.' %t',
\   'callback': 'ale#handlers#unix#HandleAsWarning',
\})

let g:ale_set_quickfix=0

let g:go_addtags_transform='camelcase'
let g:go_bin_path = expand('~/code/go/bin')
let g:go_code_completion_enabled = 0
let g:go_disable_autoinstall = 0
let g:go_fmt_autosave = 0
let g:go_gocode_unimported_packages=0
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_list_type = 'quickfix'
let g:go_metalinter_autosave = 0
let g:go_term_enabled=0
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled=0

let g:go_highlight_debug = 0
hi GoDebugBreakpoint term=standout ctermbg=117 ctermfg=0 guibg=#BAD4F5  guifg=Black
hi GoDebugCurrent term=reverse ctermbg=7 ctermfg=0 guibg=DarkBlue guifg=White

" load oldsql bindings
if !filereadable('go.mod')
    nmap <buffer> <silent> gd :GoDef<cr>
    nmap <buffer> <silent> gD :GoDefType<cr>
    nmap <buffer> <silent> gi :GoImplements<cr>
    nmap <buffer> <silent> gr :GoReferrers<cr>
    nmap <buffer> <leader>gr :GoRename
    nmap <buffer> K :GoInfo<cr>
    noremap <buffer> <leader>u :exec "GoImport ".expand("<cword>")<cr>
endif

vnoremap <buffer> <leader>em :Refactor extract
vnoremap <buffer> <leader>ev :call GoExtractVariable()<cr>
nnoremap <buffer> <leader>gm :call GoMoveDirV2()<cr>
noremap <buffer> <leader>h :Refactor godoc<cr>
nnoremap <buffer> <leader>ga :GoAddTags<cr>
noremap <buffer> <leader>m :GoDoc<cr>
nnoremap <buffer> <leader>gd :GoDescribe<cr>
noremap <buffer> <leader>u :exec "GoImport ".expand("<cword>")<cr>
inoremap <silent><buffer> . <esc>:call AliasGoImport()<cr>
nnoremap <buffer> <leader>ie :GoIfErr<cr>
inoremap <buffer> <c-e> <c-o>:GoIfErr<cr>

" nnoremap <buffer> <leader>d :GoDeclsDir<cr>
nnoremap <buffer> <silent> <m-a> :GoAlternate!<cr>
nnoremap <buffer> <m-c> :GoCoverageToggle<cr>

nnoremap <buffer> <leader>tt :GoTest!<cr>
nnoremap <buffer> <leader>gt :GoTests<cr>
nnoremap <buffer> <leader>gf :GoFillStruct<cr>

nnoremap <buffer> <c-s> :GoFmt<cr>

nnoremap <buffer> <f5> :GoDebugStart<cr>
nnoremap <buffer> <f6> :GoDebugTest<cr>
nnoremap <buffer> <f7> :GoDebugStop<cr>

nnoremap <buffer> <leader>e :exe "GoDebugPrint ".expand('<cword>')<cr>
nnoremap <buffer> <f9> :GoDebugBreakpoint<cr>
nnoremap <buffer> <f10> :GoDebugNext<cr>
nnoremap <buffer> <f11> :GoDebugStep<cr>
nnoremap <buffer> <f12> :GoDebugStepOut<cr>

nnoremap <buffer> <m-,> A,<esc>


" run :GoBuild or :GoTestCompile based on the go file
nnoremap <buffer> <m-b> :<C-u>call <SID>build_go_files()<CR>
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
  let l:name = input('Name of new variable: ')
  normal! gvx
  execute 'normal! i '.l:name
  execute 'normal! O'.l:name.' := '
  normal! p
  normal! bgr
endfunction

let g:go_debug_windows = {
      \ 'stack':   'botright 10new',
      \ 'vars':  'leftabove 90vnew',
\ }

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

let g:go_fmt_options = {
  \ 'gofmt': '-s',
  \ }

let g:go_def_mode = 'godef'
" let g:go_def_mode = 'guru'

nnoremap <buffer> <leader>il :Iface<cr>
nnoremap <buffer> <leader>is :GoImpl<cr>

" function! ImplementInterface()
"     if !filereadable('go.mod')
"         echo 'no go.mod found in cwd'
"         return
"     endif
"     let l:cword = substitute(substitute(expand('<cword>'), 'Stub', '', ''), 'Mock', '', '')

"     let l:currentBasePackage = substitute(substitute(system('head -n 1 go.mod'), 'module ', '', ''), '\n\+$', '', '')
"     let l:interface = input('interface: ', l:currentBasePackage.''.substitute(expand('%:p:h'), getcwd(), '', '').'.'.l:cword)
"     let l:receiver = expand('<cword>')
"     let l:firstLetter = tolower(strpart(l:receiver, 0, 1))

"     exe ':GoImpl '.l:firstLetter.' *'.l:receiver.' '.l:interface
" endfunction
" nnoremap <buffer> <leader>il :call ImplementInterface()<cr>
" nnoremap <buffer> <leader>is :GoImpl<cr>

" " non-gomod projects
" " dependency: go get golang.org/x/tools/cmd/gomvpkg
" function! GoMoveDir()
"   :update

"   " find current gopath
"   let l:gopath = ''
"   for gopath in split($GOPATH, ':')
"     if expand('%:p:h') =~ '^'.gopath
"       let l:gopath = gopath
"     endif
"   endfor

"     let l:currentFile = expand('%:p')
"     let l:oldPath = input('Old path: ', substitute(expand('%:p:h'), gopath.'/src/', '', ''))
"     let l:newPath = input('New path ==> ', l:oldPath)

"   if len(l:gopath) == 0
"     " echo 'Cannot move pkg - not in configured gopath?!'
"     " return
"   endif


"   execute '!gomvpkg -from '.l:oldPath.' -to '.l:newPath

"   if !filereadable(l:currentFile)
"     :bd
"   endif
" endfunction

" " non-gomod projects
" " dependency: go get golang.org/x/tools/cmd/gomvpkg
" function! GoMoveFile()
"   :update

"   " find current gopath
"   let l:gopath = ''
"   for gopath in split($GOPATH, ':')
"     if expand('%:p:h') =~ '^'.gopath
"       let l:gopath = gopath
"     endif
"   endfor

"   if len(l:gopath) == 0
"     echo 'Cannot move pkg - not in configured gopath?!'
"     return
"   endif

"   let l:currentFile = expand('%:p')
"   let l:oldPath = input('Old path: ', substitute(expand('%:p:h'), gopath.'/src/', '', ''))
"   let l:newPath = input('New path ==> ', l:oldPath)

"   execute '!gomvpkg -from '.l:oldPath.' -to '.l:newPath

"   if !filereadable(l:currentFile)
"     :bd
"   endif
" endfunction

" " dependency: go get -u github.com/ksubedi/gomove
" function! GoMoveDirV2()
"   :update

"   if !filereadable('go.mod')
"       echo 'no go.mod found in cwd - not moving anything'
"       return
"   endif

"   let l:currentBasePackage = substitute(substitute(system('head -n 1 go.mod'), 'module ', '', ''), '\n\+$', '', '')
"   let l:currentFile = expand('%:p')
"   let l:oldPath = substitute(expand('%:p:h'), getcwd(), '', '')
"   let l:oldPackage = input('Old package: ', l:currentBasePackage.''.l:oldPath)
"   let l:newPackage = input('New package ==> ', l:oldPackage)
"   let l:oldPath = getcwd().'/'.substitute(l:oldPackage, l:currentBasePackage, '', '')
"   let l:newPath = getcwd().'/'.substitute(l:newPackage, l:currentBasePackage, '', '')
"   if l:oldPackage =~# '/$'
"       let l:oldPackage = strpart(l:oldPackage, 0, len(l:oldPackage) -1)
"   endif
"   if l:newPackage =~# '/$'
"       let l:newPackage = strpart(l:newPackage, 0, len(l:newPackage) -1)
"   endif

"   if empty(glob(l:newPath))
"       exe '!mkdir -p '.l:newPath
"   endif

"   exe '!mv '.l:oldPath.'/* '.l:newPath
"   exe '!gomove '.l:oldPackage.' '.l:newPackage

"   if !filereadable(l:currentFile)
"     :bd
"   endif
" endfunction

" function! AliasGoImport()
"     let l:skip = !has_key(v:completed_item, 'word') || v:completed_item['kind'] !=# 'M'

"     if !l:skip
"         let l:currentPackage = v:completed_item['word']
"         let l:importPath = substitute(substitute(v:completed_item['menu'], ' \[LS\]', '', ''), '"', '', 'g')
"     endif

"     if !l:skip
"         " check if selected package is already imported
"         let [s:line, s:col] = searchpos('"'.l:importPath.'"', 'n')
"         let l:skip = s:line
"     endif

"     if !l:skip
"         " check if different package with same name is already imported
"         let [s:line, s:col] = searchpos('\s\+".\+/'.l:currentPackage.'"$', 'n')
"         if s:line > 0
"             let l:alias = input('Package already imported. Alias '.l:importPath.' as: ')
"             if l:alias ==# ''
"                 echo 'No alias given - not doing anything'
"             else
"                 let l:cmd = 'GoImportAs ' . l:alias . ' ' . l:importPath
"                 execute l:cmd
"                 execute 'normal! ciw'.l:alias
"             endif

"             let l:skip = 1
"         endif
"     endif

"     if !l:skip
"         let l:cmd = 'GoImport ' . l:importPath
"         execute l:cmd
"     endif

"     normal! a.
"     if col('.') == col('$') - 1
"         startinsert!
"     else
"         normal! l
"         startinsert
"     end
" endfunction

" " vnoremap <m-e> :'<,'>d<cr>:call GoExtractFunc()<cr>
" " function! GoExtractFunc()
" "   let l:newName = input('New function name: ')
" "   execute 'normal! i'.l:newName."()\r"
" "   normal! ml==

" "   ?func
" "   normal! $%o
" "   execute 'normal! ofunc '.l:newName.'() {'
" "   normal! p
" "   normal! }ko}
" "   normal! 'l
" " endfunction
