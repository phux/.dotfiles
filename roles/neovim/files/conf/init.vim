set encoding=utf-8
scriptencoding utf-8

if has('vim_starting')
  let g:qf_loc_toggle_binds = 0
endif

if !filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo 'Installing vim-plug and plugins. Restart vim after finishing the process.'
    silent call mkdir(expand('~/.config/nvim/autoload', 1), 'p')
    execute '!curl -fLo '.expand('~/.config/nvim/autoload/plug.vim', 1).' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    " vint: -ProhibitAutocmdWithNoGroup
    autocmd VimEnter * PlugInstall
endif

command! PU PlugUpdate | PlugUpgrade
call plug#begin('~/.config/nvim/plugged')

Plug 'sheerun/vim-polyglot', {'do': './build'}
Plug 'tpope/vim-commentary', {'on': 'Commentary'}

Plug 'ap/vim-buftabline'
let g:buftabline_show = 1 " display only if more than 1 buffer open

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'jiangmiao/auto-pairs'
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutToggle = ''
Plug 'andymass/vim-matchup'
let g:matchup_matchparen_status_offscreen=0
 let g:matchup_transmute_enabled = 1

Plug 'amiorin/vim-project'

Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', {'on': 'Gitv'}

Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
let g:NERDTreeUpdateOnCursorHold = 0
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeWinSize = 40
let g:NERDTreeMinimalUI=1
let g:NERDTreeCascadeSingleChildDir=0
let g:NERDTreeAutoDeleteBuffer=1

Plug 'Lokaltog/vim-easymotion'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-cssomni', {'for': 'css'}
Plug 'ncm2/ncm2-go', {'for': 'go'}
Plug 'ncm2/ncm2-ultisnips'
Plug 'phpactor/ncm2-phpactor', {'for': 'php'}
Plug 'yuki-ycino/ncm2-dictionary'
Plug 'ncm2/ncm2-tern',  {'do': 'npm install', 'for': 'javascript'}
Plug 'ncm2/nvim-typescript', {'do': './install.sh', 'for': 'typescript'}
Plug 'ncm2/ncm2-jedi', {'for': 'python'}

Plug 'ternjs/tern_for_vim', {'do': 'npm install', 'for': ['typescript','javascript']}

Plug 'reedes/vim-lexical', {'for': ['text', 'markdown', 'gitcommit']}

Plug 'python-mode/python-mode', {'for': 'python'}
let g:pymode_folding = 0
let g:pymode_python = 'python3'
let g:pymode_lint = 0

Plug 'xolox/vim-misc'

Plug 'w0rp/ale'
nnoremap <silent> <F8> :ALEDisableBuffer<cr>
nnoremap <silent> <leader><F8> :ALEEnableBuffer<cr>
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_list_window_size = 5
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'php': ['phpcbf', 'php_cs_fixer'],
  \ 'json': ['fixjson', 'prettier']
  \}
let g:ale_fix_on_save=1

Plug 'phux/php-doc-modded', {'for': 'php'}
Plug 'sahibalejandro/vim-php', {'for': ['php', 'yaml']}
Plug 'alvan/vim-php-manual', {'for': 'php'}
let g:vim_php_refactoring_use_default_mapping = 0
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'phpactor/phpactor', {'for': 'php', 'do': ':call phpactor#Update()'}
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }

Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'sebdah/vim-delve', {'for': 'go'}
Plug 'godoctor/godoctor.vim', {'for': 'go'}
Plug 'buoto/gotests-vim', {'for': 'go'}

Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_mru_relative = 1
Plug 'pbogut/fzf-mru.vim', {'on': 'FZFMru'}

Plug 'Shougo/echodoc.vim'

Plug 'janko-m/vim-test'
Plug 'AndrewRadev/splitjoin.vim', {'on': ['SplitjoinSplit', 'SplitjoinJoin']}

Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'gabrielelana/vim-markdown', {'for': 'markdown'}
Plug 'junegunn/goyo.vim', {'for': 'markdown'}
Plug 'plasticboy/vim-markdown', {'for': 'markdown', 'as': 'vim-markdown-plasticboy'}
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'do': 'bash install.sh',
"     \ }
" let g:LanguageClient_serverCommands = {
"   \ 'typescript': ['javascript-typescript-stdio'],
"   \ 'javascript': ['javascript-typescript-stdio']
"   \ }
" let g:LanguageClient_diagnosticsEnable  = 0
" let g:LanguageClient_diagnosticsList = ''
" let g:LanguageClient_signColumnAlwaysOn = 0
" let g:LanguageClient_selectionUI = 'fzf'

Plug 'maksimr/vim-jsbeautify'
map <c-f> :call JsBeautify()<cr>

Plug 'henrik/vim-indexed-search'
Plug 'romainl/vim-cool'
Plug 'wincent/ferret', {'on': 'Ack'}
let g:FerretHlsearch=1

