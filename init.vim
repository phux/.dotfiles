" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if &compatible
    set nocompatible
endif

" Autoinstall vim-plug {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

let mapleader = "\<Space>"

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-surround'

Plug 'ap/vim-buftabline'

Plug 'henrik/vim-indexed-search'

Plug 'scrooloose/nerdtree' , { 'on': 'NERDTreeToggle' }
let g:NERDTreeMinimalUI = 1
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeWinSize = 31
let g:NERDTreeChDirMode = 2
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeShowBookmarks = 0
let g:NERDTreeCascadeOpenSingleChildDir = 1

Plug 'tpope/vim-commentary'
Plug 'majutsushi/tagbar'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'ctrlpmark': 'CtrlPMark',
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
  return  fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
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

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction





Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:ultisnips_php_scalar_types = 1
let g:UltiSnipsSnippetsDir = '~/.vim/plugged/vim-snippets/UltiSnips/'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

Plug 'Townk/vim-autoclose'

Plug 'amiorin/vim-project'
let g:project_use_nerdtree = 0
let g:project_enable_welcome = 0
nmap <leader><F2> :e ~/dotfiles/vimprojects<cr>

Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'

Plug 'tpope/vim-unimpaired'
Plug 'YankRing.vim' | Plug 'L9'
Plug 'moll/vim-bbye'
Plug 'Lokaltog/vim-easymotion'
Plug 'matchit.zip'
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'

Plug 'nelstrom/vim-qargs'

Plug 'altercation/vim-colors-solarized'

Plug 'phux/vim-phpqa'
nmap <leader>gw :let g:phpqa_messdetector_autorun = 0<cr>:let g:phpqa_codesniffer_autorun = 0<cr>:Gwrite<cr>:let g:phpqa_messdetector_autorun = 1<cr>:let g:phpqa_codesniffer_autorun = 1<cr>
autocmd FileType php nmap <buffer> <leader>w :let g:phpqa_messdetector_autorun = 0<cr>:let g:phpqa_codesniffer_autorun = 0<cr>:w<cr>:let g:phpqa_messdetector_autorun = 1<cr>:let g:phpqa_codesniffer_autorun = 1<cr>





Plug 'adoy/vim-php-refactoring-toolbox'

let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"

let g:vim_php_refactoring_use_default_mapping = 0
nnoremap <leader>rlv :call PhpRenameLocalVariable()<CR>
nnoremap <leader>rcv :call PhpRenameClassVariable()<CR>
nnoremap <leader>rrm :call PhpRenameMethod()<CR>
nnoremap <leader>reu :call PhpExtractUse()<CR>
vnoremap <leader>rec :call PhpExtractConst()<CR>
nnoremap <leader>rep :call PhpExtractClassProperty()<CR>
vnoremap <leader>rem :call PhpExtractMethod()<CR>
nnoremap <leader>rnp :call PhpCreateProperty()<CR>
nnoremap <leader>rdu :call PhpDetectUnusedUseStatements()<CR>
vnoremap <leader>r== :call PhpAlignAssigns()<CR>
nnoremap <leader>rsg :call PhpCreateSettersAndGetters()<CR>





Plug 'shawncplus/phpcomplete.vim'
let g:phpcomplete_complete_for_unknown_classes = 0
let g:phpcomplete_relax_static_constraint=0
let g:phpcomplete_search_tags_for_variables = 0
let g:phpcomplete_parse_docblock_comments = 0
let g:phpcomplete_enhance_jump_to_definition = 1
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP





Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#syntax#min_keyword_length = 2
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#auto_complete_delay = 10

let g:deoplete#auto_refresh_delay = 5
let g:deoplete#enable_auto_delimiter = 1
let g:deoplete#max_list = 30
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.php =
            \ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'


Plug 'tobyS/pdv' | Plug 'tobyS/vmustache'
nnoremap <leader>h :call pdv#DocumentWithSnip()<CR>
let g:pdv_template_dir = $HOME."/.config/nvim/pdv_templates_snip"




Plug 'arnaud-lb/vim-php-namespace'
let g:php_namespace_sort_after_insert = 1
noremap <leader>u :call PhpInsertUse()<CR>
noremap <leader>e :call PhpExpandClass()<CR>



Plug 'joonty/vdebug'

