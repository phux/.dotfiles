" Bootstrap {{{
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if &compatible
    set nocompatible
endif

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

Plug 'tpope/vim-surround'

Plug 'ap/vim-buftabline'
let g:buftabline_show = 1 " display only if more than 1 buffer open

Plug 'henrik/vim-indexed-search'

" Plug 'scrooloose/nerdtree'
Plug 'troydm/easytree.vim'
map <m-d> :bp<bar>sp<bar>bn<bar>bd<CR>

Plug 'tpope/vim-commentary', {'on': 'Commentary'}

Plug 'majutsushi/tagbar'

Plug 'itchyny/lightline.vim'

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/auto-pairs-gentle'

Plug 'amiorin/vim-project'
" Plug 'vim-addon-local-vimrc'

Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', {'on': 'Gitv'}

Plug 'tpope/vim-unimpaired'
" Plug 'moll/vim-bbye'
Plug 'Lokaltog/vim-easymotion'
" Plug 'matchit.zip'
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular', {'for': ['behat', 'cucumber']}

" Plug 'altercation/vim-colors-solarized'
" Plug 'crusoexia/vim-monokai'
Plug 'morhetz/gruvbox'
" Plug 'gko/vim-coloresque'
" Plug 'jacoborus/tender.vim'

Plug 'veloce/vim-behat', {'for': ['cucumber', 'behat']}
let g:feature_filetype='behat'
let g:behat_executables = ['vendor/bin/behat']

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}

Plug 'zhaocai/GoldenView.Vim'

" Plug 'phux/vim-phpqa', {'for': 'php'}
Plug 'neomake/neomake'
Plug 'phpstan/vim-phpstan', {'for': 'php'}
nnoremap <m-a> :PHPStanAnalyse -c phpstan.neon src<cr>

Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}


Plug 'Herzult/phpspec-vim', {'for': 'php'}
let g:phpspec_executable = 'vendor/bin/phpspec'
" Plug 'php-vim/phpcd.vim', { 'for': 'php' , 'do': 'composer install --no-dev' }
Plug 'shawncplus/phpcomplete.vim', {'for': 'php'}
" Plug 'm2mdas/phpcomplete-extended'
Plug 'Rican7/php-doc-modded', {'for': 'php'}
" Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}
Plug 'sahibalejandro/vim-php', {'for': 'php'}
Plug 'joonty/vdebug', {'for': 'php'}

" Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug '2072/PHP-Indenting-for-VIm', {'for': 'php'}
Plug 'alvan/vim-php-manual', {'for': 'php'}

Plug 'evidens/vim-twig', {'for': 'twig'}
Plug 'avakhov/vim-yaml', {'for': 'yaml'}

Plug 'phux/scratch.vim'
Plug 'vitalk/vim-simple-todo'

Plug 'fatih/vim-go', {'for':'go'}
Plug 'buoto/gotests-vim', {'for':'go'}

Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'wincent/ferret', {'on': 'Ack'}

Plug 'Shougo/echodoc.vim'

Plug 'honza/dockerfile.vim', { 'for': 'docker' }

Plug 'matze/vim-move'

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-sensible'

Plug 'vim-scripts/YankRing.vim'

Plug 'sjl/gundo.vim'
call plug#end()
" }}}

" }}}

" general {{{


" interface {{{2
set t_Co=256
" colorscheme tender
set background=dark
" colorscheme monokai
colorscheme gruvbox
" colorscheme color_1

set number
set relativenumber

" Line wrapping
set wrap
" " but don't split words
set lbr
" "show this in front of broken lines
set showbreak=↪
" Set the command window height to 1 lines
set cmdheight=1
" This makes more sense than the default of 1
set winminheight=1
" no welcome screen
set shortmess+=filmnrxoOtT
" highlight chars
set list
set listchars=tab:\ \ ,trail:•,extends:#,nbsp:. 
" Show partial commands in the last line of the screen
set showcmd

" hi Visual guifg=NONE ctermfg=255 guibg=#040404 ctermbg=203 gui=NONE
" hi SpecialKey       guifg=#343434     guibg=NONE     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE
" }}}

