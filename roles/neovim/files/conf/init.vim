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
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutToggle = ''

Plug 'amiorin/vim-project'

Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'
Plug 'gregsexton/gitv'
Plug 'junegunn/gv.vim'

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'
let g:NERDTreeUpdateOnCursorHold = 0
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeWinSize = 40
let g:NERDTreeMinimalUI=1
let g:NERDTreeCascadeSingleChildDir=0
let g:NERDTreeAutoDeleteBuffer=1
" let g:NERDTreeWinPos = 'right'

Plug 'Lokaltog/vim-easymotion'
Plug 'matze/vim-move'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}


Plug 'rafi/awesome-vim-colorschemes'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'fxn/vim-monochrome'
Plug 'ikaros/smpl-vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'roxma/nvim-completion-manager'

Plug 'neomake/neomake'

Plug 'phux/ncm-phpactor', {'for': 'php', 'branch':'feature/Local_Variable_Completion'}
Plug 'padawan-php/deoplete-padawan', {'for': 'php', 'do': 'composer install'}
Plug 'phux/php-doc-modded', {'for': 'php'}
Plug 'sahibalejandro/vim-php', {'for': ['php', 'yaml']}
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'alvan/vim-php-manual', {'for': 'php'}
Plug 'vim-php/vim-php-refactoring', {'for': 'php'}
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'phpactor/phpactor', {'for': 'php', 'do': ':call phpactor#Update()' }
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }

" Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoUpdateBinaries', 'tag': '*'}
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'sebdah/vim-delve', {'for': 'go'}
Plug 'godoctor/godoctor.vim', {'for': 'go'}
Plug 'buoto/gotests-vim', {'for': 'go'}
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' , 'for': 'go'}

Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_mru_relative = 1
Plug 'pbogut/fzf-mru.vim'

Plug 'Shougo/echodoc.vim'

Plug 'janko-m/vim-test'

Plug 'AndrewRadev/splitjoin.vim'

Plug 'gabrielelana/vim-markdown', {'for': 'markdown'}
Plug 'junegunn/goyo.vim', {'for': 'markdown'}
Plug 'shime/vim-livedown', {'for': 'markdown'}

" Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'nelsyeung/twig.vim', {'for': 'twig'}


Plug 'henrik/vim-indexed-search'
Plug 'romainl/vim-cool'
Plug 'wincent/ferret', {'on': 'Ack'}
let g:FerretHlsearch=1

Plug 'romainl/vim-qf'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'vim-scripts/YankRing.vim'

Plug 'simeji/winresizer'
Plug 'wellle/targets.vim'

Plug 'mtth/scratch.vim'

Plug 'junegunn/vim-peekaboo'

Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}

Plug 'aserebryakov/vim-todo-lists'
" Plug 'mhinz/vim-startify'
Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; python2 generate.py' }
Plug 'machakann/vim-highlightedyank'
call plug#end()

let mapleader = "\<Space>"
nnoremap <silent> <leader><f5> :e $MYVIMRC<CR>
inoremap jk <esc>

" interface
set t_Co=256
" set background=dark

" colorscheme gruvbox
" colorscheme apprentice
" colorscheme seoul256
" colorscheme zenburn
set background=dark
" colorscheme 256_noir " fav mono
" color lucius " fav low contrast
color deus
" colorscheme hybrid " fav bright
" color github
" colorscheme smpl

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

augroup nvim
  au!
  au BufWritePost *.vim nested source $MYVIMRC
  au CursorHold * normal! m'
  " no delay when ESC/jk
  au InsertEnter * set timeoutlen=100
  au InsertLeave * set timeoutlen=500

  " fix issue when leaving vim
  " au WinEnter * :EnableGoldenViewAutoResize
augroup END
augroup js
  au!

  au FileType javascript setlocal omnifunc=tern#Complete
  au FileType javascript setlocal omnifunc=tern#Complete
  au FileType javascript LanguageClientStart
  au FileType typescript LanguageClientStart
  au FileType typescript nnoremap <buffer> gd :TSDef<CR>
  au FileType typescript nnoremap <buffer> gr :TSRefs<CR>
  au FileType typescript nnoremap <buffer> K :TSDefPreview<cr>
augroup END

augroup everything
  au!

  au FileType yaml setl sw=2 sts=2 et
  au BufNewFile,BufRead *.yml.dist set ft=yaml
  au FileType ruby setl sw=2 sts=2 et
  au BufRead,BufNewFile *.conf setf config
  au BufNewFile,BufRead composer.lock set ft=json

  au FileType scratch :call VimTodoListsInit()
  au FileType todo nnoremap <buffer> <cr> :VimTodoListsToggleItem<CR>

  au FileType css setlocal omnifunc=csscomplete#CompleteCSS
  au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  au FileType html,xml inoremap <buffer> <m-;> </<c-x><c-o>
  au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  au FileType xml   setlocal makeprg=xmllint\ -
  au FileType json  setlocal equalprg=python\ -mjson.tool

  autocmd FileType gitcommit nnoremap <buffer> <leader>w :call PrependTicketNumber()<cr>
  autocmd FileType gitv nmap <buffer> <silent> <C-n> <Plug>(gitv-previous-commit)
  autocmd FileType gitv nmap <buffer> <silent> <C-p> <Plug>(gitv-next-commit)
