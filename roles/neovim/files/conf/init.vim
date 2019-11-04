" vint: -ProhibitCommandRelyOnUser
" vint: -ProhibitCommandWithUnintendedSideEffect

""""""""""""""""""
"  nvim startup  "
""""""""""""""""""
if has('vim_starting')
  syntax on
  set nofoldenable

  " Disable unnecessary default plugins
  let g:loaded_gzip              = 1
  let g:loaded_tar               = 1
  let g:loaded_tarPlugin         = 1
  let g:loaded_zip               = 1
  let g:loaded_zipPlugin         = 1
  let g:loaded_rrhelper          = 1
  let g:loaded_2html_plugin      = 1
  let g:loaded_vimball           = 1
  let g:loaded_vimballPlugin     = 1
  let g:loaded_getscript         = 1
  let g:loaded_getscriptPlugin   = 1
  let g:loaded_logipat           = 1
  let g:loaded_matchparen        = 1
  let g:loaded_man               = 1
endif

" undefine the original behavior of that key, so that it does not interfer or trigger inadvertently:
nnoremap <Space> <Nop>
let mapleader = "\<Space>"

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

"" auto-pairs
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsMapSpace = 0
let g:AutoPairsShortcutToggle = '<s-f12>'

"" plantuml
Plug 'aklt/plantuml-syntax', {'for': 'uml'}

"" coc.nvim
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
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
    call CocAction('doHover')
endfunction
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>gr <Plug>(coc-rename)
vmap <leader>gf <Plug>(coc-format-selected)
nmap <leader>R <Plug>(coc-refactor)

nnoremap <silent> <leader>D  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <leader>d  :<C-u>CocList outline<cr>
nnoremap <leader>gg :<C-u>CocCommand git.
nnoremap <leader>gW :<C-u>CocCommand git.chunkStage<cr>
nnoremap <silent> gb :CocCommand git.browserOpen<cr>
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap gs <Plug>(coc-git-chunkinfo)
nmap gc <Plug>(coc-git-commit)
nnoremap <silent> <space>y  :<C-u>CocList --normal yank<cr>

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
Plug 'tweekmonster/fzf-filemru'
Plug 'zackhsi/fzf-tags'
nmap <C-]> <Plug>(fzf_tags)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

nnoremap <leader><tab> :Buffers<cr>
nnoremap <leader>, :FilesMru<cr>
nnoremap <leader>. :FZFAllFiles<cr>
nnoremap <leader><enter> :Tags<cr>
nnoremap <leader>a :Rg<space>
nnoremap <leader>A ::let @/=expand('<cword>')<cr> :RgRaw -t
nnoremap <m-r> :exec "Rg ".expand("<cword>")<cr>
vnoremap // "hy:exec "Find ".escape('<C-R>h', "/\.*$^~[()")<cr>
nnoremap <m-s-r> :exec "Find ".expand("<cword>")<cr>

""" fzf commands
command! -bang -nargs=* RgRaw
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case  --colors "match:bg:yellow" --colors "match:fg:black" --colors "match:style:nobold" --colors "path:fg:green" --colors "path:style:bold" --colors "line:fg:yellow" --colors "line:style:bold" '.<q-args>, 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case  --colors "match:bg:yellow" --colors "match:fg:black" --colors "match:style:nobold" --colors "path:fg:green" --colors "path:style:bold" --colors "line:fg:yellow" --colors "line:style:bold" '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --no-ignore --hidden --smart-case  --color=always --colors "match:bg:yellow" --colors "match:fg:black" --colors "match:style:nobold" --colors "path:fg:green" --colors "path:style:bold" --colors "line:fg:yellow" --colors "line:style:bold" --glob "!.git/*" '.shellescape(<q-args>), 1, <bang>0)

command! -bang -nargs=* FZFAllFiles call fzf#run({'source': 'find * -type f', 'sink': 'e'})

"" UI

Plug 'simeji/winresizer', {'on': 'WinResizerStartResize'}
nnoremap <c-e> :WinResizerStartResize<cr>

Plug 'ap/vim-buftabline'
let g:buftabline_show = 1 " display only if more than 1 buffer open

Plug 'arcticicestudio/nord-vim'

Plug 'etdev/vim-hexcolor', {'for': ['css']}

""" echodoc
Plug 'Shougo/echodoc.vim'
let g:echodoc_enable_at_startup=1
" default nord color lets not identify current argument
let g:echodoc#highlight_arguments = 'SpellCap'

