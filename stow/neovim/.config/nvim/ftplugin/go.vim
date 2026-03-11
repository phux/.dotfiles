" setlocal noexpandtab tabstop=4 shiftwidth=4
" setlocal nofoldenable
" setlocal foldmethod=syntax
setlocal foldlevel=0
setlocal foldnestmax=0
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2



" vnoremap <buffer> <leader>rev :call GoExtractVariable()<cr>
nnoremap <buffer> <leader>rm :call GoMove()<cr>
noremap <buffer> <leader>rd :Refactor godoc<cr>
nnoremap <silent> <Leader>oj <Cmd>lua require('gomodifytags').GoAddTags("json")<CR>
nnoremap <silent> <Leader>oJ <Cmd>lua require('gomodifytags').GoRemoveTags("json")<CR>

nnoremap <buffer> <leader>oe :IfErr<cr>

" nnoremap <buffer> <leader>oc :GoCoverageToggle<cr>
" nnoremap <buffer> <leader>oc :GoCoverage toggle<cr>
nnoremap <buffer> <leader>oc :CoverageToggle<cr>
nnoremap <buffer> <leader>OC :CoverageSummary<cr>

" nnoremap <buffer> <leader>om :Mockery<cr>
command! Mockery execute 'normal! O//go:generate mockery --name '.expand('<cword>').' --structname '.expand('<cword>').' --output=internal/mocks'


" nnoremap <buffer> <leader>ds :DlvDebug<cr>
" nnoremap <buffer> <leader>dt :DlvTest<cr>
" nnoremap <buffer> <leader>db :DlvToggleBreakpoint<cr>

nnoremap <buffer> <silent> <leader>ef :call ExtractToFile()<cr>


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


let g:go_fmt_options = {
  \ 'gofmt': '-s',
  \ }

let g:go_def_mode = 'godef'
" let g:go_def_mode = 'guru'


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

" Deprecated by GoMove()
"dependency: go get -u github.com/ksubedi/gomove
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

function! GoMoveCmd()
    call feedkeys(":call GoMove")
endfunction

" dependency: go get -u github.com/rsc/rf
" move a single file or a complete directory
function! GoMove()
  let l:go_mod_path = 'go.mod'
  if !filereadable(l:go_mod_path)
      " echom 'no go.mod found'
      return
  endif

  :update

  let l:selection = input('what to move (1 = file, 2 = dir): ')

  let l:source = []
  if l:selection == 1
      let l:source = [expand('%:f')]
  elseif l:selection == 2
      let l:oldDir = input('old dir: ', substitute(expand('%:p:h'), getcwd(), '', ''))
      let l:source = split(globpath(getcwd().l:oldDir, '*'), '\n')
  endif

  let l:newPackage = input('new package: ', substitute(expand('%:p:h'), getcwd(), '', ''))
  let l:currentBasePackage = substitute(substitute(system('head -n 1 '.l:go_mod_path), 'module ', '', ''), '\n\+$', '', '')

  if l:newPackage =~# '/$'
      let l:newPackage = strpart(l:newPackage, 0, len(l:newPackage) -1)
  endif

  for file in l:source
      exe ':!rf "mv '.file.' '.l:currentBasePackage.l:newPackage.'"'
  endfor

  if l:selection == 1 && !filereadable(l:source[0])
      :bd
  elseif len(globpath(getcwd().l:oldDir, '*')) == 0
      exe ':!rm -r ' .getcwd().l:oldDir
  endif


endfunction

nnoremap <buffer> <leader>il :Iface<cr>
nnoremap <buffer> <leader>is :GoImpl