let g:vdebug_options = {}
let g:vdebug_options["port"] = 9000
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

Plug 'StanAngeloff/php.vim'
Plug '2072/PHP-Indenting-for-VIm'
Plug 'alvan/vim-php-manual'


Plug 'evidens/vim-twig'
Plug 'avakhov/vim-yaml'

" Plug 'editorconfig/editorconfig-vim'
" Plug 'suan/vim-instant-markdown'
Plug 'phux/scratch.vim'
Plug 'vitalk/vim-simple-todo'

Plug 'fatih/vim-go'
Plug 'buoto/gotests-vim'

Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
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
autocmd VimEnter * command! -nargs=* Ag call fzf#run({
\ 'source':  printf('ag --nogroup --column --color "%s"',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })


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


vnoremap // "hy:exec "Ag ".escape('<C-R>h', "/\.*$^~[()")<cr>

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

nmap <leader>s :Tags<cr>
nmap <leader>, :Files<cr>



Plug 'Shougo/echodoc.vim'
let g:echodoc_enable_at_startup=1
set noshowmode
" set cmdheight=2

call plug#end()

set rtp+=~/.vim/bundle/vim-project/
call project#rc("~/code")

" ====================
" = Settings: General
" ====================


set nu " show line numbers
set hidden
" no backups
set nobackup
set nowritebackup
set noswapfile

" write on focus loss
au FocusLost * silent! wa

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Copy to Clipboard (on Unix)
set clipboard+=unnamed

" use open windows/tabs for buffer switching
set switchbuf=useopen,usetab

" Show partial commands in the last line of the screen
set showcmd

" Line wrapping
set wrap
" " but don't split words
set lbr
" "show this in front of broken lines
set showbreak=↪

" split new window at the right of current
set spr

" Set the command window height to 1 lines
set cmdheight=1

" This makes more sense than the default of 1
set winminheight=1

" no welcome screen
set shortmess+=filmnrxoOtT

" highlight current line
set cul

" indentation
set nojoinspaces
set tabstop=4
set shiftwidth=4
set shiftround

set expandtab
set formatoptions+=tcqlr

" highlight chars
set list
set listchars=tab:\ \ ,trail:•,extends:#,nbsp:. 

" move over lines with following keys
set whichwrap+=<,>,[,],h,l

" ------
" - Search settings
" ------

" Highlight searches
set hlsearch

" " Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" undo
set undofile                " Save undo's after file closes
set undodir=~/.undovim " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000

" Better command-line completion
set wildmenu
" set wildignore+=*.pyc,*.zip,*.gz,*.bz,*.tar,*.jpg,*.png,*.gif,*.avi,*.wmv,*.ogg,*.mp3,*.mov
set wildmode=list:longest,full

" Limit popup menu height
set pumheight=15

" ignore whitespaces when vimdiff'ing
set diffopt=iwhite


set completeopt=longest,menuone


" ====================
" = Settings: Gui
" ====================





set background=dark
" let g:solarized_termcolors=256
colorscheme solarized





" ====================
" = Settings: Plugins
" ====================


let g:PHP_removeCRwhenUnix = 1
let g:PHP_vintage_case_default_indent = 1


" let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<c-h>'

let g:vim_debug_disable_mappings = 1












" ====================
" = Mappings
" ====================




" ------
" - Mappings: General
" ------


" Edit the vimrc file
nmap <silent> <leader><f5> :e $MYVIMRC<CR>

inoremap jk <esc>

" map j to gj and k to gk, so line navigation ignores line wrap
nmap j gj
nmap k gk

" Copy Paste
vmap <leader>y "+y
vmap <leader>d "+d
cmap ,p <C-R>+

nnoremap <leader>x <c-w>c

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]


"  select pasted text
noremap gV `[v`]

nmap <leader>W :set nowrap!<CR>


" fast closing of html tags
imap ;; </<c-x><c-o>

vmap < <gv
vmap > >gv
" vmap <c-k> [egv
" vmap <c-j> ]egv

" command line bash behavior
" cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-N> <End>
cnoremap <C-P> <Up>

" delete char after cursor in insert mode, same as del key
inoremap <c-l> <del>