""" lightline
Plug 'itchyny/lightline.vim'
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


"" markdown
" Plug 'reedes/vim-lexical', {'for': []}
Plug 'plasticboy/vim-markdown', {'for': ['markdown'], 'as': 'vim-markdown-plasticboy'}
Plug 'tpope/vim-markdown', {'for': 'markdown'}

""" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'for': ['markdown'],  'do': 'cd app & yarn install'  }
let g:mkdp_path_to_chrome = 'chromium-browser'
let g:mkdp_auto_close = 1
let g:mkdp_auto_start = 0

"" search/navigate

" smart search highligting
let g:CoolTotalMatches = 1
Plug 'romainl/vim-cool'

Plug 'wellle/targets.vim'

" quickfix improvements
let g:qf_auto_resize = 1

Plug 'majutsushi/tagbar', {'on': 'TagbarOpenAutoClose'}
nnoremap <leader>; :TagbarOpenAutoClose<cr>

""" sneak
Plug 'justinmk/vim-sneak'
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

""" easymotion
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
nmap <Leader>f <Plug>(easymotion-bd-w)
nmap <Leader>F <Plug>(easymotion-overwin-w)
" nnoremap s <Plug>(easymotion-s)
" nmap  <Leader>b <Plug>(easymotion-b)

let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1 " US layout

" """ nerdtree
" Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
" let g:NERDTreeUpdateOnCursorHold = 0
" let g:NERDTreeQuitOnOpen = 0
" let g:NERDTreeWinSize = 40
" let g:NERDTreeMinimalUI=1
" let g:NERDTreeCascadeSingleChildDir=0
" let g:NERDTreeAutoDeleteBuffer=1
" nnoremap <leader>n :NERDTreeToggle<cr>
" nnoremap <leader>N :NERDTreeFind<cr>
" nnoremap <leader>n :CocCommand explorer<cr>

""" netrw
Plug 'justinmk/vim-dirvish'
let g:netrw_banner = 0
nnoremap - :Expl<cr>

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

Plug 'lambdalisue/vim-improve-diff'
Plug 'whiteinge/diffconflicts'

" """ gv
Plug 'junegunn/gv.vim'
nnoremap <silent> <leader>gl :GV<cr>
nnoremap <silent> <leader>gL :GV!<cr>
vnoremap <silent> <leader>gl :GV<cr>
vnoremap <silent> <leader>gL :GV?<cr>

""" fugitive
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gs :Ge :<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit -v<cr>
nnoremap <leader>gd :Gdiffsplit<cr>

"" notes
Plug 'xolox/vim-notes', {'on': ['SearchNotes', 'Note', 'RecentNotes']} | Plug 'xolox/vim-misc'
let g:notes_directories = ['~/Dropbox/notes']
let g:notes_suffix = '.md'
let g:notes_smart_quotes = 0
Plug 'rhysd/vim-notes-cli'

let g:scratch_auto_height = 1
let g:scratch_persistence_file = '.scratch.vim'
Plug '~/code/scratch.vim'
nnoremap <m-z> :Scratch<cr>
nnoremap <leader>z :ScratchPreview<cr>

"" todo
""" simple-todo
Plug 'vitalk/vim-simple-todo'
let g:simple_todo_map_keys = 0
let g:simple_todo_list_symbol = '*'
nmap <silent> <m-i> :call SmartInsertTodo()<cr>
imap <silent> <m-i> <esc>:call SmartInsertTodo()<cr>a
nmap <m-o> <Plug>(simple-todo-below)
imap <m-o> <Plug>(simple-todo-below)
imap <m-space> <Plug>(simple-todo-mark-switch)a
nmap <m-space> <Plug>(simple-todo-mark-switch)

function! SmartInsertTodo()
  " already todo in this line?
  if getline('.') =~# '\[.\]'
    return
  endif

  " is list?
  if getline('.') =~# '^\s*\*'
    let l:was_at_eol =  col('.') == col('$')-1

    s/*\s*//
    exec "normal \<Plug>(simple-todo-new-list-item-start-of-line)"
    if l:was_at_eol
      normal! $
    else
      normal! 4l
    endif
  else
    " must be normal todo
    exec "normal \<Plug>(simple-todo-new-start-of-line)"
  endif
endfunction


