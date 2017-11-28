if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd!
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-commentary', {'on': 'Commentary'}

Plug 'ap/vim-buftabline'
let g:buftabline_show = 1 " display only if more than 1 buffer open

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'jiangmiao/auto-pairs'

Plug 'amiorin/vim-project'

Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'
Plug 'gregsexton/gitv'

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'

Plug 'Lokaltog/vim-easymotion'
Plug 'matze/vim-move'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

Plug 'morhetz/gruvbox'


Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'neomake/neomake'

Plug 'padawan-php/deoplete-padawan', {'for': 'php'}

let g:pdv_cfg_InsertFuncName = 0
let g:pdv_cfg_InsertVarName = 0
Plug 'phux/php-doc-modded', {'for': 'php'}
Plug '~/code/vim-php', {'for': ['php', 'yaml']}
Plug 'StanAngeloff/php.vim', {'for': 'php'}

Plug 'alvan/vim-php-manual', {'for': 'php'}
Plug 'nrocco/vim-phplint', {'for': 'php'}

Plug 'vim-php/vim-php-refactoring', {'for': 'php'}
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
" https://github.com/AJenbo/php-refactoring-browser
let g:php_refactor_command='php ~/compiles/php-refactoring-browser/refactor.phar'

Plug 'phpactor/phpactor', {'for': 'php', 'do': ':call phpactor#Update()' }

Plug 'janko-m/vim-test'

Plug 'fatih/vim-go', {'for': 'go'}
Plug 'godoctor/godoctor.vim', {'for': 'go'}
Plug 'buoto/gotests-vim', {'for': 'go'}
Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go'}
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' , 'for': 'go'}


Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_mru_relative = 1
Plug 'pbogut/fzf-mru.vim'

Plug 'Shougo/echodoc.vim', {'for': ['go', 'php']}

Plug 'henrik/vim-indexed-search'
Plug 'romainl/vim-cool'
Plug 'wincent/ferret', {'on': 'Ack'}
let g:FerretHlsearch=1

Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }

Plug 'simeji/winresizer'
Plug 'wellle/targets.vim'

" Plug 'milkypostman/vim-togglelist'
Plug 'romainl/vim-qf'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'godlygeek/tabular', {'for': 'cucumber'}
call plug#end()

let mapleader = "\<Space>"
nnoremap <silent> <leader><f5> :e $MYVIMRC<CR>
inoremap jk <esc>

" interface
set t_Co=256
set background=dark
colorscheme deus

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set statusline=
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=%10(%l:%c%)\ 
set statusline+=\ 

set number
" Set the command window height to 1 lines
set cmdheight=1
" This makes more sense than the default of 1
set winminheight=1

set formatoptions=qrn1tcl
set formatoptions-=o                  " do not continue comment using o or O
" "show this in front of broken lines
set showbreak=↪
" Line wrapping
set wrap
" " but don't split words
set lbr

