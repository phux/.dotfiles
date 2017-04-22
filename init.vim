" Bootstrap {{{
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if &compatible
    set nocompatible
endif

if has("nvim")
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
endif

set encoding=utf-8
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything

" }}}

" plugins {{{
" autoinstall {{{2
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd!
    autocmd VimEnter * PlugInstall
endif
" }}}

" plugged {{{


call plug#begin('~/.config/nvim/plugged')

" mandatory tpope section
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary', {'on': 'Commentary'}
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-speeddating'

Plug 'ap/vim-buftabline'
let g:buftabline_show = 1 " display only if more than 1 buffer open


Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Plug 'vim-scripts/auto-pairs-gentle'
Plug 'jiangmiao/auto-pairs'
" Plug 'Raimondi/delimitMate'
" Plug 'Townk/vim-autoclose'

Plug 'amiorin/vim-project'

" git {{{
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite', {'on': 'Extradite'}
nnoremap <leader>i :Extradite<cr>
Plug 'gregsexton/gitv', {'on': 'Gitv'}
" }}}

" navigating {{{
Plug 'Lokaltog/vim-easymotion'
Plug 'matze/vim-move'
" jjjjjjjjjj is not cool
" Plug 'phux/vim-hardtime'
" enhancing word recognition like camel case
Plug 'chaoren/vim-wordmotion'

Plug 'troydm/easytree.vim'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
" }}}

Plug 'godlygeek/tabular', {'on': 'Tabularize'}

" color schemes {{{
" Plug 'crusoexia/vim-monokai'
Plug 'morhetz/gruvbox'
" Plug 'altercation/vim-colors-solarized'
" Plug 'jacoborus/tender.vim'
" }}}

Plug 'veloce/vim-behat', {'for': ['cucumber', 'behat']}
let g:feature_filetype='behat'
let g:behat_executables = ['vendor/bin/behat']

" autocompletion {{{
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" note: in global composer json "minimum-stability":"dev"
" composer global require mkusher/padawan
Plug 'padawan-php/deoplete-padawan', {'for': 'php'}
" Plug '~/code/deoplete-padawan', {'for': 'php'}
Plug 'zchee/deoplete-go', { 'do': 'make'}
" }}}

Plug 'zhaocai/GoldenView.Vim'

Plug 'w0rp/ale'

" php {{{
" Plug 'phpstan/vim-phpstan', {'for': 'php'}
Plug 'phux/vim-phpstan', {'for': 'php'}
" has issue with path
" nnoremap <silent> <m-a> :ALEDisable<cr>:exec "PHPStanAnalyse -c phpstan.neon ".expand("%")<cr>
nnoremap <silent> <m-a> :ALEDisable<cr>:exec "PHPStanAnalyse -c phpstan.neon src"<cr>
let g:phpstan_analyse_level = 4
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'Herzult/phpspec-vim', {'for': 'php'}
let g:phpspec_executable = 'vendor/bin/phpspec'
let g:phpspec_default_mapping = 0
" Plug 'shawncplus/phpcomplete.vim', {'for': 'php'}
Plug 'Rican7/php-doc-modded', {'for': 'php'}
Plug 'sahibalejandro/vim-php', {'for': ['php', 'yaml']}
Plug 'joonty/vdebug', {'for': 'php'}
Plug '2072/PHP-Indenting-for-VIm', {'for': 'php'}
Plug 'alvan/vim-php-manual', {'for': 'php'}
Plug 'nrocco/vim-phplint', {'for': 'php'}
Plug 'phux/vim-php-refactoring', {'branch': 'develop', 'for': 'php'}
let g:php_refactor_command='~/bin/refactor.phar'
" }}}

Plug 'evidens/vim-twig', {'for': 'twig'}

Plug 'avakhov/vim-yaml', {'for': 'yaml'}

Plug 'phux/scratch.vim'

Plug 'fatih/vim-go', {'for': 'go'}
Plug 'buoto/gotests-vim', {'for': 'go'}

" tmux {{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
" }}}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'Shougo/echodoc.vim'

Plug 'merlinrebrovic/focus.vim'

