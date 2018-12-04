set encoding=UTF-8
scriptencoding utf-8

if has('vim_starting')
  set nofoldenable
endif

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

    " vint: -ProhibitAutocmdWithNoGroup
    autocmd VimEnter * PlugInstall
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

"" auto-pairs
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsMapCR=0

"" ncm2
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-go', {'for': 'go'}
Plug 'ncm2/ncm2-cssomni', {'for': 'css'}
Plug 'phpactor/ncm2-phpactor', {'for': ['php', 'markdown']}
Plug 'ncm2/ncm2-jedi', {'for': 'python'}
Plug 'ncm2/ncm2-tern',  {'do': 'npm install', 'for': 'javascript'}
Plug 'ncm2/nvim-typescript', {'do': './install.sh', 'for': 'typescript'}
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim', {'for': 'vim'}
Plug 'fgrsnau/ncm2-otherbuf', { 'branch': 'ncm2' }
" Plug 'ncm2/ncm2-highprio-pop'
" Plug 'ncm2/ncm2-match-highlight'
" let g:ncm2#match_highlight = 'mono-space'
" Plug 'ncm2/ncm2-markdown-subscope', {'for': 'markdown'}

"" pymode
Plug 'python-mode/python-mode', {'for': 'python'}
let g:pymode_folding = 0
let g:pymode_python = 'python3'
let g:pymode_lint = 0

"" w0rp/ale
Plug 'w0rp/ale'
nnoremap <silent> <leader><F8> :ALEToggleBuffer<cr>
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=0
let g:ale_list_window_size = 5
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'vim': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'php': ['phpcbf', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
  \ 'go': ['gofmt', 'goimports'],
  \ 'notes': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'markdown': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'notes.markdown': ['remove_trailing_lines', 'trim_whitespace']
  \}
" \ 'json': ['fixjson', 'prettier'],
let g:ale_fix_on_save = 1

"" js
Plug 'maksimr/vim-jsbeautify', {'for': ['json']}
nnoremap <c-f> :call JsBeautify()<cr>
Plug 'ternjs/tern_for_vim', {'do': 'npm install', 'for': ['typescript','javascript']}

"" php
Plug 'phux/php-doc-modded', {'for': 'php'}
Plug 'sahibalejandro/vim-php', {'for': ['php', 'yaml']}
Plug 'alvan/vim-php-manual', {'for': 'php'}
let g:vim_php_refactoring_use_default_mapping = 0
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'phpactor/phpactor', {'for': 'php', 'do': ':call phpactor#Update()'}
" Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }

"" go
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'sebdah/vim-delve', {'for': 'go'}
Plug 'godoctor/godoctor.vim', {'for': 'go'}
Plug 'buoto/gotests-vim', {'for': 'go'}

"" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tweekmonster/fzf-filemru', {'on': ['FilesMru', 'ProjectMru']}

"" UI
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'simeji/winresizer'
let g:echodoc_enable_at_startup=1
Plug 'Shougo/echodoc.vim'
let g:buftabline_show = 1 " display only if more than 1 buffer open
Plug 'ap/vim-buftabline'
Plug 'NLKNguyen/papercolor-theme'


"" markdown
Plug 'reedes/vim-lexical', {'for': ['text', 'markdown', 'gitcommit']}
let g:mkdp_path_to_chrome = 'chromium-browser'
Plug 'iamcco/markdown-preview.nvim', { 'for': ['markdown'] }
let g:mkdp_auto_close = 0
" Plug 'gabrielelana/vim-markdown', {'for': ['markdown']}
Plug 'junegunn/goyo.vim', {'for': 'markdown'}
Plug 'plasticboy/vim-markdown', {'for': ['markdown'], 'as': 'vim-markdown-plasticboy'}

"" search/navigate

" smart search highligting
let g:CoolTotalMatches = 1
Plug 'romainl/vim-cool'

" improving * behavior
let g:asterisk#keeppos = 1
Plug 'haya14busa/vim-asterisk'

Plug 'wellle/targets.vim'

" quickfix improvements
Plug 'romainl/vim-qf'

Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

""" clever-f
Plug 'rhysd/clever-f.vim'
let g:clever_f_smart_case=1
let g:clever_f_across_no_line=0
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)
let g:clever_f_timeout_ms=1000


""" easymotion
Plug 'Lokaltog/vim-easymotion'
nmap <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>F <Plug>(easymotion-bd-w)
nmap <Leader>f <Plug>(easymotion-overwin-w)
nmap  <Leader>b <Plug>(easymotion-b)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1 " US layout