" find highlighting group under cursor {{{2
nnoremap <leader>0 :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}

set hidden

" no backups {{{2
set nobackup
set nowritebackup
set noswapfile
" }}}

" write on focus loss
au FocusLost * silent! update

set formatoptions+=tcqlr

" move over lines with following keys
set whichwrap+=<,>,[,],h,l

" Don't fail, ask
set confirm

" Copy to Clipboard (on Unix)
set clipboard+=unnamed

" windows {{{2
" use open windows/tabs for buffer switching
set switchbuf=useopen,usetab
" split new window at the right of current
set spr
" }}}

" indentation {{{2
set nojoinspaces
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab
" }}}

" search {{{
set smartcase
set hlsearch
" }}}

" undo {{{2
set undofile                " Save undo's after file closes
set undodir=~/.undovim " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000
" }}}

" completion {{{2
" Better command-line completion
" set wildignore+=*.pyc,*.zip,*.gz,*.bz,*.tar,*.jpg,*.png,*.gif,*.avi,*.wmv,*.ogg,*.mp3,*.mov
" set wildmode=list:longest,full
set wildmode=longest:full,full
" Limit popup menu height
set pumheight=15
set completeopt=menuone,longest
" }}}

" diff {{{2
" ignore whitespaces when vimdiff'ing
set diffopt=iwhite
set diffopt+=vertical
" }}}

" restore cursor position {{{2
au BufReadPost * call RestorePosition()
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
let g:PHP_vintage_case_default_indent = 1

" Mappings {{{
let mapleader = "\<Space>"
" Edit the vimrc file
nnoremap <silent> <leader><f5> :e $MYVIMRC<CR>

inoremap jk <esc>

" movement {{{
" map j to gj and k to gk, so line navigation ignores line wrap
nnoremap j gj
nnoremap k gk

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

nnoremap <m-w> :set nowrap!<CR>

" fast closing of html tags
inoremap ;; </<c-x><c-o>
nnoremap <m-;> :ToggleGoldenViewAutoResize<cr>

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
" window switching
noremap <silent> <c-l> <c-w>l
noremap <silent> <c-j> <c-w>j
noremap <silent> <c-k> <c-w>k
noremap <silent> <c-h> <c-w>h

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
nmap <silent> - :exe "vertical resize -15"<CR>
nmap <silent> + :exe "vertical resize +15"<CR>
" }}}

" tag navigation {{{
noremap <silent> <leader>tn :ptn<cr>
noremap <silent> <leader>tp :ptp<cr>
noremap <silent> <leader>tc :pc<cr>

nnoremap <leader>o <c-w>g}
" }}}



" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" search {{{
" unmark search matches
nnoremap <silent> ,/ :nohlsearch<CR>
nnoremap n nzzzv
nnoremap N Nzzzv
" }}}

" Refactor names easily (hit <leader>[ or <leader>] with cursor on the word you'd like to rename

nnoremap <leader>[ :%s/<c-r><c-w>/<c-r><c-w>/g<left><left>

" reformat html -> each tag on own row
nnoremap <leader><F3> :%s/<[^>]*>/\r&\r/g<cr>gg=G:g/^$/d<cr><leader>/

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>

let g:php_manual_online_search_shortcut = '<leader>m'
noremap <c-Tab> :tabnext<CR>
noremap <C-S-Tab> :tabprev<CR>

" ------
" - Mappings: Plugins
" ------


vnoremap <Enter> <Plug>(EasyAlign)


nnoremap <leader>; :TagbarToggle<cr>





"}}}


" ====================
" = Custom functions
" ====================

" FormatPHPLineLength {{{
function! FormatPHPLineLength()
    let l:currentLine = getline('.')
    normal! $
    normal! ma

    " multiple object operator split - repeatable
    let l:numOfObjectOperators = len(split(getline('.'), '->', 1)) - 1
    if l:numOfObjectOperators > 1
        s/.*->.*\zs->/\r->/g
        normal! ='a
        return
    endif

    " split params
    let l:isFunctionCall = len(split(getline('.'), '->.\+(.\+)', 1)) - 1
    echo l:isFunctionCall
    if l:isFunctionCall
->.\+(.\+)
        s/.\+->.\+(\zs\(.\+\)\()\)/\r\1\r\2/
        return
    endif


    " format array
    let l:isArray = len(split(getline('.'), '.\+\zs\[.\+\]', 1)) - 1
    echo l:isArray
    if l:isArray
        s/\(\[\)\(.\+\)\(]\)/\1\r\2\r\3
        normal! k
        if l:currentLine =~ ',\s'
            :s/,\s/,\r/g
            normal! =a[
        endif
        return
    endif

    " let l:isFunctionCallOrDefinitionOrArray = l:currentLine =~ ',' || l:currentLine =~ ';' || l:currentLine =~ ' array(' || l:currentLine =~ '(['
    " let l:isConditional = l:currentLine =~ '\s*&&' || l:currentLine =~ ' and ' || l:currentLine =~ '\s*||' || l:currentLine =~ ' or ' || l:currentLine =~ '\s*?'

    " if l:isConditional
    "     normal! F)
    " elseif l:isFunctionCallOrDefinitionOrArray
    "     let l:isFunctionCall = 0
    "     if l:currentLine =~ ';'
    "         let l:isFunctionCall = 1
    "         normal! h
    "     else
    "         normal! Jh
    "     endif
    " endif

    " execute "normal! i\n"
    " normal! mb
    " normal! k

    " if l:isConditional
    "     :s/\(\s*&&\| and \|\s*||\| or \| ?\| :\)/\r\1/g
    " elseif l:isFunctionCallOrDefinitionOrArray

    "     " go into original line and split until last function call
    "     " execute "normal! 0f=f>hi\n"
    "     execute "normal! 0f(a\n"
    "     if l:currentLine =~ ','
    "         :s/,\s/,\r/g
    "     endif
    " endif
    " 'b
    " normal! V
    " 'a
    " normal! =
endfunction

nnoremap <leader>i :call FormatPHPLineLength()<cr>
" }}}


" QFix toggle {{{
" toggles the quickfix window.
map <leader>q :QFix<cr>
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
augroup QFixToggle
    autocmd!
    autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
    autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END

function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
    else
        execute "copen " . g:jah_Quickfix_Win_Height
    endif
endfunction

let g:jah_Quickfix_Win_Height=10
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
    exe "normal I".l:ticketNumber
    exe "normal gg"
    :startinsert!
endfunction
augroup git_commit
    autocmd!
    " au BufEnter * if &ft ==# 'gitcommit' | :call PrependTicketNumber() | endif
    autocmd FileType gitcommit nnoremap <buffer> <leader>w :call PrependTicketNumber()<cr>
augroup END
" }}}


nnoremap <leader>w :w<cr>

nnoremap <leader>W :w<cr>:silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &<cr>

" performance settings {{{
set nocursorcolumn       " do not highlight column
set nocursorline         " do not highlight line
" syntax sync minlines=256 " start highlighting from 256 lines backwards
" set synmaxcol=150        " do not highlith very long lines
set lazyredraw
set scrolljump=5
set sidescroll=1
let g:PHP_default_indenting=0
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

" nnoremap <leader>rip :Ack input('Replace '.expand('<cword>').' with: ', expand('<cword>'))<CR>


" filetype settings {{{
filetype on
filetype plugin indent on
syntax on

augroup filetype_settings
    autocmd!
    au BufNewFile,BufRead *.feature set ft=behat
    au FileType behat,cucumber setl sw=2 sts=2 et
    au FileType yaml setl sw=2 sts=2 et
    au FileType ruby setl sw=2 sts=2 et

    " au FileType vim setl foldenable fdm=marker fmr={{{,}}} fdl=0
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
    autocmd FileType make setlocal noexpandtab tabstop=4 shiftwidth=4 

    autocmd BufRead,BufNewFile *.conf setf config

    au BufNewFile,BufRead *.phtml set ft=php.html

    autocmd filetype qf setlocal wrap
augroup END


augroup filetype_omnifuncs
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END


" linters {{{
augroup linterConfiguration
    autocmd!
    autocmd FileType xml   setlocal makeprg=xmllint\ -
    autocmd FileType xml   setlocal equalprg=xmllint\ --format\ -
    autocmd FileType html  setlocal equalprg=tidy\ -q\ -i\ -w\ 80\ -utf8\ --quote-nbsp\ no\ --output-xhtml\ yes\ --show-warnings\ no\ --show-body-only\ auto\ --tidy-mark\ no\ -
    autocmd FileType xhtml setlocal equalprg=tidy\ -q\ -i\ -w\ 80\ -utf8\ --quote-nbsp\ no\ --output-xhtml\ yes\ --show-warnings\ no\ --show-body-only\ auto\ --tidy-mark\ no\ -
    autocmd FileType json  setlocal equalprg=python\ -mjson.tool
    autocmd Filetype php nnoremap <buffer> <leader>w :update<cr>:silent call PhpSyntaxCheck()<cr>
augroup END
" }}}

augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END



" help {{{
augroup help_settings
    autocmd!
    autocmd filetype help nnoremap <buffer> <CR> <c-]>
    autocmd filetype help nnoremap <buffer> <bs> <c-T>
    autocmd filetype help nnoremap <buffer> q :q<CR>
    autocmd filetype help set nonumber
augroup END
" }}}
" }}}

" override phpdoc syntax highlighting {{{
function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction

" augroup phpSyntaxOverride
"   autocmd!
"   autocmd FileType php call PhpSyntaxOverride()
" augroup END
" }}}

" PhpSyntaxCheck {{{
function! PhpSyntaxCheck()
    sil! setlocal makeprg=php\ -l\ %
    sil! setlocal errorformat=%m\ in\ %f\ on\ line\ %l,%-GErrors\ parsing\ %f,%-G
    sil! make
    redraw!
    cw
endfunction
" }}}

noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz


command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

nnoremap <silent> <leader>tu :call SwitchBetweenFiles1('php', 'Bundle/Tests/', 'Bundle/', 'Test')<cr>
nnoremap <silent> <leader>tsu <c-w>v:call SwitchBetweenFiles1('php', 'Bundle/Tests/', 'Bundle/', 'Test')<cr>


hi Search cterm=NONE ctermfg=white ctermbg=130
set autoread



" }}}

" plugin settings {{{
" NERDTree {{{2
" nnoremap <leader>N :NERDTreeFind<cr>
nnoremap <leader>N :let @a = expand("%:t")<cr>:EasyTree %:p:h<cr>/<c-r>a<cr>:set nohls<cr>

" nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>n :EasyTreeToggle<cr>

let g:NERDTreeMinimalUI = 1
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeWinSize = 31
let g:NERDTreeChDirMode = 2
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeShowBookmarks = 0
let g:NERDTreeCascadeOpenSingleChildDir = 1
" }}}

" lightline.vim {{{2
let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], [ 'tagbar' ] ],
            \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component': {
            \         'tagbar': '%{tagbar#currenttag("%s", "", "f")}',
            \ },
            \ 'component_function': {
            \   'fugitive': 'LightlineFugitive',
            \   'filename': 'LightlineFilename',
            \   'fileformat': 'LightlineFileformat',
            \   'filetype': 'LightlineFiletype',
            \   'fileencoding': 'LightlineFileencoding',
            \   'mode': 'LightlineMode',
            \ },
            \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
            \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
            \ }


function! LightlineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
    let fname = expand('%')
    return fname =~ '__Gundo\|easytree' ? '' :
                \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
                \ ('' != fname ? fname : '[No Name]') .
                \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
    " return  fname == '__Tagbar__' ? g:lightline.fname :
    "             \ fname =~ '__Gundo\|NERD_tree' ? '' :
    "             \ fname =~ '__Gundo\|easytree' ? '' :
    "             \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
    "             \ &ft == 'unite' ? unite#get_status_string() :
    "             \ &ft == 'vimshell' ? vimshell#get_status_string() :
    "             \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
    "             \ ('' != fname ? fname : '[No Name]') .
    "             \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
    try
        " if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && exists('*fugitive#head')
        if expand('%:t') !~? 'Tagbar\|Gundo\|easytree' && exists('*fugitive#head')
            let mark = ''  " edit here for cool mark
            let branch = fugitive#head()
            return branch !=# '' ? mark.branch : ''
        endif
    catch
    endtry
    return ''
endfunction

function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return &ft == 'help' ? 'help' :
        \ &ft == 'undotree' ? 'undotree' :
        \ &ft == 'fzf' ? 'fzf' :
        \ &ft == 'vim-plug' ? 'plugin' :
        \ &ft == 'qf' ? 'quickfix' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" function! LightlineMode()
"     let fname = expand('%:t')
"     return fname == '__Tagbar__' ? 'Tagbar' :
"                 \ fname == '__Gundo__' ? 'Gundo' :
"                 \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
"                 \ fname =~ 'NERD_tree' ? 'NERDTree' :
"                 \ &ft == 'unite' ? 'Unite' :
"                 \ &ft == 'vimfiler' ? 'VimFiler' :
"                 \ &ft == 'vimshell' ? 'VimShell' :
"                 \ winwidth(0) > 60 ? lightline#mode() : ''
" endfunction
" }}}

" ultisnips {{{2
let g:ultisnips_php_scalar_types = 1
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips/'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

au BufNewFile,BufRead,BufWinEnter *Test.php exe ":UltiSnipsAddFiletypes php.phpunit"
au BufNewFile,BufRead,BufWinEnter *Spec.php exe ":UltiSnipsAddFiletypes php.php-phpspec"
" }}}

" echodoc {{{2
let g:echodoc_enable_at_startup=1
set noshowmode
" }}}

" fzf {{{2
let g:fzf_layout = { 'down': '~40%' }

" [Files] Extra options for fzf
"   e.g. File preview using Highlight
"        (http://www.andre-simon.de/doku/highlight/en/highlight.html)
" let g:fzf_files_options =
"   \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

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
        echohl WarningMsg
        echom 'Preparing tags'
        echohl None
        silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
    endif

    call fzf#run({
                \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
                \            '| grep -v -a ^!',
                \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
                \ 'down':    '40%',
                \ 'sink':    function('s:tags_sink')})