" dependency: go get -u github.com/josharian/impl
" dependency: https://github.com/rhysd/vim-go-impl
function! s:iface_sink(line)
    let l:go_mod_path = 'go.mod'
    if !filereadable(l:go_mod_path)
        echom 'no go.mod found'
        return
    endif
    let parts = split(a:line, '\t\zs')
    let l:path = parts[1][:-2]
    if l:path =~# '^\.\.\/'
        let l:path = substitute(l:path, '../[^/]\+/', '/', '')
    endif
    let l:path = substitute(l:path, '/\w\+.go$', '.', '')
    let l:interface = parts[0]

    let l:currentBasePackage = substitute(substitute(system('head -n 1 '.l:go_mod_path), 'module ', '', ''), '\n\+$', '', '')
    let l:previous_cwd = getcwd()
    let l:interface = l:currentBasePackage.l:path.l:interface
    let l:receiver = expand('<cword>')
    let l:firstLetter = tolower(strpart(l:receiver, 0, 1))

    normal! %j
    let l:cmd = ':GoImpl '.l:firstLetter.' *'.l:receiver.' '.l:interface
    echom l:cmd
    execute l:cmd
    execute ':cd '.l:previous_cwd
endfunction

function! s:iface()
    call fzf#run({
                \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
                \            '| grep -v -a ^! | grep "interface "',
                \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
                \ 'down':    '40%',
                \ 'sink':    function('s:iface_sink')})
endfunction

command! Iface call s:iface()




function! s:IfErr()
    let bpos = wordcount()['cursor_bytes']
    let out = systemlist('iferr -pos ' . bpos, bufnr('%'))
    if len(out) == 1
        return
    endif
    let pos = getcurpos()
    call append(pos[1], out)
    silent normal! j=2j
    call setpos('.', pos)
    silent normal! 4j
endfunction

command! -buffer -nargs=0 IfErr call s:IfErr()

" dependency: go install rsc.io/rf@latest


" extract type ... or  methods to file
"
" cursor on the line `type <Foo> struct` will result in <foo>.go, containing the
" struct and all its methods.
" cursor on the line `func (f <Foo>) Method()...` will result in just this
" method moved to <foo>.go.
function! ExtractToFile()
    let l:line = getline('.')
    let l:thingtomove = ''
    if l:line =~# '^func ('
        let l:receiver = matchstr(l:line, 'func (\w\+ \**\zs\w\+\ze')
        let l:func = matchstr(l:line, 'func (\w\+ \**\w\+) \zs\w\+\ze(')
        let l:thingtomove = l:receiver.'.'.l:func
        let l:target = l:receiver
        if len(l:thingtomove) == 0
            echo 'found no method to move'
            return
        endif

        let l:previousCwd = getcwd()
        exe 'cd '.expand('%:p:h')
        exe ":silent !rf 'mv ".l:thingtomove.' '.tolower(l:target).".go'"
        exe 'cd '.l:previousCwd
    elseif l:line =~# '^const'
        let l:const = matchstr(l:line, 'const \zs\w\+\ze')
        let l:thingtomove = l:const
        if len(l:thingtomove) == 0
            echo 'found no const to move'
            return
        endif

        let l:currentPath = substitute(expand('%:p:h'), getcwd(), '', '')
        let l:target = input('Target file: ', l:currentPath)
        let l:newPath = fnamemodify(l:target, ':h')
        if !isdirectory(l:newPath)
             let l:shouldCreate = input('Directory '.l:newPath.' does not exist. Create it? ', 'y')
             if l:shouldCreate != 'y'
                 echo 'Cannot continue - aborting'
                 return
             endif
             call mkdir(l:newPath, 'p')
        endif
        exe ":!rf 'mv ".l:thingtomove.' '.l:target."'"
    elseif l:line =~# '^type '
        let l:thingtomove = matchstr(l:line, 'type \zs\w\+\ze')
        let l:target = l:thingtomove

        exe 'cd '.expand('%:p:h')
        let l:fileName = tolower(l:target).'.go'
        exe ":!rf 'mv ".l:thingtomove.' '.l:fileName."'"

        if search('func (.\+ \**'.l:thingtomove.') \w\+()') > 0
            let l:matches = []
            silent exe '%s/^func (\w\+ \**'.l:thingtomove.')/\=add(l:matches, submatch(0))/gn'
            let i = 1

            echo 'moving '.len(l:matches).' methods'
            while i <= len(l:matches)
                let i += 1
                let l:line = search('func (.\+ \**'.l:thingtomove.') \w\+()')
                if l:line != 0
                    exe 'normal '.l:line.'G'
                    call ExtractToFile()
                endif
            endwhile
        endif
    endif

endfunction