augroup everything
    au!
    au BufWritePost $MYVIMRC nested source $MYVIMRC

    au filetype yaml setl sw=2 sts=2 et
    au BufNewFile,BufRead *.yml.dist set ft=yaml
    au filetype ruby setl sw=2 sts=2 et

    au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
    au filetype make setlocal noexpandtab tabstop=4 shiftwidth=4 
    au filetype javascript setlocal noexpandtab tabstop=2 shiftwidth=2 
    au filetype typescript setlocal noexpandtab tabstop=2 shiftwidth=2 

    au BufRead,BufNewFile *.conf setf config

    au BufNewFile,BufRead *.phtml set ft=php.html
    au BufNewFile,BufRead composer.lock set ft=json
    au filetype html,xml inoremap <buffer> <m-;> </<c-x><c-o>

    au filetype css setlocal omnifunc=csscomplete#CompleteCSS

    au FileType php setlocal omnifunc=phpactor#Complete
    au filetype html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    au filetype javascript setlocal omnifunc=tern#Complete
    au filetype xml setlocal omnifunc=xmlcomplete#CompleteTags
    au filetype xml   setlocal makeprg=xmllint\ -
    au filetype json  setlocal equalprg=python\ -mjson.tool


    au filetype php LanguageClientStart

    " no delay when ESC/jk
    au InsertEnter * set timeoutlen=100
    au InsertLeave * set timeoutlen=1000

    au FocusLost * silent! update
    autocmd BufWritePost *.php silent Phplint
    autocmd BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &


    au filetype go nnoremap <leader>gf :GoCoverageToggle<cr>
    au filetype go nnoremap <leader>gr <Plug>(go-run)
    au filetype go nnoremap <leader>gb <Plug>(go-build)
    au filetype go nnoremap <leader>gt <Plug>(go-test)
    au filetype go nnoremap <leader>gd <Plug>(go-doc)
    au filetype go nnoremap <leader>gs <Plug>(go-implements)
    au filetype go nnoremap <leader>ge <Plug>(go-rename)
    au BufNewFile,BufRead,BufWinEnter *.go nnoremap <buffer> <leader>w :GoFmt<cr>

    autocmd filetype gitcommit nnoremap <buffer> <leader>w :call PrependTicketNumber()<cr>

    au BufNewFile,BufRead,BufWinEnter *Test.php exe ":UltiSnipsAddFiletypes php.phpunit"
    au BufNewFile,BufRead,BufWinEnter *Spec.php exe ":UltiSnipsAddFiletypes php.php-phpspec"
augroup END

nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>N :NERDTreeFind<cr>

let g:LanguageClient_diagnosticsEnable  = 0
let g:LanguageClient_signColumnAlwaysOn = 0
let g:LanguageClient_selectionUI = 'fzf'

nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
nnoremap K :call LanguageClient_textDocument_hover()<cr>
let g:LanguageClient_serverCommands = {
            \ 'javascript.jsx': ['~/compiles/javascript-typescript-langserver/lib/language-server-stdio.js'],
            \ 'php': ['php', '~/code/php-language-server/bin/php-language-server.php']
            \ }

set encoding=utf-8
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set hidden

" no backups {{{2
set nobackup
set nowritebackup
set noswapfile
" }}}

" move over lines with following keys
set whichwrap+=<,>,[,],h,l



" Copy Paste {{{

" Copy to Clipboard (on Unix)
set clipboard+=unnamed
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
vnoremap <leader>d "+d
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]



set ignorecase
set smartcase
set hlsearch
set incsearch


let g:PHP_removeCRwhenUnix = 1
set timeout ttimeoutlen=0


nnoremap <silent> <leader>w :w<cr>
command! -bang PadawanGenerate call deoplete#sources#padawan#Generate(<bang>0)
nnoremap <silent> <leader>W :w<cr>:silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &<cr>:PadawanGenerate!<cr>:call deoplete#sources#padawan#RestartServer()<cr>


set scrolloff=5

let g:ultisnips_php_scalar_types = 1
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips/'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"


let g:echodoc_enable_at_startup=1
set noshowmode

let g:fzf_layout = { 'down': '~40%' }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'


vnoremap // "hy:exec "Ag ".escape('<C-R>h', "/\.*$^~[()")<cr>


nnoremap <leader><Enter> :FZFMru<cr>
nnoremap <leader>s :Rg<space>
nnoremap <leader>S :exec "Rg ".expand("<cword>")<cr>


nnoremap <leader><tab> :Buffers<cr>
nnoremap <leader>, :Files<cr>
nnoremap <leader>d :BTags<cr>
nnoremap <leader>D :BTags <C-R><C-W><cr>
nnoremap <leader>T :Tags<cr>


let g:project_use_nerdtree = 0
let g:project_enable_welcome = 0
nnoremap <F1> :e ~/.projects.public.vim<cr>
nnoremap <leader><F2> :e ~/.projects.private.vim<cr>

set rtp+=~/.config/nvim/plugged/vim-project/
call project#rc("~/code")


nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gl :Extradite!<cr>


let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"
let g:vim_php_refactoring_use_default_mapping = 0


nnoremap <leader>rrp :call PhpRenameClassVariable()<CR>
nnoremap <leader>rrm :call PhpRenameMethod()<CR>
nnoremap <leader>reu :call PhpExtractUse()<CR>
vnoremap <leader>rec :call PhpExtractConst()<CR>


nnoremap <leader>rep :call PhpRefactorLocalVariableToInstanceVariable()<cr>
vnoremap <leader>rem :call PhpRefactorExtractMethodDirectly()<CR>
nnoremap <leader>rrv :call PhpRefactorRenameLocalVariable()<cr>


nnoremap <leader>rdo :call PhpDocOneliner()<cr>
vnoremap <leader>rev :call PHPExtractVariable()<cr>
nnoremap <leader>H :call PhpConstructorArgumentMagic2()<cr>
nnoremap <leader>rmc :call PHPMoveClass()<cr>
nnoremap <leader>rmd :call PHPMoveDir()<cr>
nnoremap <leader>rcc :call PhpConstructorArgumentMagic()<cr>
nnoremap <leader>ric :call PHPModify("implement_contracts")<cr>
nnoremap <leader>rap :call PHPModify("add_missing_properties")<cr>
nnoremap <leader>rei :call PHPExtractInterface()<cr>

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
function! PHPMoveClass()
    :w
    let l:oldPath = expand('%')
    let l:newPath = input("New path: ", l:oldPath)
    execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
    execute "bd ".l:oldPath
    execute "e ". l:newPath
endfunction

function! PHPMoveDir()
    :w
    let l:oldPath = input("old path: ", expand('%:p:h'))
    let l:newPath = input("New path: ", l:oldPath)
    execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
endfunction

function! PHPModify(transformer)
    :w
    normal! ggdG
    execute "read !".g:phpactor_executable." class:transform ".expand('%').' --transform='.a:transformer
    normal! ggdd
    :w
endfunction

function! PHPExtractInterface()
    :w
    let l:interfaceFile = substitute(expand('%'), '.php', 'Interface.php', '')
    execute "!".g:phpactor_executable." class:inflect ".expand('%').' '.l:interfaceFile.' interface'
    execute "e ". l:interfaceFile
endfunction

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

nnoremap <Leader>u :PHPImportClass<cr>
nnoremap <Leader>e :PHPExpandFQCNAbsolute<cr>
nnoremap <Leader>E :PHPExpandFQCN<cr>

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#sources#padawan#add_parentheses=1
let g:deoplete#skip_chars = ['$']

inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


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
inoremap <C-d> <ESC>:call PhpDocSingle()<CR>
nnoremap <leader>h :call UpdatePhpDocIfExists()<CR>
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


let g:go_list_type = "location"


let g:go_bin_path = expand("~/.gvm/gos/go1.8.3/bin")
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 0


nnoremap <leader>/ :Ack <c-r><c-w><cr>
nnoremap <leader>rip :Acks /<c-r><c-w>/<c-r><c-w>/gc<left><left><left>

nmap <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
nmap  <Leader>F <Plug>(easymotion-bd-w)
nmap <Leader>F <Plug>(easymotion-overwin-w)
nmap <Leader>f <Plug>(easymotion-w)
nmap  <Leader>b <Plug>(easymotion-b)
let g:EasyMotion_smartcase = 1

nnoremap <leader>c :Commentary<cr>
vnoremap <leader>c :Commentary<cr>

nnoremap <leader>] :%S/<c-R><c-w>/<c-r><c-w>/g<left><left>
vnoremap <leader>] :%S//g<left><left>

so ~/.projects.public.vim
filetype plugin indent on
syntax on

let g:padawan_navigator#server_command='~/code/padawan.php/bin/padawan-server'
let g:padawan_navigator#server_addr='http://127.0.0.1:15155'
let g:deoplete#sources#padawan#server_command='~/code/padawan.php/bin/padawan-server'

