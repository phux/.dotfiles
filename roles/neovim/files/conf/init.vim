" vint: -ProhibitCommandRelyOnUser
" vint: -ProhibitCommandWithUnintendedSideEffect

if has('vim_starting')
  let g:qf_loc_toggle_binds = 0
  set nofoldenable
  set foldtext=MyFoldText()
endif

set encoding=UTF-8
scriptencoding utf-8

let mapleader = "\<Space>"

" i am too stoopid to learn this
nnoremap Q <nop>

""""""""""""""
"  vim-plug  "
""""""""""""""
"" install vim-plug if not exists
if !filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo 'Installing vim-plug and plugins. Restart nvim after finishing the process.'
    silent call mkdir(expand('~/.config/nvim/autoload', 1), 'p')
    execute '!curl -fLo '.expand('~/.config/nvim/autoload/plug.vim', 1).' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    autocmd FirstStartup VimEnter * PlugInstall
endif
command! PU PlugUpdate | PlugUpgrade

call plug#begin('~/.config/nvim/plugged')
"" snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips/'
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsEditSplit='vertical'

let g:AutoPairsMapSpace = 0
let g:AutoPairsShortcutToggle = '<s-f12>'
Plug 'jiangmiao/auto-pairs'

"" plantuml
" Plug 'scrooloose/vim-slumlord', {'for': ['uml', 'markdown']}
Plug 'aklt/plantuml-syntax', {'for': 'uml'}

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'Shougo/neco-vim', {'for': 'vim'}
" Plug 'neoclide/coc-neco', {'for': 'vim'}

"" php
Plug 'phux/php-doc-modded', {'for': 'php'}
Plug 'sahibalejandro/vim-php', {'for': ['php', 'yaml']}
Plug 'alvan/vim-php-manual', {'for': 'php'}
let g:vim_php_refactoring_use_default_mapping = 0
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'phpactor/phpactor', {'for': 'php', 'do': ':call phpactor#Update()'}

Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }

"" go

Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'sebdah/vim-delve', {'for': 'go'}
Plug 'godoctor/godoctor.vim', {'for': 'go'}
Plug 'buoto/gotests-vim', {'for': 'go'}

"" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tweekmonster/fzf-filemru'
Plug 'zackhsi/fzf-tags'

"" UI
Plug 'itchyny/lightline.vim'
Plug 'simeji/winresizer', {'on': 'WinResizerStartResize'}
" Plug 'dhruvasagar/vim-zoom'
let g:echodoc_enable_at_startup=1
" default nord color lets not identify current argument
let g:echodoc#highlight_arguments = 'SpellCap'
Plug 'Shougo/echodoc.vim'
let g:buftabline_show = 1 " display only if more than 1 buffer open
Plug 'ap/vim-buftabline'

Plug 'NLKNguyen/papercolor-theme'
Plug 'cormacrelf/vim-colors-github'
Plug 'arcticicestudio/nord-vim'
Plug 'etdev/vim-hexcolor', {'for': ['css']}
" Plug 'morhetz/gruvbox'

" Plug 'liuchengxu/vista.vim', {'on': 'Vista'}
" let g:vista_icon_indent = ["▸ ", ""]
" let g:vista_cursor_delay=0
" let g:vista_echo_cursor_strategy='floating_win'
" let g:vista_blink=[]


"" markdown
Plug 'reedes/vim-lexical', {'for': ['text', 'markdown', 'gitcommit']}
let g:mkdp_path_to_chrome = 'chromium-browser'
Plug 'iamcco/markdown-preview.nvim', { 'for': ['markdown'],  'do': 'cd app & yarn install'  }
let g:mkdp_auto_close = 0
Plug 'junegunn/goyo.vim', {'for': 'markdown'}
Plug 'plasticboy/vim-markdown', {'for': ['markdown'], 'as': 'vim-markdown-plasticboy'}
Plug 'tenfyzhong/tagbar-markdown.vim', {'for': 'markdown'}
Plug 'Rykka/InstantRst', {'for': 'rst'}
let g:instant_rst_browser='chromium-browser'
Plug 'tpope/vim-markdown'

"" search/navigate

" smart search highligting
let g:CoolTotalMatches = 1
Plug 'romainl/vim-cool'

Plug 'wellle/targets.vim'

" quickfix improvements
Plug 'romainl/vim-qf'

Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

""" easymotion
Plug 'Lokaltog/vim-easymotion'
" nmap <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>f <Plug>(easymotion-bd-w)
nmap <Leader>F <Plug>(easymotion-overwin-w)
" nmap s <Plug>(easymotion-s)
" nmap  <Leader>b <Plug>(easymotion-b)

let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1 " US layout

""" nerdtree
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
let g:NERDTreeUpdateOnCursorHold = 0
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeWinSize = 40
let g:NERDTreeMinimalUI=1
let g:NERDTreeCascadeSingleChildDir=0
let g:NERDTreeAutoDeleteBuffer=1
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>N :NERDTreeFind<cr>