Plug 'romainl/vim-qf'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'

Plug 'simeji/winresizer'
Plug 'wellle/targets.vim'

Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}

Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; python2 generate.py' }

Plug 'm-kat/aws-vim'

Plug 'itchyny/lightline.vim'
" Set the 'path' option for miscellaneous file types
Plug 'tpope/vim-apathy'

Plug 'tpope/vim-rhubarb'

Plug 'timeyyy/orchestra.nvim'
Plug 'timeyyy/clackclack.symphony'
Plug 'timeyyy/bubbletrouble.symphony'
Plug 'arcticicestudio/nord-vim'

call plug#end()
" call orchestra#prelude()
" call orchestra#set_tune('bubbletrouble')
" call orchestra#set_tune('clackclack')

let mapleader = "\<Space>"
nnoremap <silent> <leader><f5> :e $MYVIMRC<CR>
imap jk <esc>

set t_Co=256
" color deus
color nord

" \ 'colorscheme': 'nord',
let g:lightline = {
  \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

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

augroup nvim
  au!
  au BufWritePost *.vim nested source $MYVIMRC
  au CursorHold * normal! m'
  " no delay when ESC/jk
  au InsertEnter * set timeoutlen=100
  au InsertLeave * set timeoutlen=500

  autocmd BufEnter * call ncm2#enable_for_buffer()
  au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
  au User Ncm2PopupClose set completeopt=menuone

augroup END

augroup js
  au!

  au FileType typescript nnoremap <buffer> gd :TSDef<CR>
  au FileType typescript nnoremap <buffer> gr :TSRefs<CR>
  au FileType typescript nnoremap <buffer> K :TSDefPreview<cr>
augroup END

let g:lexical#thesaurus = ['~/.config/nvim/thesaurus.txt',]

augroup everything
  au!

  au BufNewFile,BufRead *.yml.dist set ft=yaml
  au BufRead,BufNewFile *.conf setf config
  au BufNewFile,BufRead composer.lock set ft=json

  au FileType css,less,scss let b:ale_fixers = ['prettier']

  au FileType html,xml inoremap <buffer> <m-;> </<c-x><c-o>
  au FileType xml   setlocal makeprg=xmllint\ -

  autocmd FileType gitv nmap <buffer> <silent> <C-n> <Plug>(gitv-previous-commit)
  autocmd FileType gitv nmap <buffer> <silent> <C-p> <Plug>(gitv-next-commit)

  au BufWritePost * silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
augroup END

set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set hidden
set nojoinspaces

set nobackup
set nowritebackup
set noswapfile

set undofile " Maintain undo history between sessions
set undodir=~/.vim_undodir

" Copy to Clipboard (on Unix)
"set clipboard+=unnamedplus
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
vnoremap <leader>d "+d
vnoremap <silent> y y`]
vnoremap <silent> p p=`]
nnoremap <silent> p p=`]

nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>N :NERDTreeFind<cr>

nnoremap <silent> <leader>w :lclose<cr>:w<cr>

let g:UltiSnipsSnippetsDir = ['~/.config/nvim/UltiSnips/', './plugged/aws-vim/snips']
let g:UltiSnipsExpandTrigger='<c-j>'

let g:AutoPairsMapCR=0
inoremap <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")

let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

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

nnoremap <leader><Enter> :FZFMru<cr>

nnoremap <leader><tab> :Buffers<cr>
nnoremap <leader>, :Files<cr>
nnoremap <leader>. :FZFAllFiles<cr>
nnoremap <leader>d :BTags<cr>
nnoremap <leader>D :BTags <C-R><C-W><cr>
nnoremap <leader>T :Tags<cr>
nnoremap <leader>; :TagbarToggle<cr>

let g:project_use_nerdtree = 0
let g:project_enable_welcome = 0
nnoremap <F1> :e ~/.config/nvim/projects.public.vim<cr>
nnoremap <leader><F2> :e ~/.projects.private.vim<cr>

set runtimepath+=~/.config/nvim/plugged/vim-project/
call project#rc('~/code')

nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gl :Gitv<cr>

nnoremap <silent> <m-,> :lclose<cr>:cclose<cr>

nnoremap <leader>/ :Ack <c-r><c-w><cr>
nnoremap <leader>rip :Acks /<c-r><c-w>/<c-r><c-w>/gc<left><left><left>

nmap <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>F <Plug>(easymotion-bd-w)
nmap <Leader>f <Plug>(easymotion-overwin-w)
nmap  <Leader>b <Plug>(easymotion-b)
let g:EasyMotion_smartcase = 1

nnoremap <leader>c :Commentary<cr>
vnoremap <leader>c :Commentary<cr>

nnoremap <leader>] :%Subvert/<c-R><c-w>/<c-r><c-w>/g<left><left>
vnoremap <leader>] :%Subvert//g<left><left>

filetype plugin indent on
syntax on

set tabstop=2
set shiftwidth=2
set scrolloff=5
set shiftround
set expandtab smarttab
set cindent
set lazyredraw
set modelines=2
set synmaxcol=1000

set ignorecase smartcase
set hlsearch
set incsearch

set timeout ttimeoutlen=0

inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"

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

set complete-=i
set complete+=w

set textwidth=0

set nostartofline

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
nmap <Down> :call ToggleQfLocListBinds()<cr>

nnoremap <leader>x <c-w>c
nnoremap <leader>s <c-w>v

function! PrependTicketNumber()
  normal! gg
  let l:branch = system("echo $(git branch | grep '*')")
  let l:branchName = substitute(l:branch, '\* \(.*\)', '\1', '')
  let l:ticketNumber = substitute(l:branchName, '\(\w\+-\d\+\).*', '\1', '')
  let l:ticketNumber = substitute(l:ticketNumber, 'feature/', '', '')
  exe 'normal i'.l:ticketNumber.' '
  normal! kJx
  :startinsert!
endfunction

" Move by screen line not file line, but only if no count provided
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

nnoremap <leader>gv :Gitv!<cr>
vnoremap <leader>gv :Gitv!<cr>
nnoremap <leader>gV :Gitv<cr>

let g:Gitv_DoNotMapCtrlKey = 1


" remove buffer without deleting window
nnoremap <silent> <m-d> :bp<bar>sp<bar>bn<bar>bd<CR>

nnoremap <leader>j :SplitjoinSplit<cr>
nnoremap <leader>k :SplitjoinJoin<cr>

nnoremap <leader>ga :Tabularize /\|<cr>
vnoremap <leader>ga :Tabularize /\|<cr>
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" format html (each tag on it's own line)
nnoremap <leader><F3> :%s/<[^>]*>/\r&\r/g<cr>gg=G:g/^$/d<cr><leader>

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

nnoremap dg3 :diffget //3<cr>
nnoremap dg2 :diffget //2<cr>

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
"}}}

command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

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

set wildmenu
set wildmode=list:longest,full

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
    if bufexists(i) && !getbufvar(i,'&mod') && index(tablist, i) == -1
      "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
      silent exec 'bwipeout' i
      let nWipeouts = nWipeouts + 1
    endif
  endfor
  echomsg nWipeouts . ' buffer(s) wiped out'
endfunction

command! Ball :call DeleteInactiveBufs()

let test#strategy='neovim'
let g:yankring_replace_n_pkey = '<m-p>'
let g:yankring_replace_n_nkey = '<m-P>'

set diffopt=vertical,filler

set confirm

let g:scratch_persistence_file = '.scratch.vim'
nnoremap <m-z> :ScratchPreview<cr>

" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" highlight Normal ctermbg=NONE
" highlight nonText ctermbg=NONE

set nocursorline

function! EditFtPluginFile(ft)
  exec ':e ~/.dotfiles/roles/neovim/files/ftplugin/'.a:ft.'.vim'
endfunction
nnoremap <F12> :call EditFtPluginFile(&filetype)<cr>

nnoremap <leader><F12> :call EditFtPluginFile('')<left><left>

nnoremap <m-u> :GundoToggle<CR>
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1

function! LightScheme()
  set background=light
  color github
  set cursorline
endfunction

set inccommand=nosplit

function! IsOnBattery()
  " might be AC instead of ACAD on your machine
  return readfile('/sys/class/power_supply/ACAD/online') == ['0']
endfunction

nnoremap <leader>gp :!git push<cr>

nnoremap <leader>a :Rg<space>
nnoremap <leader>A :exec "Rg ".expand("<cword>")<cr>
nnoremap <m-r> :exec "Rg ".expand("<cword>")<cr>
vnoremap <m-r>  "hy:exec "Find ".escape('<C-R>h', "/\.*$^~[()")<cr>
nnoremap <m-s-r> :exec "Find ".expand("<cword>")<cr>
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case  --colors "match:bg:yellow" --colors "match:fg:black" --colors "match:style:nobold" --colors "path:fg:green" --colors "path:style:bold" --colors "line:fg:yellow" --colors "line:style:bold" '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --colors "match:bg:yellow" --colors "match:fg:black" --colors "match:style:nobold" --colors "path:fg:green" --colors "path:style:bold" --colors "line:fg:yellow" --colors "line:style:bold" --smart-case  --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

set grepprg=rg\ --vimgrep

so ~/.config/nvim/projects.public.vim
let g:xml_syntax_folding = 1
let g:sh_fold_enabled= 7
let g:ruby_fold = 1
set foldmethod=syntax
set foldlevel=1
set foldnestmax=1
nnoremap ,, za
" "Refocus" folds
nnoremap ,z zMzvzz

function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf('%10s', lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
" nord
hi Visual term=reverse cterm=reverse guibg=Grey
hi Folded ctermfg=242
hi Comment ctermfg=242