function! ParamDeclarationToPhakeMock()
    :s/\(\w\+\) \(\$\w\+\),*/\2 = Phake::mock(\1::class);
endfunction
nnoremap <m-m> :call ParamDeclarationToPhakeMock()<cr>j

set tabstop=4
set shiftwidth=4
set shiftround
set expandtab
set autoindent                        " indent when creating newline

let g:deoplete#sources = get(g:, 'deoplete#sources', {})
let g:deoplete#sources._ = ['ultisnips', 'buffer']
let g:deoplete#sources.php = ['padawan', 'ultisnips', 'buffer']

let g:deoplete#sources.go = ['go', 'ultisnips', 'buffer']
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#pointer = 1
let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/$GOOS_$GOARCH'


inoremap <c-l> <del>

" keep selection after indent
vnoremap < <gv
vnoremap > >gv
" Map tab to indent in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

nnoremap <tab> :bn<cr>
nnoremap <s-tab> :bp<cr>

nnoremap <leader>tn :TestNearest<cr>

set completeopt=menuone,longest
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE


nnoremap <c-p> :cp<cr>
nnoremap <c-n> :cn<cr>
let g:qf_loc_toggle_binds = 1
function! ToggleQfLocListBinds()
    if g:qf_loc_toggle_binds == 1
        nmap <c-p> :lpre<cr>
        nmap <c-n> :lnext<cr>
        let g:qf_loc_toggle_binds = 0
        echo "loc binds loaded"
    else
        let g:qf_loc_toggle_binds = 1
        nmap <c-p> :cpre<cr>
        nmap <c-n> :cne<cr>
        echo "qf binds loaded"
    endif
endfunction
nmap <Down> :call ToggleQfLocListBinds()<cr>

nnoremap <leader>a :Ag<space>
nnoremap <leader>A :exec "Ag ".expand("<cword>")<cr>

nnoremap <leader>x <c-w>c

function! PrependTicketNumber()
    normal gg
    let l:branch = system("echo $(git branch | grep '*')")
    let l:branchName = substitute(l:branch, '\* \(.*\)', '\1', '')
    let l:ticketNumber = substitute(l:branchName, '\(\w\+-\d\+\).*', '\1', '')
    exe "normal i[".l:ticketNumber."] "
    normal! kJx
    :startinsert!
endfunction

" Move by screen line not file line
nnoremap j gj
nnoremap k gk


nnoremap <leader>gv :Gitv!<cr>
vnoremap <leader>gv :Gitv!<cr>
nnoremap <leader>gV :Gitv<cr>
augroup gitv
    au!
    autocmd Filetype gitv nmap <buffer> <silent> <C-n> <Plug>(gitv-previous-commit)
    autocmd Filetype gitv nmap <buffer> <silent> <C-p> <Plug>(gitv-next-commit)
augroup END

let g:Gitv_DoNotMapCtrlKey = 1

let g:php_manual_online_search_shortcut = '<leader>m'

nnoremap <leader>; :TagbarToggle<cr>

" SymfonySwitchToAlternateFile {{{

nnoremap <leader>ta :call SymfonySwitchToAlternateFile()<cr>
nnoremap <leader>tsa <c-w>v:call SymfonySwitchToAlternateFile()<cr>

" changes to test/sut files
" following structure:
" sut: <dir1>/<dir2>/<dir3>/<dir4>/.../<file>.php
" test: <dir1>/<dir2>/<dir3>/Tests/<dir4>/.../<file>Test.php
"
" example:
" sut:  src/Acme/Bundle/Service/MyService.php
" test: src/Acme/Bundle/Tests/Service/MyServiceTest.php

let g:switch_alternate_dirs_to_keep = 2
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
" }}}