""" nerdtree
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
let g:NERDTreeUpdateOnCursorHold = 0
let g:NERDTreeQuitOnOpen = 1
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

""" ferret
let g:FerretHlsearch=1
Plug 'wincent/ferret', {'on': 'Ack'}
nnoremap <leader>/ :Ack <c-r><c-w><cr>
nnoremap <leader>rip :Acks /<c-r><c-w>/<c-r><c-w>/gc<left><left><left>

"" git
Plug 'gregsexton/gitv', {'on': 'Gitv'}

""" fugitive
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
nnoremap dg3 :diffget //3<cr>
nnoremap dg2 :diffget //2<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gl :Gitv<cr>

"" notes
Plug 'xolox/vim-notes', {'on': ['SearchNotes', 'Note', 'RecentNotes']} | Plug 'xolox/vim-misc'
let g:notes_directories = ['~/Dropbox/notes']
let g:notes_suffix = '.md'
let g:notes_smart_quotes = 0
" let g:pad#dir = '~/Dropbox/notes/'
" let g:pad#set_mappings=0
" Plug 'fmoralesc/vim-pad', {'branch': 'devel'}
Plug 'mtth/scratch.vim', {'on' : 'ScratchPreview'}
let g:scratch_persistence_file = '.scratch.vim'
nnoremap <m-z> :Scratch<cr>


"" todo
""" vim-simple-todo
let g:simple_todo_map_keys = 0
Plug 'vitalk/vim-simple-todo'
nmap <m-i> <Plug>(simple-todo-new-start-of-line)
imap <m-i> <Plug>(simple-todo-new-start-of-line)
nmap <m-o> <Plug>(simple-todo-below)
imap <m-o> <Plug>(simple-todo-below)
imap <m-space> <Plug>(simple-todo-mark-switch)
nmap <m-space> <Plug>(simple-todo-mark-switch)

""" todo.txt
Plug 'dbeniamine/todo.txt-vim', {'for': 'text'}
let g:Todo_txt_prefix_creation_date=0

"" filetype
" Set the 'path' option for miscellaneous file types
Plug 'tpope/vim-apathy'
Plug 'sheerun/vim-polyglot', {'do': './build'}
let g:polyglot_disabled = ['php', 'go', 'markdown', 'liquid']
Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; python2 generate.py' }
" reloading vim files
" Plug 'xolox/vim-reload'

"" misc
Plug 'amiorin/vim-project'

Plug 'sickill/vim-pasta'

Plug 'godlygeek/tabular', {'for': ['cucumber', 'markdown']}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'

Plug 'triglav/vim-visual-increment'

""" gundo
nnoremap <m-u> :GundoToggle<CR>
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1
Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}

