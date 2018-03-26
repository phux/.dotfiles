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
Plug 'junegunn/gv.vim'

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'
let g:NERDTreeUpdateOnCursorHold = 0
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeWinSize = 40
let g:NERDTreeMinimalUI=1
let g:NERDTreeCascadeSingleChildDir=0
let g:NERDTreeAutoDeleteBuffer=1
" Plug 'troydm/easytree.vim'
" Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }

Plug 'Lokaltog/vim-easymotion'
Plug 'matze/vim-move'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

Plug 'morhetz/gruvbox'


Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-completion-manager'
Plug '~/code/ncm-phpactor', {'for': 'php'}
" Plug 'fgrsnau/ncm-otherbuf'

" Plug '~/code/neomake'
Plug 'neomake/neomake'

Plug 'padawan-php/deoplete-padawan', {'for': 'php'}
" Plug 'padawan-php/padawan.vim'

let g:pdv_cfg_InsertFuncName = 0
let g:pdv_cfg_InsertVarName = 0
Plug 'phux/php-doc-modded', {'for': 'php'}
Plug 'sahibalejandro/vim-php', {'for': ['php', 'yaml']}
Plug 'StanAngeloff/php.vim', {'for': 'php'}

Plug 'alvan/vim-php-manual', {'for': 'php'}

Plug 'vim-php/vim-php-refactoring', {'for': 'php'}
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
" https://github.com/AJenbo/php-refactoring-browser
let g:php_refactor_command='php ~/compiles/php-refactoring-browser/refactor.phar'

Plug '~/.tooling/phpactor', {'for': 'php', 'do': ':call phpactor#Update()' }

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
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
" Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}

Plug 'simeji/winresizer'
Plug 'wellle/targets.vim'


" Plug 'wincent/loupe'
" Plug 'milkypostman/vim-togglelist'
Plug 'romainl/vim-qf'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'vim-scripts/YankRing.vim'
" Plug 'nrocco/vim-phplint', {'for': 'php'}
Plug 'gabrielelana/vim-markdown', {'for': 'markdown'}
Plug 'junegunn/goyo.vim', {'for': 'markdown'}
Plug 'shime/vim-livedown', {'for': 'markdown'}
" Plug 'dahu/vim-fanfingtastic'
" Plug 'justinmk/vim-sneak'
" Plug 'rhysd/clever-f.vim'
" Plug 't9md/vim-smalls'


Plug 'mhartington/nvim-typescript', {'do': ':UpdateRemotePlugins'}
Plug 'leafgarland/typescript-vim', {'for': 'js'}
Plug 'Quramy/vim-js-pretty-template', {'for': 'js'}
Plug 'othree/html5.vim', {'for': 'html'} 
Plug 'hail2u/vim-css3-syntax', {'for': 'css'}
Plug 'nelsyeung/twig.vim', {'for': 'twig'}
Plug 'mtth/scratch.vim'

Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'junegunn/vim-peekaboo'
call plug#end()

let mapleader = "\<Space>"
nnoremap <silent> <leader><f5> :e $MYVIMRC<CR>
inoremap jk <esc>

" interface
set t_Co=256
set background=dark
" colorscheme base16-ashes
colorscheme gruvbox
" colorscheme seoul256
" colorscheme apprentice

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

if has('patch-7.3.541')
  set formatoptions+=j
endif
" if has('patch-7.4.338')
  let &showbreak = '↳ '
"   set breakindent
  set breakindentopt=sbr
" endif

set formatoptions-=o                  " do not continue comment using o or O
" "show this in front of broken lines
" set showbreak=↪
" Line wrapping
set wrap
" move over lines with following keys
set whichwrap+=<,>,[,],h,l

" " but don't split words
set lbr