Plug 'romainl/vim-qf'
" searching {{{
Plug 'henrik/vim-indexed-search'
Plug 'romainl/vim-cool'
Plug 'wincent/ferret', {'on': 'Ack'}
" }}}


" clipboard {{{
Plug 'junegunn/vim-peekaboo'
Plug 'maxbrunsfeld/vim-yankstack'
" }}}
Plug 'iamcco/markdown-preview.vim'
Plug 'pbogut/fzf-mru.vim'
call plug#end()
" }}}
let g:mkdp_path_to_chrome = "chromium-browser"
let g:mkdp_auto_start = 1
    " set to 1, the vim will open the preview window once enter the markdown
    " buffer

    let g:mkdp_auto_open = 1
    " set to 1, the vim will auto open preview window when you edit the
    " markdown file

    let g:mkdp_auto_close = 1
    " set to 1, the vim will auto close current preview window when change
    " from markdown buffer to another buffer
" }}}

" needs to be called before mappings like Y => y$ are done.
call yankstack#setup()

" general {{{

" interface {{{2
" colorscheme tender
set background=dark
colorscheme gruvbox
" colorscheme monokai
" let g:solarized_termcolors=256
" colorscheme solarized
" colorscheme apprentice
" colorscheme color_1

set number
set relativenumber

" Line wrapping
set wrap
" " but don't split words
set lbr


" diffing {{{
set fillchars+=diff:⣿
set diffopt=vertical                  " Use in vertical diff mode
set diffopt+=filler                   " blank lines to keep sides aligned
set diffopt+=iwhite                   " Ignore whitespace changes

" Highlight VCS conflict markers
" @see {@link https://bitbucket.org/sjl/dotfiles/src/83aac563abc9d0116894ac61db2c63c9a05f72be/vim/vimrc?at=default&fileviewer=file-view-default#vimrc-233}
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" }}}


set nrformats-=octal                  " never use octal when <C-x> or <C-a>

set textwidth=79
set formatoptions=qrn1tcl
set formatoptions-=o                  " do not continue comment using o or O
" "show this in front of broken lines
set showbreak=↪
" Set the command window height to 1 lines
set cmdheight=1
" This makes more sense than the default of 1
set winminheight=1

set shortmess+=cfilmnrxoOtT
" highlight chars
set list
set listchars=tab:\ \ ,trail:•,extends:#,nbsp:. 
" Show partial commands in the last line of the screen
set showcmd


" }}}

set hidden

" no backups {{{2
set nobackup
set nowritebackup
set noswapfile
" }}}


" move over lines with following keys
set whichwrap+=<,>,[,],h,l

" Don't fail, ask
set confirm

" Copy to Clipboard (on Unix)
set clipboard+=unnamed

" windows {{{2
" use open windows/tabs for buffer switching
set switchbuf=useopen,usetab
" split new window at the right bottom of current
set splitbelow
" set splitright
" }}}

" indentation {{{2
set nojoinspaces
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab
set autoindent                        " indent when creating newline

" For autoindent, use same spaces/tabs mix as previous line, even if
" tabs/spaces are mixed. Helps for docblock, where the block comments have a
" space after the indent to align asterisks
"
" The test case what happens when using o/O and >> and << on these:
"
"     /**
"      *
"
" Refer also to formatoptions+=o (copy comment indent to newline)
set nocopyindent

" Try not to change the indent structure on "<<" and ">>" commands. I.e. keep
" block comments aligned with space if there is a space there.
set nopreserveindent

" Smart detect when in braces and parens. Has annoying side effect that it
" won't indent lines beginning with '#'. Relying on syntax indentexpr instead.
" 'smartindent' in general is a piece of garbage, never turn it on.
set nosmartindent

" Global setting. I don't edit C-style code all the time so don't default to
" C-style indenting.
set nocindent
" }}}

" search {{{
" hi Search cterm=NONE ctermfg=white ctermbg=130
set ignorecase
set smartcase
set hlsearch
set incsearch
" }}}

" undo {{{2
set undofile                " Save undo's after file closes
set undodir=~/.undonvim " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000
" }}}