" jump to line AND column
nnoremap ' `
nnoremap ` '

" window switching
noremap <silent> <c-l> <c-w>l
noremap <silent> <c-j> <c-w>j
noremap <silent> <c-k> <c-w>k
noremap <silent> <c-h> <c-w>h

nnoremap <silent> <leader>K :exe "resize " . (winheight(0) * 5/4)<CR>
nnoremap <silent> <leader>J :exe "resize " . (winheight(0) * 4/5)<CR>
nnoremap <silent> <leader>H :exe "vertical resize -15"<CR>
nnoremap <silent> <leader>L :exe "vertical resize +15"<CR>

nnoremap c<C-j> :bel sp<cr>
nnoremap c<C-k> :abo sp<cr>
nnoremap c<C-h> :lefta vsp<cr>
nnoremap c<C-l> :rightb vsp<cr>
nnoremap g<C-j> <C-w>j<C-w>_
nnoremap g<C-k> <C-w>k<C-w>_
nnoremap g<C-h> <C-w>h<C-w>_
nnoremap g<C-l> <C-w>l<C-w>_
nnoremap d<C-j> <C-w>j<C-w>c
nnoremap d<C-k> <C-w>k<C-w>c
nnoremap d<C-h> <C-w>h<C-w>c
nnoremap d<C-l> <C-w>l<C-w>c

noremap <silent> <leader>tn :ptn<cr>
noremap <silent> <leader>tp :ptp<cr>
noremap <silent> <leader>tc :pc<cr>


" tag bindings
nmap <leader>o <c-w>g}

" delete word after cursor in insert mode
" inoremap <c-s-l> <c-o>dw

" Adjust viewports to the same size
map <leader>= <C-w>=

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" unmark search matches
nmap <silent> ,/ :nohlsearch<CR>

" Refactor names easily (hit <leader>[ or <leader>] with cursor on the word you'd like to rename

nnoremap <leader>[ :%s/<c-r><c-w>/<c-r><c-w>/g<left><left>
nnoremap <leader>] :%SubstituteCase/\c<c-R><c-w>/<c-r><c-w>/g<left><left>

" reformat html -> each tag on own row
nmap <leader><F3> :%s/<[^>]*>/\r&\r/g<cr>gg=G:g/^$/d<cr><leader>/

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>

nnoremap <c-tab> :b#<cr>

" ------
" - Mappings: Plugins
" ------


vmap <Enter> <Plug>(EasyAlign)

nmap <leader>z :Scratch<cr>

nmap <leader>; :TagbarToggle<cr>


nmap <leader>gs :Gstatus<cr>
nmap <leader>gc :Gcommit<cr>
" nmap <leader>gb :Gbrowse<cr>
nmap <leader>gp :!git push<cr>

nmap <leader>gv :Gitv<cr>

nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>N :NERDTreeFind<cr>


command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'


nnoremap <silent> <leader>y :YRShow<CR>

let g:scratch_top = 1
let g:scratch_persistence_file = '.scratch.vim'
"au FileType scratch setl ts=2 sw=2 fo+=n2a

let g:simple_todo_map_keys = 0
nmap ,i <Plug>(simple-todo-new)
imap ,i <Plug>(simple-todo-new)
nmap ,I <Plug>(simple-todo-new-start-of-line)
imap ,I <Plug>(simple-todo-new-start-of-line)
nmap ,o <Plug>(simple-todo-below)
imap ,o <Plug>(simple-todo-below)
nmap ,O <Plug>(simple-todo-above)
imap ,O <Plug>(simple-todo-above)
nmap ,x <Plug>(simple-todo-mark-as-done)
imap ,x <Plug>(simple-todo-mark-as-done)
nmap ,X <Plug>(simple-todo-mark-as-undone)
imap ,X <Plug>(simple-todo-mark-as-undone)
nmap ,s <Plug>(simple-todo-new-list-item)
imap ,s <Plug>(simple-todo-new-list-item)


nnoremap <leader>c :Commentary<cr>
vnoremap <leader>c :Commentary<cr>

nmap <leader>bd :Bdelete<cr>
nmap <leader>bg :call SwitchLightAndDarkTheme()<cr>

function! SwitchLightAndDarkTheme()
    if &background == "dark"
        :colorscheme solarized
        :let &background =  "light"
    else
        :colorscheme solarized
        :let &background = "dark"
    endif
endfunction

" ====================
" = Custom functions
" ====================

function! FormatPHPLineLength()
    let l:currentLine = getline('.')
    let l:isFunctionCallOrDefinitionOrArray = l:currentLine =~ ',' || l:currentLine =~ ';' || l:currentLine =~ ' array(' || l:currentLine =~ '(['
    let l:isConditional = l:currentLine =~ '\s*&&' || l:currentLine =~ ' and ' || l:currentLine =~ '\s*||' || l:currentLine =~ ' or ' || l:currentLine =~ '\s*?'

    normal! $
    normal! ma
    if l:isConditional
        normal! F)
    elseif l:isFunctionCallOrDefinitionOrArray
        if l:currentLine =~ ';'
            normal! h
        else
            normal! Jh
        endif
    endif

    execute "normal! i\n"
    normal! mb
    normal! k

    if l:isConditional
        :s/\(\s*&&\| and \|\s*||\| or \| ?\| :\)/\r\1/g
    elseif l:isFunctionCallOrDefinitionOrArray
        execute "normal! 0f(a\n"
        if l:currentLine =~ ','
            :s/,\s/,\r/g
        endif
    endif
    'b
    normal! V
    'a
    normal! =
endfunction

nmap <leader>i :call FormatPHPLineLength()<cr>

let g:php_manual_online_search_shortcut = '<leader>k'

" toggles the quickfix window.
map <leader>q :QFix<cr>
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
augroup QFixToggle
    autocmd!
    autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
    autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END
let g:jah_Quickfix_Win_Height=10


function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
    else
        execute "copen " . g:jah_Quickfix_Win_Height
    endif
endfunction

au BufReadPost * call RestorePosition()

func! RestorePosition()
    if exists("g:restore_position_ignore") && match(expand("%"), g:restore_position_ignore) > -1
        return
    endif

    if line("'\"") > 1 && line("'\"") <= line("$")
        exe "normal! g`\""
    endif