augroup everything
    au!
    au BufWritePost $MYVIMRC nested source $MYVIMRC

    au filetype yaml setl sw=2 sts=2 et
    au BufNewFile,BufRead *.yml.dist set ft=yaml
    au filetype ruby setl sw=2 sts=2 et

    " au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
    " au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
    " au filetype make setlocal noexpandtab tabstop=4 shiftwidth=4 
    au filetype php setlocal tabstop=4 shiftwidth=4 
    " au filetype javascript setlocal noexpandtab tabstop=2 shiftwidth=2 
    " au filetype typescript setlocal noexpandtab tabstop=2 shiftwidth=2 

    au BufRead,BufNewFile *.conf setf config

    au BufNewFile,BufRead *.phtml set ft=php.html
    au BufNewFile,BufRead composer.lock set ft=json
    au filetype html,xml inoremap <buffer> <m-;> </<c-x><c-o>

    au filetype css setlocal omnifunc=csscomplete#CompleteCSS

    " au filetype php LanguageClientStart
    au filetype html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    au filetype javascript setlocal omnifunc=tern#Complete
    au filetype xml setlocal omnifunc=xmlcomplete#CompleteTags
    au filetype xml   setlocal makeprg=xmllint\ -
    au filetype json  setlocal equalprg=python\ -mjson.tool


    " no delay when ESC/jk
    au InsertEnter * set timeoutlen=100
    au InsertLeave * set timeoutlen=500

    " au filetype php silent! call StartLanguageClientOnce

    " au FocusLost * silent! update
    " autocmd BufWritePost *.php silent Phplint
    autocmd BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
    " When writing a buffer, and on normal mode changes (after 750ms).
    call neomake#configure#automake('w')

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

    autocmd CursorHold * normal! m'


    au filetype javascript setlocal omnifunc=tern#Complete
    au filetype javascript LanguageClientStart
    au filetype typescript LanguageClientStart
    au filetype typescript nnoremap <buffer> gd :TSDef<CR>
    au filetype typescript nnoremap <buffer> gr :TSRefs<CR>
    au filetype typescript nnoremap <buffer> K :TSDefPreview<cr>

    " au filetype php set omnifunc=phpactor#Complete
augroup END

" nnoremap <leader>n :EasyTreeToggle<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>N :NERDTreeFind<cr>

let g:LanguageClient_diagnosticsEnable  = 0
let g:LanguageClient_diagnosticsList = ''
let g:LanguageClient_signColumnAlwaysOn = 0
let g:LanguageClient_selectionUI = 'fzf'

" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
" nnoremap K :call LanguageClient_textDocument_hover()<cr>
let g:LanguageClient_serverCommands = {
            \ 'javascript.jsx': ['~/compiles/javascript-typescript-langserver/lib/language-server-stdio.js'],
            \ 'typescript': ['~/compiles/javascript-typescript-langserver/lib/language-server-stdio.js']
            \ }

set encoding=utf-8
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set hidden
set nojoinspaces

" no backups {{{2
set nobackup
set nowritebackup
set noswapfile
" }}}



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


nnoremap <silent> <leader>w :w<cr>
command! -bang PadawanGenerate call deoplete#sources#padawan#Generate(<bang>0)
nnoremap <silent> <leader>W :w<cr>:silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &<cr>:PadawanGenerate<cr>



let g:ultisnips_php_scalar_types = 1
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips/'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

if !exists('$TMUX')
  nnoremap <c-j> <c-w>j
  nnoremap <c-k> <c-w>k
  nnoremap <c-h> <c-w>h
  nnoremap <c-l> <c-w>l
endif


let g:echodoc_enable_at_startup=1
set noshowmode

let g:fzf_layout = { 'down': '~40%' }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" command! -bang -nargs=? -complete=dir Files
"   \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

vnoremap // "hy:exec "Ag ".escape('<C-R>h', "/\.*$^~[()")<cr>



nnoremap <leader><Enter> :FZFMru<cr>
nnoremap <leader>s :Rg<space>
nnoremap <leader>S :exec "Rg ".expand("<cword>")<cr>


nnoremap <leader><tab> :Buffers<cr>
nnoremap <leader>, :Files<cr>
nnoremap <leader>. :FZFAllFiles<cr>
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
nnoremap <leader>rep :call PhpExtractClassProperty()<cr>
nnoremap <leader>rrv :call PhpRefactorRenameLocalVariable()<cr>


nnoremap <leader>rdo :call PhpDocOneliner()<cr>
vnoremap <leader>rev :call PHPExtractVariable()<cr>
nnoremap <leader>H :call PhpConstructorArgumentMagic2()<cr>
nnoremap <leader>rmc :call PHPMoveClass()<cr>
nnoremap <leader>rmd :call PHPMoveDir()<cr>
nnoremap <leader>rcc :call PhpConstructorArgumentMagic()<cr>
nnoremap <m-a> :call phpactor#ContextMenu()<cr>
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

