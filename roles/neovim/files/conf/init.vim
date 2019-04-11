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

let g:AutoPairsMapSpace = 0
let g:AutoPairsShortcutToggle = '<s-f12>'
Plug 'jiangmiao/auto-pairs'

"" plantuml
Plug 'scrooloose/vim-slumlord', {'for': ['uml', 'markdown']}
Plug 'aklt/plantuml-syntax', {'for': 'uml'}

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': 'yarn install --frozen-lockfile'}
Plug 'Shougo/neco-vim', {'for': 'vim'}
Plug 'neoclide/coc-neco', {'for': 'vim'}

"" php
Plug 'phux/php-doc-modded', {'for': 'php'}
Plug 'sahibalejandro/vim-php', {'for': ['php', 'yaml']}
Plug 'alvan/vim-php-manual', {'for': 'php'}
let g:vim_php_refactoring_use_default_mapping = 0
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'phpactor/phpactor', {'for': 'php', 'do': ':call phpactor#Update()', 'branch': 'develop'}

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

"" UI
Plug 'itchyny/lightline.vim'
Plug 'simeji/winresizer', {'on': 'WinResizerStartResize'}
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

"" search/navigate

" smart search highligting
Plug 'pgdouyon/vim-evanesco'

Plug 'wellle/targets.vim'

" quickfix improvements
Plug 'romainl/vim-qf'

Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

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

""" ferret
let g:FerretHlsearch=1
Plug 'wincent/ferret', {'on': 'Ack'}
nnoremap <leader>/ :Ack <c-r><c-w><cr>
nnoremap <leader>rip :Acks /<c-r><c-w>/<c-r><c-w>/gc<left><left><left>

"" git
Plug 'gregsexton/gitv', {'on': 'Gitv'}

Plug 'airblade/vim-gitgutter'

""" fugitive
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gl :Gitv<cr>
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

"" todo
""" todo.txt
Plug 'dbeniamine/todo.txt-vim', {'for': 'text'}

"" filetype
" Set the 'path' option for miscellaneous file types
Plug 'tpope/vim-apathy'
Plug 'stephpy/vim-yaml', {'for': 'yaml'}
" Plug 'elzr/vim-json', {'for': 'json'}
Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; python2 generate.py' }
let g:ansible_unindent_after_newline = 1

"" misc
Plug 'amiorin/vim-project'

Plug 'godlygeek/tabular', {'for': ['cucumber', 'markdown']}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'

Plug 'triglav/vim-visual-increment'

""" gundo
nnoremap <m-u> :MundoToggle<CR>
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}

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

Plug 'maxbrunsfeld/vim-yankstack'
Plug 'neomake/neomake'
call plug#end()

call neomake#configure#automake('w')
let g:neomake_echo_current_error=0
let g:neomake_open_list = 2

""""""""""""""""""""""""
"  Autogroups  "
""""""""""""""""""""""""
"" Javascript
augroup js
  au!
  au BufNewFile,BufRead,BufEnter *.java,*.js :NeomakeDisableBuffer
augroup END