endfunc

function! ExtractMethod() range
    normal gvd
    exe "normal! ma"
    let name = inputdialog("name of new method")
    let params = inputdialog("parameters separated by ,")
    exe "normal! O$ = $this->" . name . "(" . params . ");"
    ?function
    /{
    %
    exe "normal! O"
    exe "normal! oprivate function " . name ."(" . params . ")"
    exe "normal! mb"
    exe "normal! o\{"
    exe "normal! oreturn ;"
    exe "normal! o\}"
    normal kP
    'b
endfunction

" call function by:
"vmap <leader>em :call ExtractMethod()<cr>

function! ExtractVoidMethod() range
    normal gvd
    exe "normal! ma"
    let name = inputdialog("name of new method")
    let params = inputdialog("parameters separated by ,")
    exe "normal! O$this->" . name . "(" . params . ");"
    ?function
    /{
    %
    exe "normal! O"
    exe "normal! oprivate function " . name ."(" . params . ")"
    exe "normal! mb"
    exe "normal! o\{"
    normal kp
    exe "normal! o\}"
    'b
endfunction

" call function by:
vmap <leader>vem :call ExtractVoidMethod()<cr>


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

function! SwitchBetweenPhpunitAndClasses()
    let f = bufname("%")
    if f =~ '.php'
        if f =~  '/Tests/' && f =~ 'Test\.php'
            let filename = substitute(substitute(f, '/Tests/', '', ''), 'Test.php', '.php', '')
            if !filereadable(filename)
                let new_dir = substitute(filename, '/\w\+\.php', '', '')
                exe ":!mkdir -p ".new_dir
            endif
            exe ":e ".filename
        elseif f !~ 'Test\.php'
            let filename = substitute(substitute(f, 'Bundle/', 'Bundle/Tests/', ''), '.php', 'Test.php', '')
            if !filereadable(filename)
                let new_dir = substitute(filename, '/\w\+Test\.php', '', '')
                exe ":!mkdir -p ".new_dir
            endif
            exe ":e ".filename
        else
            echom "Could not switch because needed patterns not matched."
        endif
    endif
endfunction

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

nmap <leader>ta :call SymfonySwitchToAlternateFile()<cr>
nmap <leader>tsa <c-w>v:call SymfonySwitchToAlternateFile()<cr>
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
  " is there window with complent file open?
  let win = bufwinnr(l:f)
  if l:win > 0
    execute l:win . "wincmd w"
  else
    execute ":e " . l:f
  endif

endfunction


" set by vim-project
" nmap <leader>tu :call SwitchBetweenFiles1('php', 'Bundle/Tests/', 'Bundle/', 'Test')<cr>
" nmap <leader>tsu <c-w>v:call SwitchBetweenFiles1('php', 'Bundle/Tests/', 'Bundle/', 'Test')<cr>
" nmap <leader>tu :call SwitchBetweenFiles('php', 'tests/', 'library/', 'Test')<cr>
" nmap <leader>tsu <c-w>v:call SwitchBetweenFiles('php', 'tests/', 'library/', 'Test')<cr>


function! PrependTicketNumber()
    normal gg
    let l:branch = system("echo $(git branch | grep '*')")
    let l:ticketNumber = '['.substitute(l:branch, '\* \(.*\)', '\1', '').'] '
    exe "normal I".l:ticketNumber
    exe "normal gg"
    :startinsert!
endfunction

" ====================
" = Auto commands
" ====================


" insert ticket number into commit msg
autocmd FileType gitcommit nmap <buffer> <leader>w :call PrependTicketNumber()<cr>
au BufEnter * if &ft ==# 'gitcommit' | :call PrependTicketNumber() | endif

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

nmap <leader>w :w<cr>

au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &

au BufNewFile,BufRead *.html,*.html.twig,*.htm,*.shtml,*.stm set ft=html.javascript
au BufNewFile,BufRead *.phtml set ft=php.html




" ====================
" = Settings: Performance
" ====================




set nocursorcolumn
set nolazyredraw
set scrolljump=5
"syntax sync minlines=256
" set synmaxcol=200
let g:PHP_default_indenting=0


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

function! Replace(bang, replace)
    let search = '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    execute 'Ag '.expand('<cword>')
    execute 'Qargs'
    let replace = escape(a:replace, '/\&~')
    let flag = 'cge'
    execute 'argdo %s/' . search . '/' . replace . '/' . flag
endfunction
command! -nargs=1 -bang Replace :call Replace(<bang>0, <q-args>)
nnoremap <leader>rip :call Replace(0, input('Replace '.expand('<cword>').' with: ', expand('<cword>')))<CR>

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

nmap <leader>ga :Tabularize /\|<cr>
vmap <leader>ga :Tabularize /\|<cr>

au FileType cucumber setl sw=2 sts=2 et
au FileType yaml setl sw=2 sts=2 et
au FileType ruby setl sw=2 sts=2 et

augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

hi SpecialKey       guifg=#343434     guibg=NONE     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE



let g:go_bin_path = expand("~/.gvm/gos/go1.7.3/bin")
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" function! PhpSyntaxOverride()
  " hi! def link phpDocTags  phpDefine
  " hi! def link phpDocParam phpType
" endfunction

" augroup phpSyntaxOverride
  " autocmd!
  " autocmd FileType php call PhpSyntaxOverride()
" augroup END

so ~/dotfiles/vimprojects


nmap <leader><Enter> :History<cr>
nnoremap <leader>a :Ag<space>
nnoremap <leader>A :exec "Ag ".expand("<cword>")<cr>
highlight DbgBreakptLine ctermbg=none ctermfg=none

" au BufNewFile,BufRead,BufWinEnter *Test.php exe ":let g:neocomplete#sources#omni#input_patterns.php = '\\h\\w*'"
" au BufWinLeave,BufLeave *Test.php exe ':let g:neocomplete#sources#omni#input_patterns.php = "[^. \\t]->\\%(\\h\\w*\\)\\?\\|\\h\\w*::\\%(\\h\\w*\\)\\?"'

set nofoldenable
au FileType go nmap <leader>gf :GoCoverageToggle<cr>
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gt <Plug>(go-test)
au FileType go nmap <leader>gd <Plug>(go-doc)
au FileType go nmap <leader>gs <Plug>(go-implements)
au FileType go nmap <leader>ge <Plug>(go-rename)
set rtp+=~/.config/nvim/plugged/vim-project/
" custom starting path
call project#rc("~/code")
" default starting path (the home directory)
call project#rc()