endfunction

command! Tags call s:tags()

vnoremap // "hy:exec "Ag ".escape('<C-R>h', "/\.*$^~[()")<cr>

nnoremap <leader><Enter> :History<cr>
nnoremap <leader>a :Ag<space>
nnoremap <leader>A :exec "Ag ".expand("<cword>")<cr>

nnoremap <leader>s :Tags<cr>
nnoremap <leader>, :Files<cr>
" }}}

" auto-pairs {{{2
let g:AutoPairsFlyMode = 0
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
" nnoremap <leader>gb :Gbrowse<cr>
nnoremap <leader>gp :!git push<cr>
" }}}

" gitv {{{2
nnoremap <leader>gv :Gitv!<cr>
nnoremap <leader>gV :Gitv<cr>
" }}}

" vim-phpqa {{{2
" au BufWinEnter,BufEnter *.php nnoremap <buffer> <leader>w :let g:phpqa_messdetector_autorun = 0<cr>:let g:phpqa_codesniffer_autorun = 0<cr>:w<cr>:let g:phpqa_messdetector_autorun = 1<cr>:let g:phpqa_codesniffer_autorun = 1<cr>
" let g:phpqa_messdetector_ruleset = "~/.config/phpmd-ruleset.xml"

" let g:phpqa_codesniffer_args = "--standard=Symfony3Custom"
" let g:php_cs_fixer_php_path = "php"