""" tmux

Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'

Plug 'wellle/tmux-complete.vim'


""" ferret
let g:FerretHlsearch=1
Plug 'wincent/ferret', {'on': 'Ack'}
nnoremap <leader>/ :Ack <c-r><c-w><cr>
nnoremap <leader>rip :Acks /<c-r><c-w>/<c-r><c-w>/gc<left><left><left>

"" git
Plug 'gregsexton/gitv', {'on': 'Gitv'}

" Plug 'airblade/vim-gitgutter'

""" fugitive
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gS :Gstatus<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit -v<cr>
nnoremap <leader>gL :Glog<cr>
vnoremap <leader>gl :Glog<cr>
nnoremap <leader>gd :Gdiff<cr>

Plug 'lambdalisue/vim-improve-diff'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'whiteinge/diffconflicts'

"" notes
Plug 'xolox/vim-notes', {'on': ['SearchNotes', 'Note', 'RecentNotes']} | Plug 'xolox/vim-misc'
let g:notes_directories = ['~/Dropbox/notes']
let g:notes_suffix = '.md'
let g:notes_smart_quotes = 0
Plug 'mtth/scratch.vim', {'on' : 'ScratchPreview'}
let g:scratch_persistence_file = '.scratch.vim'
nnoremap <m-z> :Scratch<cr>
nnoremap <leader>z :ScratchPreview<cr>

"" todo

let g:simple_todo_map_keys = 0
let g:simple_todo_list_symbol = '*'
Plug 'vitalk/vim-simple-todo'
nmap <silent> <m-i> :s/* //<cr><Plug>(simple-todo-new-list-item-start-of-line)
imap <m-i> <Plug>(simple-todo-new-list-item-start-of-line)
nmap <m-o> <Plug>(simple-todo-below)
imap <m-o> <Plug>(simple-todo-below)
imap <m-space> <Plug>(simple-todo-mark-switch)
nmap <m-space> <Plug>(simple-todo-mark-switch)

""" todo.txt
Plug 'dbeniamine/todo.txt-vim', {'for': 'text'}

"" filetype
" Set the 'path' option for miscellaneous file types
Plug 'tpope/vim-apathy'
Plug 'stephpy/vim-yaml', {'for': 'yaml'}

" let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
Plug 'nathanaelkane/vim-indent-guides', {'for': ['yaml', 'markdown']}
" Plug 'elzr/vim-json', {'for': 'json'}
Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; python2 generate.py', 'for': 'yaml'}
let g:ansible_unindent_after_newline = 1

"" misc
Plug 'amiorin/vim-project'

Plug 'godlygeek/tabular', {'for': ['cucumber', 'markdown']}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'

" Plug 'triglav/vim-visual-increment'

""" gundo
" nnoremap <m-u> :MundoToggle<CR>
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
let g:mundo_width = 100

""" vim-test
Plug 'janko-m/vim-test', {'on': ['TestNearest', 'TestFile', 'TestLast', 'TestVisit']}
nnoremap <leader>tn :TestNearest<cr>
nnoremap <leader>tf :TestFile<cr>
nnoremap <silent> <leader>tl :TestLast<CR>
nnoremap <silent> <leader>tv :TestVisit<CR>
let test#strategy='neovim'

""" SplitJoin
Plug 'AndrewRadev/splitjoin.vim', {'on': ['SplitjoinSplit', 'SplitjoinJoin']}
nnoremap <leader>j :SplitjoinSplit<cr>
nnoremap <leader>k :SplitjoinJoin<cr>

""" commentary
Plug 'tpope/vim-commentary', {'on': 'Commentary'}
nnoremap <leader>c :Commentary<cr>
vnoremap <leader>c :Commentary<cr>

let g:ale_lint_on_enter=0
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_insert_leave=0
let g:ale_disable_lsp=1
let g:ale_open_list = 0
let g:ale_fix_on_save = 1
Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'
" Plug 'neomake/neomake'

Plug 'ajorgensen/vim-markdown-toc', {'for': 'markdown'}
Plug 'davidbalbert/vim-io', {'for': 'io'}
Plug 'adimit/prolog.vim', {'for': 'prolog'}
Plug 'derekwyatt/vim-scala', {'for': 'scala'}
call plug#end()

" call neomake#configure#automake('w')
" let g:neomake_echo_current_error=0
" let g:neomake_open_list = 2

""""""""""""""""""""""""
"  Autogroups  "
""""""""""""""""""""""""