augroup END

let g:LanguageClient_diagnosticsEnable  = 0
let g:LanguageClient_diagnosticsList = ''
let g:LanguageClient_signColumnAlwaysOn = 0
let g:LanguageClient_selectionUI = 'fzf'
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

set undofile " Maintain undo history between sessions
set undodir=~/.vim_undodir


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

nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>N :NERDTreeFind<cr>

nnoremap <silent> <leader>w :lclose<cr>:w<cr>

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

vnoremap <leader>/ "hy:exec "Ag ".escape('<C-R>h', "/\.*$^~[()")<cr>

nnoremap <leader><Enter> :FZFMru<cr>

nnoremap <leader><tab> :Buffers<cr>
nnoremap <leader>, :Files<cr>
nnoremap <leader>. :FZFAllFiles<cr>
nnoremap <leader>d :BTags<cr>
nnoremap <leader>D :BTags <C-R><C-W><cr>
nnoremap <leader>T :Tags<cr>
nnoremap <leader>; :TagbarToggle<cr>
" set notagrelative


let g:project_use_nerdtree = 0
let g:project_enable_welcome = 0
nnoremap <F1> :e ~/.config/nvim/projects.public.vim<cr>
nnoremap <leader><F2> :e ~/.projects.private.vim<cr>

set rtp+=~/.config/nvim/plugged/vim-project/
call project#rc("~/code")

nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gl :Extradite!<cr>

nnoremap <f11> :NeomakeToggle<cr>
nnoremap <silent> <m-,> :lclose<cr>:cclose<cr>

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

set tabstop=2
set shiftwidth=2
set scrolloff=5
set shiftround
set expandtab smarttab
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

let g:cm_auto_popup=0 " disable nvim-completion-manager
let g:deoplete#enable_at_startup = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#sources = get(g:, 'deoplete#sources', {})
let g:deoplete#sources._ = ['ultisnips', 'buffer']

let g:deoplete#sources#padawan#add_parentheses=1
let g:deoplete#sources#padawan#server_command='~/.config/nvim/plugged/deoplete-padawan/vendor/bin/padawan-server'
let g:deoplete#sources#padawan#auto_update=1
let g:deoplete#sources.php = ['padawan', 'ultisnips', 'buffer']
let g:deoplete#skip_chars = ['$']

let g:deoplete#sources#go = ['go', 'ultisnips', 'buffer']
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1
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



nmap <c-p> <Plug>(qf_loc_previous)
nmap <c-n> <Plug>(qf_loc_next)
let g:qf_loc_toggle_binds = 0
function! ToggleQfLocListBinds()
  if g:qf_loc_toggle_binds == 1
    nmap <c-p> <Plug>(qf_loc_previous)
    nmap <c-n> <Plug>(qf_loc_next)
    let g:qf_loc_toggle_binds = 0
    echo "loc binds loaded"
  else
    let g:qf_loc_toggle_binds = 1
    nmap <c-p> <Plug>(qf_qf_previous)
    nmap <c-n> <Plug>(qf_qf_next)
    echo "qf binds loaded"
  endif
endfunction
nmap <Down> :call ToggleQfLocListBinds()<cr>

nnoremap <leader>a :Ag<space>
nnoremap <leader>A :exec "Ag ".expand("<cword>")<cr>

nnoremap <leader>x <c-w>c
nnoremap <leader>s <c-w>v

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

let g:Gitv_DoNotMapCtrlKey = 1

let g:php_manual_online_search_shortcut = '<leader>m'


" remove buffer without deleting window
nnoremap <silent> <m-d> :bp<bar>sp<bar>bn<bar>bd<CR>

nnoremap <leader>j :SplitjoinSplit<cr>
nnoremap <leader>k :SplitjoinJoin<cr>

nnoremap <leader>ga :Tabularize /\|<cr>
vnoremap <leader>ga :Tabularize /\|<cr>
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

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
let g:yankring_replace_n_pkey = '<m-p>'
let g:yankring_replace_n_nkey = '<m-P>'

set diffopt=vertical,filler

set confirm

let g:scratch_persistence_file = '.scratch.vim'
nnoremap <m-z> :ScratchPreview<cr>

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

highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

set nocul

if exists('neomake#configure#automake')
  call neomake#configure#automake('w')
endif

" keep cursor position
let g:neomake_open_list = 2

function! EditFtPluginFile()
  exec ":e ~/.config/nvim/ftplugin/".expand('%:e').".vim"
endfunction
nnoremap <F12> :call EditFtPluginFile()<cr>

let g:vim_php_refactoring_use_default_mapping = 0

command! -bang PadawanGenerate call deoplete#sources#padawan#Generate(<bang>0)

so ~/.config/nvim/projects.public.vim
nnoremap <leader>u :GundoToggle<CR>
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1

let g:qf_loclist_window_bottom = 0
let g:qf_nowrap = 0
let g:qf_mapping_ack_style = 1

let g:qf_statusline = {}
let g:qf_statusline.before = '%<\ '
let g:qf_statusline.after = '\ %f%=%l\/%-6L\ \ \ \ \ '

function! LightScheme()
  set background=light
  color solarized8_flat
  set cul
  " hi CursorLine   cterm=NONE ctermbg=7 ctermfg=NONE
endfunction

set inccommand=nosplit