"" Misc
augroup misc
  au!

  au BufNewFile,BufRead *.yml.dist set ft=yaml
  au BufRead,BufNewFile *.conf setf config
  au BufNewFile,BufRead composer.lock set ft=json

  au BufNewFile,BufRead,BufEnter ~/Dropbox/notes/*.md set ft=markdown.notes

  au FileType html,xml inoremap <buffer> <m-;> </<c-x><c-o>
  au FileType html setlocal equalprg=tidy\ -indent\ -quiet\ --show-errors\ 0\ --tidy-mark\ no\ --show-body-only\ auto
  au FileType xml setlocal makeprg=xmllint\ -

  au FileType gitv nmap <buffer> <silent> <C-n> <Plug>(gitv-previous-commit)
  au FileType gitv nmap <buffer> <silent> <C-p> <Plug>(gitv-next-commit)

  au BufWritePost * if &filetype != 'java' | silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' & | endif
augroup END

augroup golang
    au!
    au BufEnter *.go silent! call SetGoBuildTags()
augroup end

function! SetGoBuildTags()
    let l:line = getline(1)
    if l:line =~# '// +build'
        let l:tags = substitute(l:line, '// +build', '', 'g')
        exe ':GoBuildTags '.l:tags
    else
        let g:go_build_tags=''
    endif
endfunction

"" Nvim
augroup nvim
  au!
  au BufWritePost *.vim nested source $MYVIMRC
  au CursorHold * checktime
  au FocusLost,WinLeave * :silent! update
  autocmd VimResized * wincmd =
augroup END

nnoremap <c-e> :WinResizerStartResize<cr>

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
set completeopt=menuone

"" better command mode completion
set wildmenu
set wildmode=list:longest,full

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

color nord

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

let g:lightline = {
            \ 'colorscheme': 'nord',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'neomake_state', 'coc_state' ] ]
            \ },
            \ 'inactive': {
            \   'left': [ [ 'conflicted_name' ] ],
            \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
            \ },
            \ 'component_function': {
            \   'filename': 'LightlineFilename',
            \   'gitbranch': 'fugitive#head',
            \   'conflicted_name': 'ConflictedVersion',
            \   'neomake_state': 'SpinnerText',
            \   'coc_state': 'coc#status'
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
nnoremap <leader>, :FZF<cr>
nnoremap <leader>, :FilesMru<cr>
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

nnoremap <silent> <leader>w :w<cr>

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
" set max syntax highlighting column to sane level
set synmaxcol=250

set textwidth=0
" keep marks
set viminfo='100,f1
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
nnoremap <silent> <m-d> :bp<bar>sp<bar>bn<bar>bd<CR>

nnoremap <leader>gp :!git push<cr>

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

" override nord visual highlighting

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

let g:neomake_error_sign = {'text': ':(', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': ':/','texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {
            \   'text': ':>',
            \   'texthl': 'NeomakeWarningSign',
            \ }
let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
" display warning for phpcs error
function! SetWarningType(entry)
    let a:entry.type = 'W'
endfunction

function! SetErrorType(entry)
    let a:entry.type = 'E'
endfunction

function! SetMessageType(entry)
    let a:entry.type = 'M'
endfunction

let s:spinner_index = 0
let s:active_spinners = 0
let s:spinner_states = ['┤', '┘', '┴', '└', '├', '┌', '┬', '┐']
let s:spinner_states = ['←', '↑', '→', '↓']
let s:spinner_states = ['■', '□', '▪', '▫', '▪', '□', '■']
let s:spinner_states = ['←', '↖', '↑', '↗', '→', '↘', '↓', '↙']
let s:spinner_states = ['d', 'q', 'p', 'b']
let s:spinner_states = ['|', '/', '--', '\', '|', '/', '--', '\']
let s:spinner_states = ['.', 'o', 'O', '°', 'O', 'o', '.']
function! StartSpinner()
    let b:show_spinner = 1
    let s:active_spinners += 1
    if s:active_spinners == 1
        let s:spinner_timer = timer_start(1000 / len(s:spinner_states), 'SpinSpinner', {'repeat': -1})
    endif
endfunction

function! StopSpinner()
    let b:show_spinner = 0
    let s:active_spinners -= 1
    if s:active_spinners == 0
        :call timer_stop(s:spinner_timer)
    endif
endfunction

function! SpinSpinner(timer)
    let s:spinner_index = float2nr(fmod(s:spinner_index + 1, len(s:spinner_states)))
    redraw
endfunction

function! SpinnerText()
    if get(b:, 'show_spinner', 0) == 0
        return ' '
    endif

    return s:spinner_states[s:spinner_index]
endfunction

augroup neomake_hooks
    au!
    autocmd User NeomakeJobInit :call StartSpinner()
    " autocmd User NeomakeJobInit :echom "Build started"
    autocmd User NeomakeFinished :call StopSpinner()
    " autocmd User NeomakeFinished :echom "Build complete"
augroup END

function! s:show_documentation()
  if &filetype ==# 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>gr <Plug>(coc-rename)
vmap <leader>gf <Plug>(coc-format-selected)
nmap <leader>gf <Plug>(coc-format)

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

command! -nargs=0 Prettier :CocCommand prettier.formatFile

function! CustomHighlighting() abort
    hi Comment ctermfg=darkgray
    hi Visual ctermfg=7 ctermbg=4
    hi BufTabLineCurrent ctermfg=2 ctermbg=8
    hi Folded ctermfg=4
endfunction
call CustomHighlighting()

augroup NordColors
    autocmd!
    autocmd ColorScheme nord call CustomHighlighting()
augroup END

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

call coc#add_extension('coc-css', 'coc-html', 'coc-lists', 'coc-ultisnips', 'coc-json', 'coc-tsserver', 'coc-tslint', 'coc-yaml', 'coc-prettier', 'coc-pyls', 'coc-eslint', 'coc-yank')

" gherkin: check step usages
" let @s='?/\^?s+2y/\("\|\$\):lvimgrep /<C-R>"/j tests/features/*.feature<CR>:lopen<CR>'

nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

nnoremap <c-f> :%!python -m json.tool<cr>

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
    :%s/&/\r/g
    DT
endfunction

" resize windows to text length/height
nnoremap <expr><silent> <c-w>_ (v:count ? v:count : float2nr(ceil(eval(join(map(getline(1,'$'),'max([winwidth(0),virtcol([v:key+1,"$"])])'),'+'))/str2float(winwidth(0).'.0'))))."\<c-w>_"
nnoremap <expr><silent> <c-w><bar> (v:count ? v:count : max(map(getline(1,'$'),'virtcol([v:key+1,"$"])'))-1)."\<c-w>\<bar>"

nnoremap <m-p> <Plug>yankstack_substitute_older_paste

command! Messages :redir => bufout | silent :messages | redir end | new | call append(0, split(bufout, '\n'))


nnoremap <silent> <leader>D  :exe 'CocList -I --normal --input='.expand('<cword>').' symbols'<CR>