""" todo.txt
Plug 'freitass/todo.txt-vim', {'for': 'text'}

"" filetype
Plug 'stephpy/vim-yaml', {'for': 'yaml'}

Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; python2 generate.py', 'for': 'yaml'}
let g:ansible_unindent_after_newline = 1

"" misc
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'triglav/vim-visual-increment'

" Plug 'phux/vim-marker'
Plug '~/code/vim-marker'

" Filetype-specific mappings for [[ and ]]
Plug 'arp242/jumpy.vim'

Plug 'lifepillar/pgsql.vim', {'for': 'sql'}
let g:sql_type_default = 'pgsql'

Plug 'oguzbilgic/vim-gdiff'
nnoremap ]r :%bd<CR>:cnext<CR>:Gdiffsplit
nnoremap [r :%bd<CR>:cprevious<CR>:Gdiffsplit
nnoremap ]R :%bd<CR>:clast<CR>:Gdiffsplit
nnoremap [R :%bd<CR>:cfirst<CR>:Gdiffsplit

Plug 'romainl/vim-devdocs', {'on': 'DD'}
nmap <leader>K :DD<cr>

""" tabular
Plug 'godlygeek/tabular', {'for': ['cucumber', 'markdown', 'sql']}
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

""" untotree
Plug  'mbbill/undotree'
nnoremap <m-u> :UndotreeToggle<cr>

""" SplitJoin
Plug 'AndrewRadev/splitjoin.vim', {'on': ['SplitjoinSplit', 'SplitjoinJoin']}
nnoremap <leader>j :SplitjoinSplit<cr>
nnoremap <leader>k :SplitjoinJoin<cr>

""" commentary
Plug 'tpope/vim-commentary', {'on': 'Commentary'}
nnoremap <leader>c :Commentary<cr>
vnoremap <leader>c :Commentary<cr>

""" ale
Plug 'w0rp/ale'
let g:ale_warn_about_trailing_whitespace=0
let g:ale_lint_on_enter=0
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_insert_leave=0
let g:ale_disable_lsp=1
let g:ale_open_list = 0
let g:ale_fix_on_save = 1
let g:ale_set_quickfix=1
Plug 'maximbaz/lightline-ale'

""" abolish
Plug 'tpope/vim-abolish'
nnoremap <leader>] :%Subvert/<c-R><c-w>/<c-r><c-w>/g<left><left>
nnoremap <leader>[ :Subvert/<c-R><c-w>/<c-r><c-w>/g<left><left>
vnoremap <leader>] :Subvert//g<left><left>
vnoremap <leader>[ :Subvert/<c-R><c-w>/<c-r><c-w>/g<left><left>

""" hardtime
Plug 'takac/vim-hardtime'
let g:hardtime_default_on = 1
let g:hardtime_ignore_quickfix = 1
let g:hardtime_maxcount = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_ignore_buffer_patterns = ["coc-explorer"]