" completion {{{2
" Better command-line completion
set wildignore+=*.pyc,*.zip,*.gz,*.bz,*.tar,*.jpg,*.png,*.gif,*.avi,*.wmv,*.ogg,*.mp3,*.mov,*.phar
set wildmode=list:longest,full
" Limit popup menu height
set pumheight=15
set completeopt=menuone,longest

set complete=.,w,b,u
" }}}

" diff {{{2
" ignore whitespaces when vimdiff'ing
set diffopt=iwhite
set diffopt+=vertical
" }}}

" restore cursor position {{{2
func! RestorePosition()
    if exists("g:restore_position_ignore") && match(expand("%"), g:restore_position_ignore) > -1
        return
    endif

    if line("'\"") > 1 && line("'\"") <= line("$")
        exe "normal! g`\""
    endif
endfunc
" }}}

let g:PHP_removeCRwhenUnix = 1

set timeout ttimeoutlen=0


" Mappings {{{
let mapleader = "\<Space>"
" Edit the vimrc file
nnoremap <silent> <leader><f5> :e $MYVIMRC<CR>

inoremap jk <esc>

" movement {{{
" map j to gj and k to gk, so line navigation ignores line wrap
" conflicts with <count>j, so disabled for now
" nnoremap j gj
" nnoremap k gk

nnoremap L g_
nnoremap H ^