" switch between files {{{
" Parameters:
"
" fileExtension: the file extension this script should act on, i.e. 'php'
" (without dot)
"
" firstDirBeginning: a file path that identifies the first type
" of paths, i.e. 'tests/unit/'
"
" secondDirBeginning: a file path pattern that identifies the second type
" of paths, i.e. 'src/'
"
" filenameAddition: string that should be removed from the first filename and
" added to the second, i.e. 'Test' if your testfile filename has the suffix
" 'Test' as in /path/MyServiceTest.php

function! SwitchBetweenFiles(fileExtension, firstDirBeginning, secondDirBeginning, filenameAddition)
    let f = bufname("%")
    if f =~ '.'.a:fileExtension
        if f =~ '\<'.a:firstDirBeginning && f =~ a:filenameAddition.'\.'.a:fileExtension
            let filename = substitute(substitute(f, a:firstDirBeginning, '', ''), a:filenameAddition, '', '')
            if !filereadable(filename)
                let new_dir = substitute(filename, '/\w\+\.'.a:fileExtension, '', '')
                exe ":!mkdir -p ".new_dir
            endif
            exe ":e ".filename
        elseif f =~ '\<'.a:secondDirBeginning && f !~ a:filenameAddition.'\.'.a:fileExtension
            let filename = substitute(substitute(f, a:secondDirBeginning, a:firstDirBeginning.a:secondDirBeginning, ''), '.'.a:fileExtension, a:filenameAddition.'.'.a:fileExtension, '')
            if !filereadable(filename)
                let new_dir = substitute(filename, '/\w\+'.a:filenameAddition.'\.'.a:fileExtension, '', '')
                exe ":!mkdir -p ".new_dir
            endif
            exe ":e ".filename
        else
            echom "Could not switch because needed patterns not matched."
        endif
    endif
endfunction
"}}}

command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

" remove buffer without deleting window
nnoremap <silent> <m-d> :bp<bar>sp<bar>bn<bar>bd<CR>

command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
let g:ackprg = 'rg --vimgrep --no-heading'

set wildmenu
set wildmode=list:longest,full


" FormatPHPLineLength {{{
function! FormatPHPLineLength()
    let l:currentLine = getline('.')
    normal! ma

    let l:isConditional = l:currentLine =~ '\s*&&' || l:currentLine =~ ' and ' || l:currentLine =~ '\s*||' || l:currentLine =~ ' or ' || l:currentLine =~ '\s*?.*:'
    if l:isConditional
        :s/\(\s*&&\| and \|\s*||\| or \| ?\| :\)/\r\1/g
        if getline('.') =~ ') {'
            exe "normal! $hhi\n"
        endif
        normal! =ap
        return
    endif

    " " multiple object operator split - repeatable
    let l:numOfObjectOperators = len(split(l:currentLine, '->', 1)) - 1
    if l:numOfObjectOperators > 0
        try
            s/)->/)\r->/g
        catch
        endtry
        normal! ='a
    endif


    " split params
    let l:isFunctionCall = len(split(l:currentLine, '(.\+)', 1)) - 1
    if l:isFunctionCall > 0
        try
            s#(\([^)]\+\)\()\)#(\r\1\r\2#
            normal! k
            if getline('.') =~ ',\s'
                s/,\s/,\r/g
            endif
            normal! j
            if getline('.') =~ '))'
                exe "normal! kJa\n"
            endif
            normal! =a(
        catch
        endtry
    endif


    " format array
    let l:isArray = len(split(l:currentLine, '.\+\zs\[.\+\]', 1)) - 1
    if l:isArray > 0
        try
            s/\(\[\)\(.\+\)\(]\)/\1\r\2\r\3

            normal! k

            if l:currentLine =~ ',\s'
                s/,\s/,\r/g
            endif

            if getline('.') !~ ',$'
                normal! A,
            endif

            normal! =a[
        catch
        endtry
    endif
endfunction

nnoremap <m-f> :call FormatPHPLineLength()<cr>

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction

nnoremap <leader>ga :Tabularize /\|<cr>
vnoremap <leader>ga :Tabularize /\|<cr>