" }}}


" php-refactoring-toolbox {{{2
let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"

let g:vim_php_refactoring_use_default_mapping = 0
nnoremap <leader>rrv :call PhpRenameLocalVariable()<CR>
nnoremap <leader>rrp :call PhpRenameClassVariable()<CR>
nnoremap <leader>rrm :call PhpRenameMethod()<CR>
nnoremap <leader>reu :call PhpExtractUse()<CR>
vnoremap <leader>rec :call PhpExtractConst()<CR>
nnoremap <leader>rep :call PhpExtractClassProperty()<CR>
vnoremap <leader>rem :call PhpExtractMethod()<CR>
nnoremap <leader>rcp :call PhpCreateProperty()<CR>
nnoremap <leader>rdu :call PhpDetectUnusedUseStatements()<CR>
vnoremap <leader>r== :call PhpAlignAssigns()<CR>
nnoremap <leader>rsg :call PhpCreateSettersAndGetters()<CR>
" }}}

" phpcomplete {{{2
let g:phpcomplete_complete_for_unknown_classes = 0
let g:phpcomplete_relax_static_constraint=0
let g:phpcomplete_search_tags_for_variables = 1
let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_enhance_jump_to_definition = 1

augroup phpcomplete_autogroup
    autocmd!
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
augroup END
" }}}