""" vim-test
Plug 'janko-m/vim-test'
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

"" disabled plugins
" enable it occasionally to get rid of bad habits
" Plug 'phux/vim-hardtime'
" let g:hardtime_default_on = 1
"  let g:hardtime_motion_with_count_resets = 1
" let g:hardtime_ignore_quickfix = 1
" let g:hardtime_allow_different_key = 1
" Plug 'timeyyy/orchestra.nvim'
" Plug 'timeyyy/clackclack.symphony'
" Plug 'timeyyy/bubbletrouble.symphony'
call plug#end()
" call orchestra#prelude()
" call orchestra#set_tune('bubbletrouble')
" call orchestra#set_tune('clackclack')

""""""""""""""""""""""""
"  Autogroups  "
""""""""""""""""""""""""
"" Javascript
augroup js
  au!

  au FileType typescript nnoremap <buffer> gd :TSDef<CR>
  au FileType typescript nnoremap <buffer> gr :TSRefs<CR>
  au FileType typescript nnoremap <buffer> K :TSDefPreview<cr>
augroup END

"" Misc
augroup everything
  au!

  au BufNewFile,BufRead *.yml.dist set ft=yaml
  au BufRead,BufNewFile *.conf setf config
  au BufNewFile,BufRead composer.lock set ft=json

  au FileType css,less,scss let b:ale_fixers = ['prettier']

  au filetype todo setlocal omnifunc=todo#Complete
  " Auto complete projects
  au filetype todo imap <buffer> + +<C-X><C-O>
  " Auto complete contexts
  "au filetype todo imap <buffer> @ @<C-X><C-O>
  au BufNewFile,BufRead,BufEnter ~/Dropbox/notes/*.md set ft=notes.markdown

  au FileType html,xml inoremap <buffer> <m-;> </<c-x><c-o>
  au FileType html setlocal equalprg=tidy\ -indent\ -quiet\ --show-errors\ 0\ --tidy-mark\ no\ --show-body-only\ auto
  au FileType xml setlocal makeprg=xmllint\ -

  au FileType gitv nmap <buffer> <silent> <C-n> <Plug>(gitv-previous-commit)
  au FileType gitv nmap <buffer> <silent> <C-p> <Plug>(gitv-next-commit)

  au BufWritePost * silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &

  " au BufWritePost *.go silent! GoBuild! -i
augroup end


"" Nvim
augroup nvim
  au!
  au BufWritePost *.vim nested source $MYVIMRC
  au CursorHold * normal! m'
  " no delay when ESC/jk
  au InsertEnter * set timeoutlen=100
  au InsertLeave * set timeoutlen=500

  autocmd BufEnter * call ncm2#enable_for_buffer()
  " enable auto complete for `<backspace>`, `<c-w>` keys.
  " known issue https://github.com/ncm2/ncm2/issues/7
  au TextChangedI * call ncm2#auto_trigger()

  au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
  au User Ncm2PopupClose set completeopt=menuone
  au CursorHold * checktime

  au FocusLost,WinLeave * :silent! update

  autocmd VimResized * wincmd =
augroup END

""""""""""""""
"  Settings  "
""""""""""""""

set fileformats=unix,dos,mac
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set hidden
set nojoinspaces

"" insert mode completion
set complete-=i
set complete+=w

"" better command mode completion
set wildmenu
set wildmode=list:longest,full
" set wildmode=longest,list,full

"" no backups
set nobackup
set nowritebackup
set noswapfile

"" undo
set undofile " Maintain undo history between vim sessions
set undodir=~/.vim_undodir

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
color deus

function! Bright()
    set background=light
    color PaperColor
    let g:lightline['colorscheme'] = 'default'
endfunction

let g:lightline = {
            \ 'colorscheme': 'deus',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'filename': 'LightlineFilename',
\   'gitbranch': 'fugitive#head'
            \ },
            \ }

function! LightlineFilename()
  return @% !=# '' ? @% : '[No Name]'
endfunction
""""""""""""""
"  Mappings  "
""""""""""""""

"" pasting
" Copy to Clipboard (on Unix)
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

nnoremap <leader><tab> :Buffers<cr>
nnoremap <leader><Enter> :Buffers<cr>
nnoremap <leader>, :FilesMru --tiebreak=index<cr>
nnoremap <leader>. :FZFAllFiles<cr>
nnoremap <leader>d :BTags<cr>
nnoremap <leader>D :BTags <C-R><C-W><cr>
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
vnoremap <leader>] :%Subvert//g<left><left>

"" qf/loc list toggle
nmap <silent> <c-p> :cp<cr>
nmap <silent> <c-n> :cn<cr>
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

"" format html (each tag on it's own line)
" nnoremap <leader><F3> :%s/<[^>]*>/\r&\r/g<cr>gg=G:g/^$/d<cr><leader>

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

"" completion
inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")
inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"

"""""""""""""
"  Folding  "
"""""""""""""
"" Settings
set foldenable
" set foldmethod=marker
let g:xml_syntax_folding = 1
let g:sh_fold_enabled= 7
let g:ruby_fold = 1
" set foldlevel=1
set foldnestmax=4
set foldlevelstart=99

"" Mappings
" "Refocus" folds
nnoremap <leader>z zMzvzz
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
     "              \ set foldcolumn=2 foldminlines=2
augroup END

""""""""""""""""""
"  Unsorted yet  "
""""""""""""""""""
command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

set confirm


nnoremap <silent> <leader>w :lclose<cr>:w<cr>
nnoremap <silent> <leader>w :update<cr>

set noshowmode
set noruler

filetype plugin indent on
syntax on

set scrolloff=5
set shiftround
set tabstop=4
set shiftwidth=4
set expandtab smarttab
set lazyredraw


set textwidth=0
" keep marks
set viminfo='100,f1
set nostartofline

set ignorecase smartcase
set hlsearch
set incsearch

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
nnoremap <silent> <m-d> :bp<bar>sp<bar>bn<bar>bd<CR>

nnoremap <leader>gp :!git push<cr>

" wordwise upper line completion in insert mode
inoremap <expr> <c-y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

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
imap jk <esc>