let g:phpactor_executable = '~/.tooling/phpactor/bin/phpactor'
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

function! PHPCreateBuilder()
    :w
    let l:interfaceFile = substitute(expand('%'), '.php', 'Builder.php', '')
    execute "!".g:phpactor_executable." class:inflect ".expand('%').' '.l:interfaceFile.' builder'
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

nnoremap <leader>] :%Subvert/<c-R><c-w>/<c-r><c-w>/g<left><left>
vnoremap <leader>] :%Subvert//g<left><left>

filetype plugin indent on
syntax on

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
nnoremap <m-m> :call PHPUnitSetupMethod()<cr>

set tabstop=2
set shiftwidth=2
set scrolloff=5
set shiftround
set expandtab smarttab
set autoindent                        " indent when creating newline
set smartindent
set lazyredraw
set modelines=2
set synmaxcol=1000


set ignorecase smartcase
set hlsearch
set incsearch


let g:PHP_removeCRwhenUnix = 1
set timeout ttimeoutlen=0

inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#sources = get(g:, 'deoplete#sources', {})
let g:deoplete#sources._ = ['ultisnips', 'buffer']

let g:deoplete#sources#padawan#add_parentheses=1
let g:deoplete#sources#padawan#server_command='~/code/padawan.php/bin/padawan-server'
let g:deoplete#sources.php = ['padawan', 'ultisnips', 'buffer']
let g:deoplete#skip_chars = ['$']

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
nnoremap <leader>tf :TestFile<cr>
nnoremap <silent> <leader>tl :TestLast<CR>
nnoremap <silent> <leader>tv :TestVisit<CR>

set completeopt=menuone,longest
set complete-=i

set textwidth=0
if exists('&colorcolumn')
  " set colorcolumn=80
endif

set nostartofline



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

nnoremap <F10> :TagbarToggle<cr>

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

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --line-number --no-heading --ignore-case --follow --color=always --colors "match:bg:yellow" --colors "match:fg:black" --colors "match:style:nobold" --colors "path:fg:green" --colors "path:style:bold" --colors "line:fg:yellow" --colors "line:style:bold" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
" --no-ignore for searching in all files
command! -bang -nargs=* RgRaw
  \ call fzf#vim#grep(
  \   'rg --no-ignore --line-number --no-heading --ignore-case --follow --hidden --color=always --colors "match:bg:yellow" --colors "match:fg:black" --colors "match:style:nobold" --colors "path:fg:green" --colors "path:style:bold" --colors "line:fg:yellow" --colors "line:style:bold" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
let g:ackprg = 'rg --vimgrep --no-heading'

command! -bang -nargs=* FZFAllFiles call fzf#run({'source': 'find * -type f', 'sink': 'e'})

function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

command! -nargs=* Ag call fzf#run({
\ 'source':  printf('ag --nogroup --column --color "%s"',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })

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
        " return
    endif

    " " multiple object operator split - repeatable
    let l:numOfObjectOperators = len(split(l:currentLine, '->', 1)) - 1
    if l:numOfObjectOperators > 0
        try
            s/)->/)\r->/g
        catch
        endtry
        normal! ='a
        " return
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
        " return
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
        " return
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

so ~/.projects.public.vim

nnoremap <leader><F3> :%s/<[^>]*>/\r&\r/g<cr>gg=G:g/^$/d<cr><leader>/

function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
            "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction

command! Ball :call DeleteInactiveBufs()

let test#strategy='neovim'

let g:yankring_replace_n_pkey = '<m-h>'
let g:yankring_replace_n_nkey = '<m-H>'
" set diffopt+=vertical
set diffopt=vertical,filler

nnoremap dg3 :diffget //3<cr>
nnoremap dg2 :diffget //2<cr>

" nmap gs  <plug>(GrepperOperator)
" xmap gs  <plug>(GrepperOperator)

set confirm

let g:scratch_persistence_file = '.scratch.vim'
nnoremap <leader>z :Scratch<cr>

" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c

let g:cm_sources_override = {
\ 'cm-tags': {'enable':0}
\ }
let g:cm_complete_start_delay=20


let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" set cul

highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

" workaround for single location list entries
nmap <silent> <m-p> <Plug>qf_loc_previous              
nmap <silent> <m-n> <Plug>qf_loc_next

" per default disabled
let g:neomake_open_list = 0

set cul

set notagrelative