" jump to line AND column
nnoremap ' `
nnoremap ` '
" }}}

" Copy Paste {{{
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
vnoremap <leader>d "+d
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

"  select pasted text
noremap gV `[v`]
" }}}

" nnoremap <leader>W :set nowrap!<CR>

" fast closing of html tags
nnoremap <m-;> :ToggleGoldenViewAutoResize<cr>

map gn :bn<cr>
map gp :bp<cr>

" find next line with same indentation
nnoremap [= 0y^/^<C-R>0\s\@!<CR>
nnoremap ]= 0y^?^<C-R>0\s\@!<CR>
" continue indenting
vnoremap < <gv
vnoremap > >gv

" cmd line {{{
" command line bash behavior
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
" }}}

" delete char after cursor in insert mode, same as del key
inoremap <c-l> <del>

" windows {{{
" disabled because of tmux-navigator
" noremap <silent> <c-l> <c-w>l
" noremap <silent> <c-j> <c-w>j
" noremap <silent> <c-k> <c-w>k
" noremap <silent> <c-h> <c-w>h

" create splits
nnoremap c<C-j> :bel sp<cr>
nnoremap c<C-k> :abo sp<cr>
nnoremap c<C-h> :lefta vsp<cr>
nnoremap c<C-l> :rightb vsp<cr>

" kill windows
nnoremap d<C-j> <C-w>j<C-w>c
nnoremap d<C-k> <C-w>k<C-w>c
nnoremap d<C-h> <C-w>h<C-w>c
nnoremap d<C-l> <C-w>l<C-w>c
nnoremap <leader>x <c-w>c:GoldenViewResize<cr>:EnableGoldenViewAutoResize<cr>


" resize
nnoremap <silent> <leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
" }}}

" tag navigation {{{
noremap <silent> <leader>tn :ptn<cr>
noremap <silent> <leader>tp :ptp<cr>
noremap <silent> <leader>tc :pc<cr>

" nnoremap <leader>o :call GoldenView#Split()<cr><c-]>:SwitchGoldenViewMain<cr>
nnoremap <leader>o :call GoldenView#Split()<cr>g<c-]>

" }}}


" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Do not show stupid q: window
map q: :q

" search {{{
nnoremap n nzzzv
nnoremap N Nzzzv
" }}}

" Refactor names easily (hit <leader>[ or <leader>] with cursor on the word you'd like to rename

nnoremap <leader>[ :%s/<c-r><c-w>/<c-r><c-w>/g<left><left>

" reformat html -> each tag on own row
nnoremap <leader><F3> :%s/<[^>]*>/\r&\r/g<cr>gg=G:g/^$/d<cr><leader>/

let g:php_manual_online_search_shortcut = '<leader>m'

" remove buffer without deleting window
nnoremap <silent> <m-d> :bp<bar>sp<bar>bn<bar>bd<CR>

" buffer cleanup {{{
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
" }}}

vnoremap <Enter> <Plug>(EasyAlign)

nnoremap <leader>; :TagbarToggle<cr>

"}}}


" ====================
" = Custom functions
" ====================

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
" }}}


" QFix toggle {{{
" toggles the quickfix window.
map <leader>q :Ctoggle<cr>

function! s:qf_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor

    cwindow
endfunction

command! Ctoggle call s:qf_toggle() 
"}}}

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

" switch between files v2 {{{
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

function! SwitchBetweenFiles1(fileExtension, firstDirBeginning, secondDirBeginning, filenameAddition)
    let f = bufname("%")
    if f =~ '.'.a:fileExtension
        if f =~ a:firstDirBeginning && f =~ a:filenameAddition.'\.'.a:fileExtension
            let filename = substitute(substitute(f, a:firstDirBeginning, 'Bundle/', ''), a:filenameAddition, '', '')
            if !filereadable(filename)
                let new_dir = substitute(filename, '/\w\+\.'.a:fileExtension, '', '')
                exe ":!mkdir -p ".new_dir
            endif
            exe ":e ".filename
        elseif f =~ a:secondDirBeginning && f !~ a:filenameAddition.'\.'.a:fileExtension
            let filename = substitute(substitute(f, a:secondDirBeginning, a:firstDirBeginning, ''), '.'.a:fileExtension, a:filenameAddition.'.'.a:fileExtension, '')
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
" }}}

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

function! SymfonySwitchToAlternateFile()
    let l:f = expand('%')
    let l:preceedingDirsToKeep = 2
    let l:is_test = expand('%:t') =~ "Test\."
    if l:is_test
        " remove phpunit_testroot
        let l:f = substitute(l:f, 'Tests/','','')
        " remove 'Test.' from filename
        let l:f = substitute(l:f,'Test\.','.','')
    else
        let l:pathParts = split(expand('%:r'), '/')
        let l:startingPath = l:pathParts[0:l:preceedingDirsToKeep]
        let l:endPath = l:pathParts[(l:preceedingDirsToKeep+1):]
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

" PrependTicketNumber {{{

" insert ticket number into commit msg
function! PrependTicketNumber()
    normal gg
    let l:branch = system("echo $(git branch | grep '*')")
    let l:ticketNumber = '['.substitute(l:branch, '\* \(.*\)', '\1', '').'] '
    exe "normal i".l:ticketNumber
    normal! kJx
    :startinsert!
endfunction
augroup git_commit
    au!
    " au BufEnter * if &ft ==# 'gitcommit' | :call PrependTicketNumber() | endif
    autocmd filetype gitcommit nnoremap <buffer> <leader>w :call PrependTicketNumber()<cr>
augroup END
" }}}


nnoremap <silent> <leader>w :w<cr>
nnoremap <silent> <leader>W :w<cr>:ALEEnable<cr>:silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &<cr>


" performance settings {{{
set nocursorcolumn       " do not highlight column
set nocursorline         " do not highlight line
" syntax sync minlines=256 " start highlighting from 256 lines backwards
set synmaxcol=200 " do not highlith very long lines
" autocmd BufWinEnter,Syntax * syn sync minlines=500 maxlines=500
" set re=1
" set lazyredraw
" set scrolljump=5
" set sidescroll=1
" let g:PHP_default_indenting=0
" }}}


" extract php interface {{{2
nnoremap <leader>rei :call ExtractInterface()<cr>
function! ExtractInterface()
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
" }}}

" filetype settings {{{

" set foldenable fdm=syntax foldnestmax=1
" let g:vimsyn_folding='af'
" let g:xml_syntax_folding = 1
" let g:php_folding = 1

augroup filetype_settings
    au!
    au BufNewFile,BufRead *.feature set ft=behat
    au filetype behat,cucumber setl sw=2 sts=2 et
    au filetype yaml setl sw=2 sts=2 et
    au BufNewFile,BufRead *.yml.dist set ft=yaml
    au filetype ruby setl sw=2 sts=2 et

    " au filetype vim setl foldenable fdm=marker fmr={{{,}}} fdl=0
    au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
    au filetype make setlocal noexpandtab tabstop=4 shiftwidth=4 

    au BufRead,BufNewFile *.conf setf config

    au BufNewFile,BufRead *.phtml set ft=php.html
    au filetype html,xml inoremap <m-;> </<c-x><c-o>

    au filetype qf setlocal wrap

    au filetype css setlocal omnifunc=csscomplete#CompleteCSS
    au filetype html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    au filetype javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    au filetype xml setlocal omnifunc=xmlcomplete#CompleteTags
    au filetype xml   setlocal makeprg=xmllint\ -
    " au filetype xml   setlocal equalprg=xmllint\ --format\ -
    au filetype html  setlocal equalprg=tidy\ -q\ -i\ -w\ 80\ -utf8\ --quote-nbsp\ no\ --output-xhtml\ yes\ --show-warnings\ no\ --show-body-only\ auto\ --tidy-mark\ no\ -
    au filetype xhtml setlocal equalprg=tidy\ -q\ -i\ -w\ 80\ -utf8\ --quote-nbsp\ no\ --output-xhtml\ yes\ --show-warnings\ no\ --show-body-only\ auto\ --tidy-mark\ no\ -
    au filetype json  setlocal equalprg=python\ -mjson.tool
augroup END

augroup pre_post_hooks
    au!
    " no delay when ESC/jk
    au InsertEnter * set timeoutlen=100
    au InsertLeave * set timeoutlen=1000

    au BufReadPost * call RestorePosition()

    au BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END 

" help {{{
augroup help_settings
    au!
    au filetype help nnoremap <buffer> <CR> <c-]>
    au filetype help nnoremap <buffer> <bs> <c-T>
    au filetype help nnoremap <buffer> q :q<CR>
    au filetype help set nonumber
augroup END
" }}}
" }}}

noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

nnoremap <silent> <leader>tu :call SwitchBetweenFiles1('php', 'Bundle/Tests/', 'Bundle/', 'Test')<cr>
nnoremap <silent> <leader>tsu <c-w>v:call SwitchBetweenFiles1('php', 'Bundle/Tests/', 'Bundle/', 'Test')<cr>


" write on focus loss
augroup focus_lost
    au!
    au FocusLost * silent! update
augroup END

" }}}

" plugin settings {{{

" easytree {{{2
let g:easytree_width_auto_fit = 1

function! CloseOpenEasyTreeBuffers()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&filetype') == 'easytree'
            exe "bd ".bnum
        endif
    endfor
endfunction

" same like nerdtreefind file
nnoremap <leader>N :let @a = expand("%:t")<cr>:call CloseOpenEasyTreeBuffers()<cr>:EasyTree %:p:h<cr>/<c-r>a<cr>:nohls<cr>

nnoremap <leader>n :EasyTreeToggle<cr>
" }}}

" ultisnips {{{2
let g:ultisnips_php_scalar_types = 1
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips/'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" }}}

" echodoc {{{2
let g:echodoc_enable_at_startup=1
set noshowmode
" }}}

" fzf {{{2
let g:fzf_layout = { 'down': '~40%' }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:rg_to_qf(line)
    let parts = split(a:line, ':')
    return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
                \ 'text': join(parts[3:], ':')}
endfunction

function! s:rg_handler(lines)
    if len(a:lines) < 2 | return | endif

    let cmd = get({'ctrl-x': 'split',
                \ 'ctrl-v': 'vertical split',
                \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
    let list = map(a:lines[1:], 's:rg_to_qf(v:val)')

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

augroup fzf_rg
    autocmd!

    " \ 'source':  printf('rg --column --smart-case --line-number --no-heading --fixed-strings --no-ignore --hidden --follow --glob "!.git/*" --color "always" "%s"',
    " \                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
    autocmd VimEnter * command! -nargs=* Rg call fzf#run({
                \ 'source':  'rg --column --smart-case --line-number --no-heading --fixed-strings --hidden --follow --glob "!.git/*" --colors "match:fg:yellow" --colors "path:fg:green" --color "always" --sort-files '. escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\'),
                \ 'sink*':    function('<sid>rg_handler'),
                \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
                \            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
                \            '--color hl:68,hl+:110',
                \ 'down':    '50%'
                \ })

augroup END


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

augroup fzf_ag
    autocmd!
    autocmd VimEnter * command! -nargs=* Ag call fzf#run({
                \ 'source':  printf('ag --nogroup --column --color "%s"',
                \                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
                \ 'sink*':    function('<sid>ag_handler'),
                \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
                \            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
                \            '--color hl:68,hl+:110',
                \ 'down':    '50%'
                \ })

    autocmd VimEnter * command! -nargs=* Agu call fzf#run({
                \ 'source':  printf('ag -U --nogroup --column --color "%s"',
                \                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
                \ 'sink*':    function('<sid>ag_handler'),
                \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
                \            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
                \            '--color hl:68,hl+:110',
                \ 'down':    '50%'
                \ })
augroup END

function! GitRebaseAll()
    normal! gg
    s/pick/p/
    normal! j
    %s/^pick/squash/
endfunction
autocmd filetype gitrebase nnoremap <buffer> <leader>w :call GitRebaseAll()<cr>

function! s:buflist()
    redir => ls
    silent ls
    redir END
    return split(ls, '\n')
endfunction

function! s:bufopen(e)
    execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <leader>d :call fzf#run({
            \   'source':  reverse(<sid>buflist()),
            \   'sink':    function('<sid>bufopen'),
            \   'options': '+m',
            \   'down':    len(<sid>buflist()) + 2
            \ })<CR>


function! s:tags_sink(line)
    let parts = split(a:line, '\t\zs')
    let excmd = matchstr(parts[2:], '^.*\ze;"\t')
    execute 'silent e' parts[1][:-2]
    let [magic, &magic] = [&magic, 0]
    execute excmd
    let &magic = magic
endfunction

function! s:tags()
    if empty(tagfiles())
        echo "no tag file found"
        return
    endif

    call fzf#run({
                \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
                \            '| grep -v -a ^!',
                \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
                \ 'down':    '40%',
                \ 'sink':    function('s:tags_sink')})
endfunction

command! Tags call s:tags()

vnoremap // "hy:exec "Ag".escape('<C-R>h', "/\.*$^~[()")<cr>

nnoremap <leader><Enter> :FZFMru<cr>
nnoremap <leader>a :ALEDisable<cr>:Ag<space>
nnoremap <leader>A :ALEDisable<cr>:exec "Ag".expand("<cword>")<cr>

nnoremap <leader>s :exec "Tags ".expand("<cword>")<cr>
nnoremap <leader>, :Files<cr>
" }}}

" auto-pairs {{{2
let g:AutoPairsFlyMode = 0
let g:AutoPairsMapSpace = 0
let g:AutoPairsMultilineClose = 0
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = '<c-h>'
" }}}

" vim-project {{{2
let g:project_use_nerdtree = 0
let g:project_enable_welcome = 0
nnoremap <leader><F1> :e ~/.projects.public.vim<cr>
nnoremap <leader><F2> :e ~/.projects.private.vim<cr>

set rtp+=~/.config/nvim/plugged/vim-project/
call project#rc("~/code")
" }}}

" fugitive {{{2
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gl :silent! Gllog --<cr>
nnoremap <leader>gp :!git push<cr>
" }}}

" gitv {{{2
nnoremap <leader>gv :Gitv!<cr>
vnoremap <leader>gv :Gitv!<cr>
nnoremap <leader>gV :Gitv<cr>
augroup gitv
    au!
    autocmd Filetype gitv nmap <buffer> <silent> <C-n> <Plug>(gitv-previous-commit)
    autocmd Filetype gitv nmap <buffer> <silent> <C-p> <Plug>(gitv-next-commit)
augroup END

let g:Gitv_DoNotMapCtrlKey = 1
" }}}

" php-refactoring-toolbox {{{2
let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"

let g:vim_php_refactoring_use_default_mapping = 0
nnoremap <leader>rp :call PhpRenameClassVariable()<CR>
nnoremap <leader>rm :call PhpRenameMethod()<CR>
nnoremap <leader>eu :call PhpExtractUse()<CR>
vnoremap <leader>ec :call PhpExtractConst()<CR>
" vnoremap <leader>em :call PhpExtractMethod()<CR>
" https://github.com/QafooLabs/php-refactoring-browser/releases
nnoremap <leader>ep :call PhpRefactorLocalVariableToInstanceVariable()<cr>
vnoremap <silent> <leader>em :call PhpRefactorExtractMethodDirectly()<CR>
" nnoremap <leader>rv :call PhpRenameLocalVariable()<CR>
nnoremap <leader>rv :call PhpRefactorRenameLocalVariable()<cr>
" https://github.com/dunglas/phpdoc-to-typehint/releases
nnoremap <leader>rt :exec "Silent ~/bin/phpdoc-to-typehint.phar ".expand('%:p:h')<cr>:e<cr>
" }}}

" phpcomplete {{{2
" let g:phpcomplete_complete_for_unknown_classes = 0
" let g:phpcomplete_relax_static_constraint=0
" let g:phpcomplete_search_tags_for_variables = 0
" let g:phpcomplete_parse_docblock_comments = 0
" let g:phpcomplete_enhance_jump_to_definition = 1

augroup php
    au!
    autocmd BufWritePost *.php silent Phplint
    autocmd BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
    autocmd filetype php nnoremap <Leader>u :PHPImportClass<cr>
    autocmd filetype php nnoremap <Leader>e :PHPExpandFQCNAbsolute<cr>
    autocmd filetype php nnoremap <Leader>E :PHPExpandFQCN<cr>
augroup END
" }}}

" deoplete {{{2
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#auto_refresh_delay = 100
let g:deoplete#auto_complete_delay= 50
" let g:deoplete#sources#padawan#auto_update = 1

let g:deoplete#sources#padawan#add_parentheses=1
" needed for echodoc to work if add_parentheses is 1
let g:deoplete#skip_chars = ['$']

call deoplete#custom#set('_', 'converters',
            \ ['converter_auto_delimiter', 'remove_overlap',
            \ 'converter_truncate_abbr', 'converter_truncate_menu'])
" call deoplete#custom#set('_', 'converters',
"             \ ['converter_auto_delimiter', 'remove_overlap'])
" call deoplete#custom#set('_', 'converters',
"         \ ['converter_auto_delimiter', 'remove_overlap',
"         \ 'converter_auto_paren'])



augroup echodoc_debug
autocmd!
" autocmd CompleteDone * echo v:completed_item
augroup END
let g:deoplete#sources = {}
" let g:deoplete#sources._ = ['ultisnips', 'buffer']
let g:deoplete#sources.php = ['padawan', 'ultisnips', 'buffer']

inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1

" call deoplete#custom#set('_',
"             \ 'disabled_syntaxes', ['Comment', 'String'])
" }}}
augroup test_completion_fix
    au!
    au BufNewFile,BufRead,BufWinEnter *Test.php exe ":UltiSnipsAddFiletypes php.phpunit"
    au BufNewFile,BufRead,BufWinEnter *Spec.php exe ":UltiSnipsAddFiletypes php.php-phpspec"
augroup END

" phpdoc {{{2
let g:pdv_cfg_autoEndClass = 0
let g:pdv_cfg_php4always = 0
let g:pdv_cfg_autoEndFunction = 0
let g:pdv_cfg_FunctionName = 0
let g:pdv_cfg_Type = ""
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
vnoremap <leader>h :call PhpDocRange()<CR>
" }}}

" vdebug {{{2
let g:vdebug_options = {}
let g:vdebug_options["port"] = 9000
let g:vim_debug_disable_mappings = 1
let g:vdebug_keymap = {
            \    "run" : "<F5>",
            \    "run_to_cursor" : "<F9>",
            \    "step_over" : "<F2>",
            \    "step_into" : "<F3>",
            \    "step_out" : "<F4>",
            \    "close" : "<F6>",
            \    "detach" : "<F7>",
            \    "set_breakpoint" : "<F10>",
            \    "get_context" : "<F11>",
            \    "eval_under_cursor" : "<F12>",
            \    "eval_visual" : "<F8>",
            \}

highlight DbgBreakptLine ctermbg=none ctermfg=none
" }}}

" scratch {{{2
nnoremap <leader>z :Scratch<cr>
let g:scratch_top = 1
let g:scratch_persistence_file = '.scratch.vim'
" }}}

" vim-go {{{2
augroup go_plugin
    au!
    au filetype go nnoremap <leader>gf :GoCoverageToggle<cr>
    au filetype go nnoremap <leader>gr <Plug>(go-run)
    au filetype go nnoremap <leader>gb <Plug>(go-build)
    au filetype go nnoremap <leader>gt <Plug>(go-test)
    au filetype go nnoremap <leader>gd <Plug>(go-doc)
    au filetype go nnoremap <leader>gs <Plug>(go-implements)
    au filetype go nnoremap <leader>ge <Plug>(go-rename)
    au BufNewFile,BufRead,BufWinEnter *.go nnoremap <buffer> <leader>w :GoFmt<cr>
augroup END
let g:go_list_type = "location"


let g:go_bin_path = expand("~/.gvm/gos/go1.8/bin")
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
" }}}

" focus.vim {{{
let g:focus_use_default_mapping = 0
nmap <c-w>o <Plug>FocusModeToggle
" }}}

" goldenview {{{2
let g:goldenview__enable_default_mapping = 0
nmap <silent> <C-g>  <Plug>GoldenViewSplit
" 2. quickly switch current window with the main pane
" and toggle back
nnoremap <silent> <m-g> :SwitchGoldenViewSmallest<cr>
nnoremap <silent> <m-l> :SwitchGoldenViewMain<cr>
" }}}

" ferret {{{2
nnoremap <leader>i :ALEToggle<cr>
nnoremap <leader>/ :ALEDisable<cr>:Ack <c-r><c-w><cr>
" nnoremap <leader>, :ALEDisable<cr>:Ack
nnoremap <leader>rip :Acks /<c-r><c-w>/<c-r><c-w>/gc<left><left><left>
" }}}

" easymotion {{{2
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map  <Leader>F <Plug>(easymotion-bd-w)
nmap <Leader>F <Plug>(easymotion-overwin-w)
nmap <Leader>f <Plug>(easymotion-w)
map  <Leader>b <Plug>(easymotion-b)
let g:EasyMotion_smartcase = 1

" }}}

" commentary {{{2
nnoremap <leader>c :Commentary<cr>
vnoremap <leader>c :Commentary<cr>
" }}}

" tabularize {{{2
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
" }}}

" abolish {{{
nnoremap <leader>] :%S/<c-R><c-w>/<c-r><c-w>/g<left><left>
" }}}

" Peekaboo {{{
let g:peekaboo_window = 'vertical botright 70new'
" }}}

" easyclip {{{
nnoremap gm m
" nmap <silent> gs <plug>SubstituteOverMotionMap
" }}}

" vim-qf {{{
let g:qf_loclist_window_bottom = 0
let g:qf_window_bottom = 0

nmap <c-p> :cpre<cr>
nmap <c-n> :cne<cr>
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
" }}}


" hardtime {{{
let g:hardtime_ignore_quickfix = 1
let g:hardtime_motion_with_count_resets = 1
let g:hardtime_maxcount = 2
let g:hardtime_allow_different_key = 1
let g:hardtime_default_on = 1
let g:hardtime_ignore_quickfix = 1
" }}}

" ale {{{
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '►'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_php_phpcs_standard = '~/code/ruleset.xml'
let g:ale_php_phpmd_ruleset = 'cleancode,codesize,design,unusedcode'
" }}}

" airline {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#virtualenv#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
" }}}

" }}}

so ~/.projects.public.vim
highlight Cursor ctermfg=white ctermbg=black
filetype plugin indent on
syntax on
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