"" Misc
augroup misc
  au!

  " autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=none   ctermbg=none
  " autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=0

  au BufNewFile,BufRead *.yml.dist set ft=yaml
  au BufRead,BufNewFile *.conf setf config
  au BufNewFile,BufRead composer.lock set ft=json

  au BufRead,BufNewFile *.sbt set filetype=scala

  au BufNewFile,BufRead,BufEnter ~/Dropbox/notes/*.md set ft=markdown.notes

  au FileType html,xml inoremap <buffer> <m-;> </<c-x><c-o>
  " au FileType html setlocal equalprg=tidy\ -indent\ -quiet\ --show-errors\ 0\ --tidy-mark\ no\ --show-body-only\ auto
  au FileType xml setlocal makeprg=xmllint\ -

  au FileType gitv nmap <buffer> <silent> <C-n> <Plug>(gitv-previous-commit)
  au FileType gitv nmap <buffer> <silent> <C-p> <Plug>(gitv-next-commit)

  " au FocusLost,WinLeave * :silent! update
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0
        \| autocmd BufLeave <buffer> set laststatus=2
  au BufWritePost *.go silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
augroup END

"" Nvim
augroup nvim
  au!
  au BufWritePost *.vim nested source $MYVIMRC
  " au CursorHold * checktime
  autocmd VimResized * wincmd =
augroup END

nnoremap <c-e> :WinResizerStartResize<cr>

""""""""""""""
"  Settings  "
""""""""""""""

set fileformats=unix,dos,mac
set autowriteall                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set hidden
set nojoinspaces

"" insert mode completion
set complete-=i
set complete+=w
set completeopt-=preview

"" better command mode completion
set wildmenu
" set wildmode=list:longest,full
" set wildmode=list

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

"" no backups
set nobackup
set nowritebackup
set noswapfile

"" undo
set undofile " Maintain undo history between vim sessions
set undodir=~/.vim_undodir

"" history
" set history=10000

"" UI settings
set number
set relativenumber

" Set the command window height to 1 lines
set cmdheight=1
" This makes more sense than the default of 1
set winminheight=1

set formatoptions=qrn1tclj

set showbreak=↪
" set breakindent
set breakindentopt=sbr

" do not continue comment using o or O
set formatoptions-=o

" Line wrapping
set wrap
" but don't split words
set linebreak

" move over lines with following keys
set whichwrap+=<,>,[,],h,l

" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c
set diffopt=vertical,filler

let g:lexical#thesaurus = ['~/.config/nvim/thesaurus.txt',]
let spellfile='~/.vim.spell'

""" colors
set t_Co=256
set background=dark


let g:lightline = {
            \ 'colorscheme': 'nord',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'coc_state', 'linter_checking', 'linter_errors', 'linter_warnings' ] ]
            \ },
            \ 'inactive': {
            \   'left': [ [ 'conflicted_name'], [ 'filename' ] ],
            \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
            \ },
            \ 'component_function': {
            \   'filename': 'LightlineFilename',
            \   'gitbranch': 'CocGitStatus',
            \   'conflicted_name': 'ConflictedVersion',
            \   'coc_state': 'coc#status'
            \ },
            \ }


let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

function! Bright()
    set background=light
    color PaperColor
    let g:lightline['colorscheme'] = 'default'
endfunction

function! Bright2()
    set background=light
    color github
    let g:lightline['colorscheme'] = 'github'
endfunction

if $TERM_COLOR ==# 'papercolor'
    call Bright()
else
    color nord
endif

function! CocGitStatus()
  let gstatus = get(g:,'coc_git_status','')
  if len(gstatus) == 0
    return ''
  endif
  return get(g:,'coc_git_status','').get(b:,'coc_git_status','')
endfunction

function! LightlineFilename()
  return @% !=# '' ? @% : '[No Name]'
endfunction
""""""""""""""
"  Mappings  "
""""""""""""""

"" pasting
" Copy to Clipboard (on Unix)
vnoremap y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
vnoremap <leader>d "+d
vnoremap <silent> y y`]

"" tmux
if !exists('$TMUX')
  nnoremap <c-j> <c-w>j
  nnoremap <c-k> <c-w>k
  nnoremap <c-h> <c-w>h
  nnoremap <c-l> <c-w>l
endif

"" FZF
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

nnoremap <leader><tab> :Buffers<cr>
nnoremap <leader>, :FilesMru<cr>
nnoremap <leader>. :FZFAllFiles<cr>

nnoremap <leader>T :Tags<cr>
nnoremap <leader>; :TagbarToggle<cr>

nnoremap <leader>a :Rg<space>
nnoremap <leader>A :exec "Rg ".expand("<cword>")<cr>
nnoremap <m-r> :exec "Rg ".expand("<cword>")<cr>
vnoremap // "hy:exec "Find ".escape('<C-R>h', "/\.*$^~[()")<cr>
nnoremap <m-s-r> :exec "Find ".expand("<cword>")<cr>

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case  --colors "match:bg:yellow" --colors "match:fg:black" --colors "match:style:nobold" --colors "path:fg:green" --colors "path:style:bold" --colors "line:fg:yellow" --colors "line:style:bold" '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --no-ignore --hidden --smart-case  --color=always --colors "match:bg:yellow" --colors "match:fg:black" --colors "match:style:nobold" --colors "path:fg:green" --colors "path:style:bold" --colors "line:fg:yellow" --colors "line:style:bold" --glob "!.git/*" '.shellescape(<q-args>), 1, <bang>0)

set grepprg=rg\ --vimgrep

command! -bang -nargs=* FZFAllFiles call fzf#run({'source': 'find * -type f', 'sink': 'e'})

"" vim-project
let g:project_use_nerdtree = 0
let g:project_enable_welcome = 0
nnoremap <F1> :e ~/.config/nvim/projects.public.vim<cr>
nnoremap <leader><F2> :e ~/.projects.private.vim<cr>
set runtimepath+=~/.config/nvim/plugged/vim-project/
call project#rc('~/code')

"" vim-abolish
nnoremap <leader>] :%Subvert/<c-R><c-w>/<c-r><c-w>/g<left><left>
nnoremap <leader>[ :Subvert/<c-R><c-w>/<c-r><c-w>/g<left><left>
vnoremap <leader>] :Subvert//g<left><left>

"" qf/loc list toggle
nmap <c-p> <Plug>(qf_loc_previous)
nmap <c-n> <Plug>(qf_loc_next)
let g:qf_loc_toggle_binds = 0
function! ToggleQfLocListBinds()
  if g:qf_loc_toggle_binds == 1
    nmap <c-p> <Plug>(qf_loc_previous)
    nmap <c-n> <Plug>(qf_loc_next)
    let g:qf_loc_toggle_binds = 0
    echo 'loc binds loaded'
  else
    let g:qf_loc_toggle_binds = 1
    nmap <c-p> <Plug>(qf_qf_previous)
    nmap <c-n> <Plug>(qf_qf_next)
    echo 'qf binds loaded'
  endif
endfunction
nmap <m-t> :call ToggleQfLocListBinds()<cr>

"" gitv
nnoremap <leader>gv :Gitv!<cr>
vnoremap <leader>gv :Gitv!<cr>
nnoremap <leader>gV :Gitv<cr>
let g:Gitv_DoNotMapCtrlKey = 1

"" tabular
nnoremap <leader>ga :Tabularize /\|<cr>
vnoremap <leader>ga :Tabularize /\|<cr>
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

"" cmode terminal like mappings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

"" switch between files
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
  let f = bufname('%')
  if f =~ '.'.a:fileExtension
    if f =~ '\<'.a:firstDirBeginning && f =~ a:filenameAddition.'\.'.a:fileExtension
      let filename = substitute(substitute(f, a:firstDirBeginning, '', ''), a:filenameAddition, '', '')
      if !filereadable(filename)
        let new_dir = substitute(filename, '/\w\+\.'.a:fileExtension, '', '')
        exe ':!mkdir -p '.new_dir
      endif
      exe ':e '.filename
    elseif f =~ '\<'.a:secondDirBeginning && f !~ a:filenameAddition.'\.'.a:fileExtension
      let filename = substitute(substitute(f, a:secondDirBeginning, a:firstDirBeginning.a:secondDirBeginning, ''), '.'.a:fileExtension, a:filenameAddition.'.'.a:fileExtension, '')
      if !filereadable(filename)
        let new_dir = substitute(filename, '/\w\+'.a:filenameAddition.'\.'.a:fileExtension, '', '')
        exe ':!mkdir -p '.new_dir
      endif
      exe ':e '.filename
    else
      echom 'Could not switch because needed patterns not matched.'
    endif
  endif
endfunction

"" edit ft plugin files
function! EditFtPluginFile(ft)
  exec ':e ~/.dotfiles/roles/neovim/files/ftplugin/'.a:ft.'.vim'
endfunction
nnoremap <F4> :call EditFtPluginFile(&filetype)<cr>
nnoremap <F3> :call EditFtPluginFile('')<left><left>

"" Light color scheme
function! LightScheme()
  set background=light
  color github
  set cursorline
endfunction

"""""""""""""
"  Folding  "
"""""""""""""
"" Settings
set nofoldenable
" set foldmethod=marker
let g:xml_syntax_folding = 1
let g:sh_fold_enabled= 7
let g:ruby_fold = 1
" set foldlevel=1
set foldnestmax=4
set foldlevelstart=99

"" Mappings
" "Refocus" folds
" nnoremap <leader>z zMzvzz
"" Custom folding text
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &foldcolumn + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let chunks = split(line, "\t", 1)
    let line = join(map(chunks[:-2], 'v:val . repeat(" ", &tabstop - strwidth(v:val) % &tabstop)'), '') . chunks[-1]

    let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 1
    return line . '...' . repeat(' ', fillcharcount) . foldedlinecount . ' '
endfunction

if has('vim_starting')
  let g:qf_loc_toggle_binds = 0
  set nofoldenable
  set foldtext=MyFoldText()
endif

"" Autofolding .vimrc
" see http://vimcasts.org/episodes/writing-a-custom-fold-expression/
""" defines a foldlevel for each line of code
function! VimFolds(lnum)
  let s:thisline = getline(a:lnum)
  if match(s:thisline, '^"" ') >= 0
    return '>2'
  endif
  if match(s:thisline, '^""" ') >= 0
    return '>3'
  endif
  let s:two_following_lines = 0
  if line(a:lnum) + 2 <= line('$')
    let s:line_1_after = getline(a:lnum+1)
    let s:line_2_after = getline(a:lnum+2)
    let s:two_following_lines = 1
  endif
  if !s:two_following_lines
      return '='
    " endif
  else
    if (match(s:thisline, '^"""""') >= 0) &&
       \ (match(s:line_1_after, '^"  ') >= 0) &&
       \ (match(s:line_2_after, '^""""') >= 0)
      return '>1'
    else
      return '='
    endif
  endif
endfunction

""" defines a foldtext
function! VimFoldText()
  " handle special case of normal comment first
  let s:info = '('.string(v:foldend-v:foldstart).' l)'
  if v:foldlevel == 1
    let s:line = ' ◇ '.getline(v:foldstart+1)[3:-2]
  elseif v:foldlevel == 2
    let s:line = '   ●  '.getline(v:foldstart)[3:]
  elseif v:foldlevel == 3
    let s:line = '     ▪ '.getline(v:foldstart)[4:]
  endif
  if strwidth(s:line) > 80 - len(s:info) - 3
    return s:line[:79-len(s:info)-3+len(s:line)-strwidth(s:line)].'...'.s:info
  else
    return s:line.repeat(' ', 80 - strwidth(s:line) - len(s:info)).s:info
  endif
endfunction

""" set foldsettings automatically for vim files
augroup fold_vimrc
  autocmd!
  autocmd FileType vim
                   \ setlocal foldmethod=expr |
                   \ setlocal foldexpr=VimFolds(v:lnum) |
                   \ setlocal foldtext=VimFoldText() |
augroup END

""""""""""""""""""
"  Unsorted yet  "
""""""""""""""""""
command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

set confirm

nnoremap <silent> <leader>w :w<cr>

set noshowmode
set noruler

filetype plugin indent on
syntax on

set scrolloff=5
set shiftround
set tabstop=2
set shiftwidth=2
set expandtab smarttab
set lazyredraw
" set max syntax highlighting column to sane level
set synmaxcol=250

set textwidth=0
" keep marks
" set viminfo='100,\"90,h,%
set nostartofline

set ignorecase smartcase
set hlsearch
set incsearch
set inccommand=split

set timeout ttimeoutlen=0

inoremap <c-l> <del>

" keep selection after indent
vnoremap < <gv
vnoremap > >gv
nnoremap <m-l> :bn<cr>
nnoremap <m-h> :bp<cr>

nnoremap <leader>x <c-w>c
nnoremap <leader>s <c-w>v

nnoremap <silent> <m-,> :lclose<cr>:cclose<cr>
" remove buffer without deleting window
nnoremap <silent> <m-d> :bp<bar>bd #<cr>

" wordwise upper line completion in insert mode
" inoremap <expr> <c-y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

if filereadable(expand('~/.config/nvim/projects.public.vim'))
    so ~/.config/nvim/projects.public.vim
endif

"" IsOnBattery
function! IsOnBattery()
  " might be AC instead of ACAD on your machine
  return readfile('/sys/class/power_supply/ACAD/online') == ['0']
endfunction

" set clipboard+=unnamedplus

nnoremap <silent> <leader><f5> :e $MYVIMRC<CR>
" trying to get used to capslock escape
" imap jk <esc>


command! -nargs=* Only call CloseHiddenBuffers()
function! CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bw ' . b
    endif
  endfor
  echon 'Deleted ' . l:tally . ' buffers'
endfun

" Intelligently navigate tmux panes and Vim splits using the same keys.
" See https://sunaku.github.io/tmux-select-pane.html for documentation.
let progname = substitute($VIM, '.*[/\\]', '', '')
set title titlestring=%{progname}\ %f\ +%l\ #%{tabpagenr()}.%{winnr()}
if &term =~# '^screen' && !has('nvim') | exe "set t_ts=\e]2; t_fs=\7" | endif

let g:tmux_navigator_disable_when_zoomed=1

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction


nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  " if &filetype ==# 'vim'
  "   execute 'h '.expand('<cword>')
  " else
    call CocAction('doHover')
  " endif
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" " override nord visual highlighting
" function! CustomHighlighting() abort
"     hi Comment ctermfg=gray
"     hi BufTabLineCurrent ctermfg=2 ctermbg=8
"     hi Visual ctermfg=7 ctermbg=4
"     hi Folded ctermfg=4
"     hi Search ctermfg=0 ctermbg=10
" endfunction
" call CustomHighlighting()

" augroup ColorSchemes
"     autocmd!
"     autocmd ColorScheme PaperColor hi Visual ctermfg=15 ctermbg=4
" augroup END

hi Comment ctermfg=gray
hi BufTabLineCurrent ctermfg=2 ctermbg=8
hi Visual ctermfg=7 ctermbg=4
hi Folded ctermfg=4
hi Search ctermfg=0 ctermbg=10

function! Zd()
    normal! "+p
    g!/Message\\"/d
    s/.\+\\"Message\\" : \\"//
    s/\\".\+//
    " replace zd<space> with <your_zlib_decode_function/alias>
    normal! Izd
    " copies everything into system's clipboard
    normal! 0"+y$
    q!
endfunction

call coc#add_extension(
      \ 'coc-css',
      \ 'coc-html',
      \ 'coc-ultisnips',
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-tslint',
      \ 'coc-yaml',
      \ 'coc-prettier',
      \ 'coc-python',
      \ 'coc-eslint',
      \ 'coc-phpls',
      \ 'coc-sh',
      \ 'coc-docker',
      \ 'coc-git',
      \ 'coc-calc',
      \ 'coc-post',
      \ 'coc-vimlsp',
      \ 'coc-lists',
      \ 'coc-yank',
      \ )
      " \ 'coc-pairs',
      " \ 'coc-highlight',
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help',
      \ 'html',
      \ 'python',
      \ 'bash=sh',
      \ 'css',
      \'javascript',
      \ 'js=javascript',
      \ 'typescript'
      \]
" gherkin: check step usages
" let @s='?/\^?s+2y/\("\|\$\):lvimgrep /<C-R>"/j tests/features/*.feature<CR>:lopen<CR>'

nnoremap <c-f> :set ft=json<cr>:%!python -m json.tool<cr>

command! -nargs=0 DT :windo diffthis
set diffopt+=internal,algorithm:histogram
if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=histogram")'
endif

command! -nargs=0 Compare :silent! call Compare()
function! Compare() abort
    normal! "+p
    g/^$/d
    normal! ggdd
    :%s/&/\r/g
    :w! /tmp/actual
    :vsplit /tmp/expected
    normal! gg"_dG
    normal! p
    :%s/&/\r/g
    g/^$/d
    DT
endfunction

command! -nargs=0 CompareJsonExp :silent! call CompareJsonExp()
function! CompareJsonExp() abort
    normal! "+p
    g/^$/d
    g/\\ No newline at end of file/d
    " delete expected
    normal! ggda{
    g/^$/d
    %!python -m json.tool
    :%s/&/\r/g
    :w! /tmp/actual
    :vsplit /tmp/expected
    normal! gg"_dG
    normal! p
    g/^$/d
    %!python -m json.tool
    %s/&/\r/g
    DT
endfunction

" command! Messages :redir => bufout | silent :messages | redir end | new | call append(0, split(bufout, '\n'))

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>gr <Plug>(coc-rename)
vmap <leader>gf <Plug>(coc-format-selected)
" nmap <leader>gf <Plug>(coc-format)
nmap <leader>R <Plug>(coc-refactor)

" nnoremap <silent> <leader>D  :exe 'CocList -I --normal --input='.expand('<cword>').' symbols'<CR>
" nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
nnoremap <silent> <leader>D  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <leader>d  :<C-u>CocList outline<cr>
nnoremap <leader>gg :<C-u>CocCommand git.
nnoremap <silent> <leader>gs :<C-u>CocList --normal gstatus<cr>
nnoremap <silent> <leader>gl :<C-u>CocList --normal commits<cr>
nnoremap <leader>gW :<C-u>CocCommand git.chunkStage<cr>
nnoremap <silent> gb :CocCommand git.browserOpen<cr>
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit ad current position
nmap gc <Plug>(coc-git-commit)

function! FormatDate() abort
    let l:line = getline('.')
    let l:pattern = ''

    " 12/12/12
    let l:mm_dd_yy_pattern = '\(\d\d\)\/\(\d\d\)\/\(\d\+\)'
    if l:line =~# l:mm_dd_yy_pattern
        let l:pattern = l:mm_dd_yy_pattern
        let l:day = '\2'
        let l:month = '\1'
        let l:year = '\3'
    endif

    " 2012-12-20
    let l:yyyy_mm_dd_pattern = '\(\d\+\)-\(\d\d\)-\(\d\d\)'
    if l:line =~# l:yyyy_mm_dd_pattern
        let l:pattern = l:yyyy_mm_dd_pattern
        let l:day = '\3'
        let l:month = '\2'
        let l:year = '\1'
    endif

    " 13.12.19
    let l:dd_mm_yyyy_pattern = '\(\d\d\)\.\(\d\d\)\.\(\d\+\)'
    if l:line =~# l:dd_mm_yyyy_pattern
        let l:pattern = l:dd_mm_yyyy_pattern
        let l:day = '\1'
        let l:month = '\2'
        let l:year = '\3'
    endif

    if empty(l:pattern)
        echom 'No pattern found. Aborting.'
    endif

    let l:choices = "&1: YY-MM-DD\n&2: DD.MM.YY"
    let l:choice = confirm('Select output format:', l:choices, '')
    let l:output_patterns = {
                \ '1': l:year.'-'.l:month.'-'.l:day,
                \ '2': l:day.'.'.l:month.'.'.l:year,
                \}
    if !has_key(l:output_patterns, l:choice)
        echom 'Invalid choice, doing nothing'
        return
    endif

    if l:choice ==# '2'
        let l:am_pattern = '\(\d\d\):\(\d\d.*\) AM'
        let l:pm_pattern = '\(\d\d\):\(\d\d.*\) PM'
        if l:line =~# l:am_pattern || l:line =~# l:pm_pattern
            execute ':%substitute/' . l:am_pattern . '/\1:\2/g'
            execute ':%substitute/' . l:pm_pattern . '/\="".submatch(1) == "12" ? "00:".submatch(2): submatch(1)+12.":".submatch(2)/g'
        endif
    endif

    execute ':%substitute/' . l:pattern . '/'. l:output_patterns[l:choice] . '/g'
endfunction

so ~/.local.init.vim

nnoremap <m-j> :call LocListToggle()<cr>
let g:loclist_open = 0
function! LocListToggle()
  if g:loclist_open == 1
    lclose
    let g:loclist_open = 0
  else
    lopen
    let g:loclist_open = 1
  endif
endfunction

nnoremap dg <c-w>wVy<c-w>wP]c

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

vnoremap // :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
" nnoremap <leader>A :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@

function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep '.word
endfunction

" toggle mundo tree
function! s:mundoToggle()
	let cwin = -1
	let syn = ''
	let synflag = 0
	if buffer_name('%') !~# '^__Mundo\%(_Preview\)\?__$'
		let synflag = 1
		let cwin = win_getid()
		let syn = &syntax
		setlocal syntax=
	endif
	MundoToggle
	if synflag
		let winflag = cwin !=# -1 && buffer_name('%') =~# '^__Mundo\%(_Preview\)\?__$'
		if winflag
			call win_gotoid(cwin)
		endif
		execute 'setlocal syntax='.syn
		if winflag
			wincmd p
		endif
	endif
endfunction
nnoremap <m-u> :call <sid>mundoToggle()<cr>

function! ImplementInterface()
    if !filereadable('go.mod')
        echo 'no go.mod found in cwd'
        return
    endif
    let l:cword = substitute(substitute(expand('<cword>'), 'Stub', '', ''), 'Mock', '', '')

    let l:currentBasePackage = substitute(substitute(system('head -n 1 go.mod'), 'module ', '', ''), '\n\+$', '', '')
    let l:interface = input('interface: ', l:currentBasePackage.''.substitute(expand('%:p:h'), getcwd(), '', '').'.'.l:cword)
    let l:receiver = expand('<cword>')
    let l:firstLetter = tolower(strpart(l:receiver, 0, 1))

    exe ':GoImpl '.l:firstLetter.' *'.l:receiver.' '.l:interface
endfunction

" non-gomod projects
" dependency: go get golang.org/x/tools/cmd/gomvpkg
function! GoMoveDir()
  :update

  " find current gopath
  let l:gopath = ''
  for gopath in split($GOPATH, ':')
    if expand('%:p:h') =~ '^'.gopath
      let l:gopath = gopath
    endif
  endfor

    let l:currentFile = expand('%:p')
    let l:oldPath = input('Old path: ', substitute(expand('%:p:h'), gopath.'/src/', '', ''))
    let l:newPath = input('New path ==> ', l:oldPath)

  if len(l:gopath) == 0
    " echo 'Cannot move pkg - not in configured gopath?!'
    " return
  endif


  execute '!gomvpkg -from '.l:oldPath.' -to '.l:newPath

  if !filereadable(l:currentFile)
    :bd
  endif
endfunction

" non-gomod projects
" dependency: go get golang.org/x/tools/cmd/gomvpkg
function! GoMoveFile()
  :update

  " find current gopath
  let l:gopath = ''
  for gopath in split($GOPATH, ':')
    if expand('%:p:h') =~ '^'.gopath
      let l:gopath = gopath
    endif
  endfor

  if len(l:gopath) == 0
    echo 'Cannot move pkg - not in configured gopath?!'
    return
  endif

  let l:currentFile = expand('%:p')
  let l:oldPath = input('Old path: ', substitute(expand('%:p:h'), gopath.'/src/', '', ''))
  let l:newPath = input('New path ==> ', l:oldPath)

  execute '!gomvpkg -from '.l:oldPath.' -to '.l:newPath

  if !filereadable(l:currentFile)
    :bd
  endif
endfunction

" dependency: go get -u github.com/ksubedi/gomove
function! GoMoveDirV2()
  :update

  if !filereadable('go.mod')
      echo 'no go.mod found in cwd - not moving anything'
      return
  endif

  let l:currentBasePackage = substitute(substitute(system('head -n 1 go.mod'), 'module ', '', ''), '\n\+$', '', '')
  let l:currentFile = expand('%:p')
  let l:oldPath = substitute(expand('%:p:h'), getcwd(), '', '')
  let l:oldPackage = input('Old package: ', l:currentBasePackage.''.l:oldPath)
  let l:newPackage = input('New package ==> ', l:oldPackage)
  let l:oldPath = getcwd().'/'.substitute(l:oldPackage, l:currentBasePackage, '', '')
  let l:newPath = getcwd().'/'.substitute(l:newPackage, l:currentBasePackage, '', '')
  if l:oldPackage =~# '/$'
      let l:oldPackage = strpart(l:oldPackage, 0, len(l:oldPackage) -1)
  endif
  if l:newPackage =~# '/$'
      let l:newPackage = strpart(l:newPackage, 0, len(l:newPackage) -1)
  endif

  if empty(glob(l:newPath))
      exe '!mkdir -p '.l:newPath
  endif

  exe '!mv '.l:oldPath.'/* '.l:newPath
  exe '!gomove '.l:oldPackage.' '.l:newPackage

  if !filereadable(l:currentFile)
    :bd
  endif
endfunction

function! AliasGoImport()
    let l:skip = !has_key(v:completed_item, 'word') || v:completed_item['kind'] !=# 'M'

    if !l:skip
        let l:currentPackage = v:completed_item['word']
        let l:importPath = substitute(substitute(v:completed_item['menu'], ' \[LS\]', '', ''), '"', '', 'g')
    endif

    if !l:skip
        " check if selected package is already imported
        let [s:line, s:col] = searchpos('"'.l:importPath.'"', 'n')
        let l:skip = s:line
    endif

    if !l:skip
        " check if different package with same name is already imported
        let [s:line, s:col] = searchpos('\s\+".\+/'.l:currentPackage.'"$', 'n')
        if s:line > 0
            let l:alias = input('Package already imported. Alias '.l:importPath.' as: ')
            if l:alias ==# ''
                echo 'No alias given - not doing anything'
            else
                let l:cmd = 'GoImportAs ' . l:alias . ' ' . l:importPath
                execute l:cmd
                execute 'normal! ciw'.l:alias
            endif

            let l:skip = 1
        endif
    endif

    if !l:skip
        let l:cmd = 'GoImport ' . l:importPath
        execute l:cmd
    endif

    normal! a.
    if col('.') == col('$') - 1
        startinsert!
    else
        normal! l
        startinsert
    end
endfunction

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'remove_trailing_lines', 'trim_whitespace'],
\   'sh': ['shfmt', 'remove_trailing_lines', 'trim_whitespace'],
\   'json': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
\   'markdown': ['prettier', 'textlint', 'remove_trailing_lines', 'trim_whitespace'],
\   'text': ['textlint', 'remove_trailing_lines', 'trim_whitespace'],
\   'go': ['goimports', 'remove_trailing_lines', 'trim_whitespace'],
\   'sql': ['sqlfmt', 'remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_go_golangci_lint_options = '--fast --config .golangci.yml --skip-dirs node_modules'
if !filereadable('.golangci.yml')
  let g:ale_go_golangci_lint_options = '--fast --config ~/.golangci.yml'
endif

augroup VIMRC
    autocmd!
    autocmd BufLeave *.css,*.scss normal! mC
    autocmd BufLeave *.html normal! mH
    autocmd BufLeave *.js normal! mJ
    autocmd BufLeave *.go normal! mG
    autocmd BufLeave *_test.go normal! mT
    autocmd BufLeave *.yml,*.yaml normal! mY
    autocmd BufLeave *.sh normal! mS
    autocmd BufLeave *.md normal! mM
augroup END
nnoremap ' `
nnoremap <silent> <space>y  :<C-u>CocList --normal yank<cr>

nmap <C-]> <Plug>(fzf_tags)
nmap <C-[> <ESC>:po<CR>