" deoplete {{{2
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#syntax#min_keyword_length = 2
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
" let g:deoplete#disable_auto_complete = 1
let g:deoplete#auto_refresh_delay = 100
let g:deoplete#tag#cache_limit_size = 50000000
let g:deoplete#enable_auto_delimiter = 1
let g:deoplete#max_list = 10
let g:deoplete#auto_complete_delay= 50
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'
let g:deoplete#omni_patterns = {}
let g:deoplete#sources = {}
let g:deoplete#sources._=['omni', 'buffer', 'member', 'tag', 'ultisnips', 'file']
let g:deoplete#omni_patterns.php =
            \ '$\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
let g:deoplete#omni_patterns.behat = '[^. \t]\(When\|Then\|Given\|And\)\s.*$'


call deoplete#custom#set('_',
            \ 'disabled_syntaxes', ['Comment', 'String'])

" au BufNewFile,BufRead,BufWinEnter *Test.php exe ":let g:deoplete#omni_patterns.php = '[^. \\t]->\\w*|\\w+::\\w*'"
" au BufNewFile,BufRead,BufWinEnter *Test.php exe ":let b:deoplete#sources = {} | :let b:deoplete#sources.php = ['buffer']"
" au BufWinLeave,BufLeave *Test.php exe ':let g:deoplete#omni_patterns.php = "\\h\\w*\\|[^. \\t]->\\%(\\h\\w*\\)\\?\\|\\h\\w*::\\%(\\h\\w*\\)\\?"'
augroup test_completion_fix
    autocmd!
    au BufNewFile,BufRead,BufWinEnter *Test.php exe ":let g:phpcomplete_search_tags_for_variables = 0 | :let g:phpcomplete_parse_docblock_comments = 0"
    au BufWinLeave,BufLeave *Test.php exe ":let g:phpcomplete_search_tags_for_variables = 1 | :let g:phpcomplete_parse_docblock_comments = 1"

    au BufNewFile,BufRead,BufWinEnter *Test.php exe ":let g:deoplete#omni_patterns.php = '[^. \\t]->\\w*|\\w+::\\w*'"
    au BufWinLeave,BufLeave *Test.php exe ':let g:deoplete#omni_patterns.php = "\$\\h\\w*\\|[^. \\t]->\\%(\\h\\w*\\)\\?\\|\\h\\w*::\\%(\\h\\w*\\)\\?"'
augroup END
" }}}

" phpdoc {{{2
let g:pdv_cfg_autoEndClass = 0
let g:pdv_cfg_php4always = 0
let g:pdv_cfg_autoEndFunction = 0
let g:pdv_cfg_FunctionName = 0
let g:pdv_cfg_Type = ""
inoremap <C-d> <ESC>:call PhpDocSingle()<CR>
nnoremap <leader>h :call PhpDocSingle()<CR>
vnoremap <leader>h :call PhpDocRange()<CR>
" }}}

" php-namespace {{{2
let g:php_namespace_sort_after_insert = 1
noremap <leader>u :call PhpInsertUse()<CR>
noremap <leader>e :call PhpExpandClass()<CR>

augroup VIM_PHP
    autocmd!
    autocmd FileType php nnoremap <Leader>u :PHPImportClass<cr>
    autocmd FileType php nnoremap <Leader>e :PHPExpandFQCNAbsolute<cr>
    autocmd FileType php nnoremap <Leader>E :PHPExpandFQCN<cr>