""" ranger
Plug 'francoiscabrol/ranger.vim' | Plug 'rbgrouleff/bclose.vim'
" let g:ranger_replace_netrw = 0
let g:ranger_map_keys = 0
nnoremap <leader>n :RangerWorkingDirectory<cr>
nnoremap <leader>N :RangerCurrentFile<cr>

call plug#end()

"""""""""""""""""""""""
"  Autogroups  "
""""""""""""""""""""""""
"" Misc
augroup misc
  au!

  au BufNewFile,BufRead *.yml.dist set ft=yaml
  au BufRead,BufNewFile *.conf setf config
  au BufNewFile,BufRead composer.lock set ft=json

  au BufNewFile,BufRead,BufEnter ~/Dropbox/notes/*.md set ft=markdown.notes

  au FileType html,xml inoremap <buffer> <m-;> </<c-x><c-o>

  autocmd FileType typescript,json,html setl formatexpr=CocAction('formatSelected')
  au FileType xml setlocal makeprg=xmllint\ -

  au FocusLost,WinLeave * :silent! update
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0
        \| autocmd BufLeave <buffer> set laststatus=2

  au BufWritePost *.go silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
  au FileType qf call AdjustWindowHeight(3, 10)

  " autocmd FileType netrw,dirvish setl bufhidden=wipe
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" https://vim.fandom.com/wiki/Automatically_fitting_a_quickfix_window_height
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line('$'), a:maxheight]), a:minheight]) . 'wincmd _'
endfunction

"" Nvim
augroup nvim
  au!
  au BufWritePost *.vim nested source $MYVIMRC
  autocmd VimResized * wincmd =
augroup END

""""""""""""""
"  Settings  "
""""""""""""""

filetype plugin indent on

set encoding=UTF-8
scriptencoding utf-8

set fileformats=unix,dos,mac
set autowriteall                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set hidden

set foldcolumn=0        " do not show foldcolumn
set tags^=./.git/tags;
set confirm
set noshowmode
set noruler

set scrolloff=5
set tabstop=2
set shiftwidth=2
set shiftround
set smarttab        " insert blanks according to shiftwidth
set expandtab       " use spaces instead of TAB
set softtabstop=-1  " the number of spaces that a TAB counts for
set shiftwidth=4    " the number of spaces of an indent
set shiftround      " round indent to multiple of shiftwidth with > and <
set textwidth=0     " do not automatically wrap text

set autoindent      " copy indent from current line when starting a new line
set smartindent     " smarter autoindent
set copyindent      " copy the structure of the existing lines indent when
                    " autoindenting a new line
set preserveindent  " Use :retab to clean up whitespace

set splitright

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" t - auto-wrap text using textwidth
" c - auto-wrap comments using textwidth, inserting the
"     current comment leader automatically
" r - automatically insert the current comment leader after
"     hitting <Enter> in Insert mode
" o - automatically insert the current comment leader after
"     hitting o in Normal mode
" n - when formatting text, recognize numbered lists
" l - long lines are not broken in insert mode
" m - also break at a multi-byte character above 255.
" B - when joining lines, don't insert a space between two
"     multi-byte characters
" j - where it make sense, remove a comment leader when
"     joining lines
set formatoptions&
      \ formatoptions+=r
      \ formatoptions-=o
      \ formatoptions+=n
      \ formatoptions+=m
      \ formatoptions+=B
      \ formatoptions+=j
" set formatoptions=qrn1tclj
set nojoinspaces

" keep marks
" set viminfo='100,\"90,h,%
set nostartofline

set ignorecase smartcase
set hlsearch
set incsearch
set inccommand=split
set grepprg=rg\ --vimgrep

set timeout ttimeoutlen=0
"" insert mode completion
set complete-=i
set complete+=w
set completeopt-=preview

"" better command mode completion
set wildmenu
set wildmode=list:longest,full
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

set lazyredraw
" set max syntax highlighting column to sane level
set synmaxcol=250

set number
set relativenumber

" Set the command window height to 1 lines
set cmdheight=1
" This makes more sense than the default of 1
set winminheight=1


set showbreak=↪
" set breakindent
set breakindentopt=sbr

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
color nord
set background=dark
hi Comment ctermfg=gray
hi BufTabLineCurrent ctermfg=2 ctermbg=8
hi Visual ctermfg=7 ctermbg=4
hi Folded ctermfg=4
hi Search ctermfg=0 ctermbg=10


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


"" qf/loc list toggle
nmap <c-p> :cp<cr>
nmap <c-n> :cn<cr>
let g:qf_loc_toggle_binds = 1
function! ToggleQfLocListBinds()
  if g:qf_loc_toggle_binds == 1
    nmap <c-p> :lp<cr>
    nmap <c-n> :lnext<cr>
    let g:qf_loc_toggle_binds = 0
    echo 'loc binds loaded'
  else
    let g:qf_loc_toggle_binds = 1
    nmap <c-p> :cp<cr>
    nmap <c-n> :cn<cr>
    echo 'qf binds loaded'
  endif
endfunction
nmap <m-t> :call ToggleQfLocListBinds()<cr>


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
  let g:lightline['colorscheme'] = 'github'
endfunction

"" unsorted
nnoremap <silent> <leader>w :w<cr>

" replace ex mode map and use it for repeating 'q' macro
nnoremap Q @q

inoremap <c-l> <del>

" keep selection after indent
vnoremap < <gv
vnoremap > >gv
nnoremap <m-l> :bn<cr>
nnoremap <m-h> :bp<cr>

nnoremap <leader>x <c-w>c
nnoremap <leader>s <c-w>v

" close quick- & locationlist
nnoremap <silent> <m-,> :lclose<cr>:cclose<cr>
" remove buffer without deleting window
nnoremap <silent> <m-d> :bp<bar>bd #<cr>

"""""""""""""
"  Folding  "
"""""""""""""
"" only fold init.vim on initial load
if !exists('g:init_vim_folded')
    set foldlevel=0
    let g:init_vim_folded=1
endif

"" Settings
let g:xml_syntax_folding = 1
let g:sh_fold_enabled= 7
let g:ruby_fold = 1
set foldnestmax=4
" set foldlevelstart=99

"" Mappings

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
  endif
  if (match(s:thisline, '^"""""') >= 0) &&
        \ (match(s:line_1_after, '^"  ') >= 0) &&
        \ (match(s:line_2_after, '^""""') >= 0)
    return '>1'
  else
    return '='
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
        \ setlocal foldenable |
        \ setlocal foldmethod=expr |
        \ setlocal foldexpr=VimFolds(v:lnum) |
        \ setlocal foldtext=VimFoldText() |
  "              \ set foldcolumn=2 foldminlines=2
augroup END

""""""""""""""""""
"  Unsorted yet  "
""""""""""""""""""

" let g:project_use_nerdtree = 0
" let g:project_enable_welcome = 0
" nnoremap <F1> :e ~/.config/nvim/projects.public.vim<cr>
" nnoremap <leader><F2> :e ~/.projects.private.vim<cr>
" set runtimepath+=~/.config/nvim/plugged/vim-project/
" call project#rc('~/code')
" if filereadable(expand('~/.config/nvim/projects.public.vim'))
"     so ~/.config/nvim/projects.public.vim
" endif

"" IsOnBattery
function! IsOnBattery()
  " might be AC instead of ACAD on your machine
  return readfile('/sys/class/power_supply/ACAD/online') == ['0']
endfunction

nnoremap <silent> <leader><f5> :e $MYVIMRC<CR>

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
" let progname = substitute($VIM, '.*[/\\]', '', '')
" set title titlestring=%{progname}\ %f\ +%l\ #%{tabpagenr()}.%{winnr()}
" if &term =~# '^screen' && !has('nvim') | exe "set t_ts=\e]2; t_fs=\7" | endif

let g:tmux_navigator_disable_when_zoomed=1

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
      \ 'coc-sh',
      \ 'coc-docker',
      \ 'coc-git',
      \ 'coc-calc',
      \ 'coc-post',
      \ 'coc-vimlsp',
      \ 'coc-lists',
      \ 'coc-yank',
      \ 'coc-sql',
      \ 'coc-explorer'
      \ )
      " \ 'coc-phpls',
      " \ 'coc-go'
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


nnoremap <m-q> :call LocListToggle()<cr>
function! LocListToggle()
  if g:qf_loc_toggle_binds == 0
    let l:prefix = 'l'
    let l:is_open = [] != filter(getwininfo(), 'v:val.quickfix && v:val.loclist')
    echo 'using locationlist'
  else
    let l:prefix = 'c'
    let l:is_open = [] != filter(getwininfo(), 'v:val.quickfix && !v:val.loclist')
    echo 'using quickfix'
  endif

  if l:is_open
    execute l:prefix.'close'
  else
    execute l:prefix.'open'
  endif
endfunction

" vnoremap // :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
" function! s:GrepFromSelected(type)
"   let saved_unnamed_register = @@
"   if a:type ==# 'v'
"     normal! `<v`>y
"   elseif a:type ==# 'char'
"     normal! `[v`]y
"   else
"     return
"   endif
"   let word = substitute(@@, '\n$', '', 'g')
"   let word = escape(word, '| ')
"   let @@ = saved_unnamed_register
"   execute 'CocList grep '.word
" endfunction

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'remove_trailing_lines', 'trim_whitespace'],
\   'sh': ['shfmt', 'remove_trailing_lines', 'trim_whitespace'],
\   'json': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
\   'markdown': ['prettier', 'textlint', 'remove_trailing_lines', 'trim_whitespace'],
\   'text': ['textlint', 'remove_trailing_lines', 'trim_whitespace'],
\   'go': ['goimports', 'remove_trailing_lines', 'trim_whitespace'],
\}

nnoremap ' `

so ~/.local.init.vim

nnoremap <leader><enter> :silent update<Bar>silent !xdg-open %:p &<CR>

"" tabs
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap td :tabclose<CR>
nnoremap tc :tabclose<CR>
nnoremap tn :tabnew<CR>