augroup END
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

" simple-todo {{{2
let g:simple_todo_map_keys = 0
nnoremap ,i <Plug>(simple-todo-new)
inoremap ,i <Plug>(simple-todo-new)
nnoremap ,I <Plug>(simple-todo-new-start-of-line)
inoremap ,I <Plug>(simple-todo-new-start-of-line)
nnoremap ,o <Plug>(simple-todo-below)
inoremap ,o <Plug>(simple-todo-below)
nnoremap ,O <Plug>(simple-todo-above)
inoremap ,O <Plug>(simple-todo-above)
nnoremap ,x <Plug>(simple-todo-mark-as-done)
inoremap ,x <Plug>(simple-todo-mark-as-done)
nnoremap ,X <Plug>(simple-todo-mark-as-undone)
inoremap ,X <Plug>(simple-todo-mark-as-undone)
nnoremap ,s <Plug>(simple-todo-new-list-item)
inoremap ,s <Plug>(simple-todo-new-list-item)
" }}}

" scratch {{{2
nnoremap <leader>z :Scratch<cr>
let g:scratch_top = 1
let g:scratch_persistence_file = '.scratch.vim'
" }}}

" vim-go {{{2
au FileType go nnoremap <leader>gf :GoCoverageToggle<cr>
au FileType go nnoremap <leader>gr <Plug>(go-run)
au FileType go nnoremap <leader>gb <Plug>(go-build)
au FileType go nnoremap <leader>gt <Plug>(go-test)
au FileType go nnoremap <leader>gd <Plug>(go-doc)
au FileType go nnoremap <leader>gs <Plug>(go-implements)
au FileType go nnoremap <leader>ge <Plug>(go-rename)
let g:go_list_type = "location"

au BufNewFile,BufRead,BufWinEnter *.go nnoremap <buffer> <leader>w :GoFmt<cr>

let g:go_bin_path = expand("~/.gvm/gos/go1.8/bin")
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 0
" }}}

" goldenview {{{2
let g:goldenview__enable_default_mapping = 0
nmap <silent> <C-g>  <Plug>GoldenViewSplit
" 2. quickly switch current window with the main pane
" and toggle back
nnoremap <silent> <F8>   <Plug>GoldenViewSwitchMain
nnoremap <silent> <F9> <Plug>GoldenViewSwitchToggle
" }}}

" ferret {{{2
function! LoadQuickfixBinds()
    nnoremap <c-n> :cn<cr>
    nnoremap <c-p> :cp<cr>
endfunction

augroup QFIX
    autocmd!
    autocmd BufWinEnter quickfix call LoadQuickfixBinds()
augroup END
function! LoadLocationlistBinds()
    nnoremap <C-n> :lne<CR>
    nnoremap <C-p> :lpre<CR>
endfunction
nnoremap <C-n> :lne<CR>
nnoremap <C-p> :lpre<CR>
nnoremap <leader>rip :call LoadQuickfixBinds()<cr>:Acks /<c-r><c-w>/<c-r><c-w>/gc<left><left>
nnoremap <leader>/ :call LoadQuickfixBinds()<cr>:Ack <c-r><c-w><cr>
nnoremap ,, :call LoadLocationlistBinds()<cr>
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

" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
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

" YankRing.vim {{{
nnoremap <m-y> :YRShow<CR>
let g:yankring_replace_n_pkey = '<m-p>'
let g:yankring_replace_n_nkey = '<m-n>'
" }}}

" neomake {{{
augroup NEOMAKE
    autocmd!
    autocmd BufWritePost * Neomake
augroup end

let g:neomake_php_enabled_makers = ['phpcs', 'phpmd']
let g:neomake_yaml_enabled_makers = ['yamllint']
let g:neomake_json_enabled_makers = ['jsonlint']
let g:neomake_markdown_enabled_makers = ['mdl']
let g:neomake_sh_enabled_makers = ['sh', 'shellcheck']
" }}}
" }}}

so ~/.projects.public.vim
