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
" Plug 'kyazdani42/nvim-web-devicons' " for file icons
" Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tweekmonster/startuptime.vim', {'on': 'StartupTime'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" Plug 'ChristianChiarulli/nvcode-color-schemes.vim'
Plug 'lifepillar/vim-gruvbox8'
"" snippets
Plug 'honza/vim-snippets'

"" auto-pairs
" Plug 'jiangmiao/auto-pairs'
" let g:AutoPairsMapSpace = 0
" let g:AutoPairsShortcutToggle = '<s-f12>'

"" lexima.vim - autopairs
Plug 'cohama/lexima.vim'

"" plantuml
" Plug 'aklt/plantuml-syntax', {'for': ['uml', 'plantuml']}
" Plug 'weirongxu/plantuml-previewer.vim', {'for': 'plantuml'} | Plug 'tyru/open-browser.vim', {'for': 'plantuml'}
" Plug 'scrooloose/vim-slumlord', {'for': ['uml', 'plantuml']}

let g:scratch_auto_height = 1
let g:scratch_persistence_file = '.scratch.vim'
Plug 'mtth/scratch.vim', {'on': ['Scratch', 'ScratchPreview']}
nnoremap <m-z> :Scratch<cr>

"" coc.nvim
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>do <Plug>(coc-codeaction-line)
xmap <leader>do  <Plug>(coc-codeaction-selected)

"" php
Plug 'phux/php-doc-modded', {'for': 'php'}
let g:vim_php_use_sort='alpha'
Plug 'sahibalejandro/vim-php', {'for': ['php', 'yaml']}
let g:vim_php_refactoring_use_default_mapping = 0
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'develop', 'do': 'composer install --no-dev -o'}

"" go
"
let g:gopher_map = 0
" Plug 'fatih/vim-go', {'for': 'go'}
Plug 'laher/gothx.vim', {'for': 'go'}
" Plug 'arp242/gopher.vim', {'for': 'go'}
Plug 'sebdah/vim-delve', {'for': 'go'}
Plug 'rhysd/vim-go-impl', {'for': 'go'}
" Plug 'tenfyzhong/reftools.vim', {'for': 'go'}
" Plug 'mattn/vim-goaddtags', {'for':'go'}
" Plug 'zchee/vim-goiferr', {'for': 'go'}
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'godoctor/godoctor.vim', {'for': 'go', 'on': 'Refactor'}
" Plug 'mattn/vim-goimpl', {'for': 'go'}

"" fzf
" Plug 'tweekmonster/fzf-filemru', {'on': ['FilesMru', 'ProjectMru']}
" Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }
Plug 'zackhsi/fzf-tags', {'on': '<Plug>(fzf_tags)'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'Normal'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }
" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
" let g:fzf_history_dir = '~/.local/share/fzf-history'
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
" let g:fzf_preview_window = ''


""" fzf commands
let g:rg_command = '
            \ rg --column --line-number --no-heading --smart-case --hidden --follow --color "always"
            \ -g "!.git" -g "!node_modules" -g "!*/vendor/*" -g "!*.neon" -g "!package-lock.json" -g "!*/composer.lock" -g "!.composer/*" -g "!*/var/*"  -g "!*/cache/*" '
let g:rg_command_all = '
            \ rg --column --line-number --no-heading -i --hidden --no-ignore --follow --color "always" '

command! -bang -nargs=* RgRaw
      \ call fzf#vim#grep(
      \   g:rg_command.<q-args>, 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

      " \   g:rg_command.shellescape(<q-args>), 1,
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   g:rg_command.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview({'options': ['--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}),
      \   <bang>0)

command! -bang -nargs=* Find call fzf#vim#grep(g:rg_command_all.' '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--info=inline']}, <bang>0)
" command! -bang -nargs=? -complete=dir Files
"     \ call fzf#vim#gitfiles(<q-args>, {'options': ['--info=inline' ]}, <bang>0)
command! -bang -nargs=* FZFAllFiles call fzf#run({'source': 'find * -type f', 'sink': 'e'})
" command! -bang -nargs=? -complete=dir Files
"     \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline']}, <bang>0)
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

"" UI

Plug 'ap/vim-buftabline'
"
let g:buftabline_show = 1 " display only if more than 1 buffer open
" Plug 'romgrk/barbar.nvim'

" Plug 'arcticicestudio/nord-vim'
Plug 'NLKNguyen/papercolor-theme'

Plug 'etdev/vim-hexcolor', {'for': ['css']}

""" echodoc
Plug 'Shougo/echodoc.vim'
let g:echodoc_enable_at_startup=1
" default nord color lets not identify current argument
let g:echodoc#highlight_arguments = 'SpellCap'

""" lightline
Plug 'itchyny/lightline.vim'
            " \ 'colorscheme': 'gruvbox',
let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'coc_state', 'linter_checking', 'linter_errors', 'linter_warnings', 'currentFunction' ] ]
            \ },
            \ 'inactive': {
            \   'left': [ [ 'conflicted_name'], [ 'filename' ] ],
            \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
            \ },
            \ 'component_function': {
            \   'filename': 'LightlineFilename',
            \   'gitbranch': 'CocGitStatus',
            \   'conflicted_name': 'ConflictedVersion',
            \   'coc_state': 'coc#status',
            \   'currentFunction': 'CocCurrentFunction'
            \ },
		\ 'separator': { 'left': '', 'right': '' },
		\ 'subseparator': { 'left': '', 'right': '' }
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
  let l:gitstatus = get(g:,'coc_git_status','')
  if len(l:gitstatus) == 0
    return ''
  endif
  return get(g:,'coc_git_status','').get(b:,'coc_git_status','')
endfunction

function! LightlineFilename()
  return @% !=# '' ? expand('%:f') : '[No Name]'
endfunction

function! CocCurrentFunction()
    let cf = get(b:, 'coc_current_function', '')
    if len(cf) == 0
        return ''
    endif
    return cf.'()'
endfunction

"" markdown
" Plug 'reedes/vim-lexical', {'for': 'markdown'}
let g:vim_markdown_new_list_item_indent = 2
" Plug 'plasticboy/vim-markdown', {'for': ['markdown'], 'as': 'vim-markdown-plasticboy'}
Plug 'tpope/vim-markdown', {'for': 'markdown'}
Plug 'mzlogin/vim-markdown-toc', {'for': 'markdown'}

""" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'for': ['markdown', 'notes'],  'do': 'cd app & yarn install'  }
" let g:mkdp_path_to_chrome = 'chromium-browser'
let g:mkdp_path_to_chrome = 'google-chrome'
let g:mkdp_auto_close = 1
let g:mkdp_auto_start = 0

"" search/navigate

" smart search highligting
" let g:CoolTotalMatches = 1
" Plug 'romainl/vim-cool'
Plug 'pgdouyon/vim-evanesco'
" Plug 'junegunn/vim-slash'

Plug 'wellle/targets.vim'

" quickfix improvements
let g:qf_auto_resize = 1

" Plug 'RyanMillerC/better-vim-tmux-resizer'
let g:obvious_resize_default = 5
Plug 'talek/obvious-resize'

Plug 'majutsushi/tagbar', {'on': 'TagbarOpenAutoClose'}

""" sneak
" Plug 'justinmk/vim-sneak'
" let g:sneak#label = 1
" let g:sneak#use_ic_scs = 1

""" easymotion
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
nmap <Leader>f <Plug>(easymotion-bd-w)
nmap <Leader>F <Plug>(easymotion-overwin-w)
" nnoremap s <Plug>(easymotion-s)
" nnoremap  <Leader>b <Plug>(easymotion-b)

let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1 " US layout

" Plug 'rhysd/clever-f.vim'
" let g:clever_f_smart_case=1

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

let g:coc_explorer_global_presets = {
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

""" netrw
" Plug 'justinmk/vim-dirvish', {'on': 'Expl'}
" let g:netrw_banner = 0
" nnoremap - :Expl<cr>

""" tmux

if exists('$TMUX')
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'tmux-plugins/vim-tmux-focus-events'
    Plug 'tmux-plugins/vim-tmux'
    Plug 'wellle/tmux-complete.vim'
endif


" """ ferret
" let g:FerretHlsearch=1
" Plug 'wincent/ferret', {'on': 'Ack'}

"" git

Plug 'whiteinge/diffconflicts', {'on': 'DiffConflicts'}
Plug 'rhysd/git-messenger.vim'
let g:git_messenger_always_into_popup=1

""" gv
Plug 'junegunn/gv.vim', {'on': 'GV'}
" nnoremap <silent> <leader>gl :GV<cr>
" nnoremap <silent> <leader>gL :GV!<cr>
" vnoremap <silent> <leader>gl :GV<cr>
" vnoremap <silent> <leader>gL :GV?<cr>

""" fugitive
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

"" notes
Plug 'xolox/vim-notes', {'on': ['SearchNotes', 'Note', 'RecentNotes']} | Plug 'xolox/vim-misc'
let g:notes_directories = ['~/Dropbox/notes']
let g:notes_suffix = '.md'
let g:notes_smart_quotes = 0
let g:notes_tab_indents=0
" Plug 'rhysd/vim-notes-cli'

"" todo
""" simple-todo
Plug 'vitalk/vim-simple-todo'
let g:simple_todo_map_keys = 0
let g:simple_todo_list_symbol = '*'

""" todo.txt
Plug 'freitass/todo.txt-vim', {'for': 'text'}

"" filetype
Plug 'stephpy/vim-yaml', {'for': 'yaml'}
Plug 'sheerun/vim-polyglot'

Plug 'pearofducks/ansible-vim', { 'for': 'yaml'}
let g:ansible_unindent_after_newline = 1

"" misc
" Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
" Plug 'tpope/vim-repeat'
Plug 'triglav/vim-visual-increment'

let g:indent_guides_auto_colors = 0
Plug 'nathanaelkane/vim-indent-guides', {'on': 'IndentGuidesToggle'}

Plug 'phux/vim-marker'
let g:MarkerPersistenceDir = '/home/jan/.local/share/vim-marker'
" Plug '~/code/vim-marker'

" Filetype-specific mappings for [[ and ]]
let g:jumpy_map = [']]', ']]', '', '']  
Plug 'arp242/jumpy.vim'

Plug 'lifepillar/pgsql.vim', {'for': 'sql'}
let g:sql_type_default = 'pgsql'

" Plug 'junkblocker/patchreview-vim', {'on': 'DiffReview'}

Plug 'oguzbilgic/vim-gdiff', {'on': 'Gdiff'}

Plug 'romainl/vim-devdocs', {'on': 'DD'}
nnoremap <leader>K :DD<cr>

""" tabular
Plug 'godlygeek/tabular', {'on': 'Tabularize'}
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

""" Mundo
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
let g:mundo_width = 60
" let g:mundo_preview_height = 40
let g:mundo_verbose_graph = 0
" let g:mundo_preview_bottom = 1
" let g:mundo_inline_undo = 1

""" SplitJoin
let g:splitjoin_php_method_chain_full=1
Plug 'AndrewRadev/splitjoin.vim', {'on': ['SplitjoinSplit', 'SplitjoinJoin']}
nnoremap <leader>j :SplitjoinSplit<cr>
nnoremap <leader>k :SplitjoinJoin<cr>

""" commentary
Plug 'tpope/vim-commentary', {'on': 'Commentary'}

""" ale
let g:ale_disable_lsp=1
Plug 'dense-analysis/ale'
let g:ale_warn_about_trailing_whitespace=0
let g:ale_lint_on_enter=0
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_insert_leave=1
let g:ale_open_list = 0
let g:ale_keep_list_window_open=0
let g:ale_fix_on_save = 1
let g:ale_set_quickfix=0
let g:ale_sql_sqlformat_options='-r --indent_columns'
Plug 'maximbaz/lightline-ale'

""" abolish
Plug 'tpope/vim-abolish'

""" hardtime
Plug 'takac/vim-hardtime'
let g:hardtime_default_on = 0
let g:hardtime_ignore_quickfix = 1
let g:hardtime_maxcount = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_ignore_buffer_patterns = ['coc-explorer', 'tagbar']
let g:hardtime_timeout = 500

""" ranger
" Plug 'francoiscabrol/ranger.vim', {'on': ['RangerWorkingDirectory', 'RangerCurrentFile']} | Plug 'rbgrouleff/bclose.vim', {'on': ['RangerWorkingDirectory', 'RangerCurrentFile']}
" let g:ranger_replace_netrw = 0
" let g:ranger_map_keys = 0
" nnoremap <leader>n :RangerWorkingDirectory<cr>
" nnoremap <leader>N :RangerCurrentFile<cr>

Plug 'ActivityWatch/aw-watcher-vim'
Plug 'phux/go-analyzer.vim', {'for': 'go'}
Plug 'Glench/Vim-Jinja2-Syntax', {'for': 'jinja'}
Plug 'hashivim/vim-terraform', {'for': 'terraform'}
let g:terraform_align=1
" let g:terraform_fmt_on_save=1
" Plug 'git-time-metric/gtm-vim-plugin'
Plug 'dhruvasagar/vim-zoom'
" Plug 'tomtom/ttodo_vim' | Plug 'tomtom/tlib_vim'
" let g:ttodo#dirs = ['~/Dropbox/todo/work']
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
" let g:lsp_settings = {
" \  'gopls': {'cmd': ['~/code/go/bin/gopls']},
" \}
" Plug 'vimwiki/vimwiki'
" let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/',
"                       \ 'syntax': 'markdown', 'ext': '.md'}]

" default typewriter mario sword bubble
" let g:keysound_theme = 'typewriter'
let g:keysound_volume = 900
" let g:keysound_enable = 1
Plug 'skywind3000/vim-keysound'
Plug 'jparise/vim-graphql'
Plug 'vim-test/vim-test'
let test#strategy = "neovim"
let test#custom_runners = {
            \ 'go': ['Dockercomposego'],
            \ 'php': ['Customphpunit'],
            \}
nnoremap <leader>tf :TestNearest<cr>
nnoremap <leader>tt :TestFile<cr>
nnoremap <leader>tt :TestLast<cr>



" Plug 'pangloss/vim-javascript'    " JavaScript support
" Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
" Plug 'neoclide/vim-jsx-improve'  " replaces both above
" Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'HerringtonDarkholme/yats.vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'alvan/vim-closetag'

let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }
let g:closetag_filetypes = 'html,xhtml,phtml,javascriptreact,typescriptreact,typescript.tsx'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'puremourning/vimspector'
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
  " au BufNewFile,BufRead,BufEnter ~/Dropbox/notes/*.md set ft=markdown

  au FileType html,xml inoremap <buffer> <m-;> </<c-x><c-o>

  autocmd FileType typescript,json,go setl formatexpr=CocAction('formatSelected')
  au FileType xml setlocal makeprg=xmllint\ -

  au FocusLost,WinLeave * :silent! update
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0
        \| autocmd BufLeave <buffer> set laststatus=2

  " au BufWritePost *.go silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
  au FileType qf call AdjustWindowHeight(3, 10)

  " autocmd FileType netrw,dirvish setl bufhidden=wipe
  autocmd BufReadPost fugitive://* set bufhidden=delete

  autocmd! BufWritePost tmux.conf,.tmux.conf     :silent !tmux source-file ~/.tmux.conf

  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=8
  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
augroup END

" https://vim.fandom.com/wiki/Automatically_fitting_a_quickfix_window_height
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line('$'), a:maxheight]), a:minheight]) . 'wincmd _'
endfunction

"" Nvim
augroup nvim
  au!
  au BufWritePost *.vim nested source $MYVIMRC
augroup END

""""""""""""""
"  Settings  "
""""""""""""""

filetype plugin indent on

set encoding=UTF-8
scriptencoding utf-8

set fileformats=unix,dos,mac
set autowriteall             " Automatically save before :next, :make etc.
set autoread                 " Automatically reread changed files without asking me anything
set hidden                   " Allow buffers to be backgrounded without being saved

set foldcolumn=0             " do not show foldcolumn
set tags^=./.git/tags;
set confirm                  " don't fail, but ask
set noshowmode               " don't show mode in cmdline

" set scroll=20                " jump 20 lines max with ctrl-u/d
set scrolloff=5              " scroll if cursor is < 5 lines from bottom/top
set tabstop=4                " tab width in spaces
set shiftround               " round indent to multiples of shiftwidth
set smarttab                 " insert blanks according to shiftwidth
set expandtab                " use spaces instead of TAB
set softtabstop=4            " the number of spaces that a TAB counts for
set shiftwidth=4             " the number of spaces of an indent
set shiftround               " round indent to multiple of shiftwidth with > and <
set textwidth=0              " do not automatically wrap text

" set autoindent               " copy indent from current line when starting a new line
" set smartindent              " smarter autoindent
set copyindent               " copy the structure of the existing lines indent when
                             " autoindenting a new line
set preserveindent           " Use :retab to clean up whitespace

set splitbelow               " Splits show up below by default
set splitright               " Splits go to the right by default

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

set nojoinspaces          " don't insert two spaces after J behind a ./?/!

set nostartofline         " try to stay in same column when navigating

set ignorecase smartcase  " ignore case while searching except if search contains uppercase letter(s)
set hlsearch              " highlight results
set incsearch             " show results as you type
set inccommand=split      " open split with interactive substitutes
set grepprg=rg\ --vimgrep

set timeout ttimeoutlen=0
"" insert mode completion
" set complete-=i
" set complete+=w
" set completeopt-=preview

"" better command mode completion
set wildmenu
set wildmode=list:longest,full

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
set signcolumn=yes

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

" set max syntax highlighting column to sane level
set synmaxcol=250

set number
" set relativenumber
set ttyfast
set lazyredraw

" Set the command window height to 1 lines
set cmdheight=1
" This makes more sense than the default of 1
set winminheight=1

set showbreak=↪
set breakindent
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

" better diffing
" set diffopt+=algorithm:patience
set diffopt+=algorithm:histogram
" set diffopt+=indent-heuristic
set diffopt+=vertical

" let g:lexical#thesaurus = ['~/.config/nvim/thesaurus.txt',]
" let spellfile='~/.vim.spell'

""" colors
" color nord
" set background=dark

" hi CocFloating ctermbg=18



""""""""""""""
"  Mappings  "
""""""""""""""

"" pasting

set clipboard+=unnamed


"" qf/loc list toggle

let g:qf_loc_toggle_binds = 0
function! ToggleQfLocListBinds()
  if g:qf_loc_toggle_binds == 1
    nnoremap <silent> <c-p> :ALEPreviousWrap<cr>
    nnoremap <silent> <c-n> :ALENextWrap<cr>
    let g:qf_loc_toggle_binds = 0
    echo 'loc binds loaded'
  else
    let g:qf_loc_toggle_binds = 1
    nnoremap <c-p> :cp<cr>
    nnoremap <c-n> :cn<cr>
    echo 'qf binds loaded'
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

if ! exists('g:colors_name')
    if filereadable($TERM_BRIGHT)
        let g:lightline.colorscheme = 'PaperColor'
        set background=light
        color PaperColor
        hi Pmenu ctermbg=253 guibg=#434C5E
    else
        " set background=dark
        " color nord
        " hi Comment ctermfg=gray
        " hi BufTabLineCurrent ctermfg=2 ctermbg=8
        " hi Visual ctermfg=7 ctermbg=4
        " hi Folded ctermfg=4
        " hi Search ctermfg=0 ctermbg=10
    endif
endif

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
nmap <leader>z <Plug>(zoom-toggle)
" nnoremap <leader>s <c-w>v

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

" Close all buffers except this one
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

let g:coc_global_extensions = [
            \ 'coc-calc',
            \ 'coc-css',
            \ 'coc-docker',
            \ 'coc-explorer',
            \ 'coc-git',
            \ 'coc-html',
            \ 'coc-lua',
            \ 'coc-json',
            \ 'coc-lists',
            \ 'coc-pyright',
            \ 'coc-sh',
            \ 'coc-snippets',
            \ 'coc-solargraph', 
            \ 'coc-syntax',
            \ 'coc-vimlsp',
            \ 'coc-xml',
            \ 'coc-yaml',
            \ 'coc-yank',
            \ 'coc-tsserver',
            \ 'coc-phpls',
            \ 'coc-prettier',
            \ 'coc-eslint',
            \ 'coc-styled-components',
            \ 'coc-go',
            \ 'coc-markmap',
            \ 'coc-graphql',
            \ 'coc-spell-checker',
            \ 'coc-cspell-dicts',
            \ ]

imap <C-j> <Plug>(coc-snippets-expand-jump)

" gherkin: check step usages
" let @s='?/\^?s+2y/\("\|\$\):lvimgrep /<C-R>"/j tests/features/*.feature<CR>:lopen<CR>'

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

let g:ale_fixers = {
\   '*': [],
\   'terraform': ['terraform', 'remove_trailing_lines', 'trim_whitespace'],
\   'sh': ['shfmt', 'remove_trailing_lines', 'trim_whitespace'],
\   'markdown': ['textlint', 'remove_trailing_lines', 'trim_whitespace'],
\   'text': ['textlint', 'remove_trailing_lines', 'trim_whitespace'],
\   'html': ['tidy', 'prettier'],
\   'sql': ['sqlformat'],
\   'python': ['autopep8'],
\   'go': ['goimports'],
\}
 " \  'php': ['phpcbf'],

nnoremap ' `

so ~/.local.init.vim

" visiually select pasted text
nnoremap gp `[v`]
"" tabs

nmap <m-e> :call MoveToEnd()<cr>
imap <m-e> <esc>l:call MoveToEnd()<cr>
function! MoveToEnd()
    normal! xep
endfunction


command! MockForInterface execute '!mockery -dir '.expand('%:h').' --name '.expand('<cword>').' -output '.expand('%:h').'/mocks'

command! Mockery execute 'normal! O//go:generate mockery --name '.expand('<cword>')

" command! MockgenForInterface execute '!mockgen -source '.expand('%:t').' -package mocks -destination '.expand('%:h').'/mocks '.expand('<cword>')




"" new mappings
nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"

nmap <leader>nd <Plug>(coc-definition)
nmap <leader>nD <Plug>(coc-type-definition)
nmap <leader>ni <Plug>(coc-implementation)
nmap <leader>nr <Plug>(coc-references)
nnoremap <leader>nt :<C-u>CocList symbols<cr>
nnoremap <leader>lf :CocAction<cr>
xnoremap <leader>lf :CocAction<cr>
nmap <leader>ll <Plug>(coc-codelens-action)
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

nnoremap <silent> K :call <SID>show_documentation()<CR>
" function! s:show_documentation()
"     call CocAction('doHover')
" endfunction
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" todo: go

nmap <leader>rr <Plug>(coc-rename)
nmap <leader>RR <Plug>(coc-refactor)

nnoremap <silent> <leader>gL :GV<cr>
nnoremap <silent> <leader>gl :GV! --follow<cr>
vnoremap <silent> <leader>gl :GV<cr>

nnoremap <leader>go :CocCommand git.browserOpen<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gs :Ge :<cr>
nmap <leader>gi <Plug>(coc-git-chunkinfo)
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit -v<cr>
nnoremap <leader>gp :Gpush<cr>
" nnoremap <leader>gm :Git mergetool<cr>

nnoremap <leader>ge :Gedit<cr>
nnoremap <leader>gds :Gdiffsplit
nnoremap <leader>gdh :Git! difftool<cr>
" diff against master's state when branched out
nnoremap <leader>gdm :Gdiff $(git merge-base master HEAD)<cr>
nnoremap ]r :%bd<CR>:ALENextWrap<CR>:Gvdiffsplit<CR>
nnoremap [r :%bd<CR>:ALEPreviousWrap<CR>:Gvdiffsplit<CR>

nnoremap <leader>of :Files<cr>
" nnoremap <leader>of :Clap files<cr>
" nnoremap <leader>of :GFiles<cr>
nnoremap <leader>or :call FindFromGitRoot()<cr>
function! FindFromGitRoot()
    " Set 'gitdir' to be the folder containing .git
    let l:gitdir=system("git rev-parse --show-toplevel")
    " See if the command output starts with 'fatal' (if it does, not in a git repo)
    let l:isnotgitdir=matchstr(l:gitdir, '^fatal:.*')
    " If it empty, there was no error. Let's cd
    if empty(l:isnotgitdir)
        " echo ':Files '.l:gitdir
        exe ':Files '.trim(l:gitdir)
    else 
        :Files
    endif
endfunction
nnoremap <leader>OF :FZFAllFiles<cr>
nnoremap <leader>ob :Buffers<cr>
nnoremap <leader>ot :Tags<cr>

nnoremap <leader>st mO:Rg!<space>
nnoremap <leader>ST mO:Find<space>
nnoremap <leader>su mO:exec "Rg! ".expand("<cword>")<cr>
nnoremap <leader>SU mO:exec "Find ".expand("<cword>")<cr>
vnoremap <leader>SU mO"hy:exec "Find ".escape('<C-R>h', "/\.*$^~[()")<cr>
vnoremap <leader>su mO"hy:exec "Rg ".escape('<C-R>h', "/\.*$^~[()")<cr>


nmap <Leader>f <Plug>(easymotion-bd-w)
nmap <Leader>F <Plug>(easymotion-overwin-w)

nnoremap <leader>op :CocCommand explorer --preset simplify<cr>
" nnoremap <leader>op :LuaTreeToggle<CR>

" command! -nargs=1 PA args `=systemlist(<q-args>)`
nnoremap <leader>sp :Ack <c-r><c-w><cr>
nnoremap <leader>SP :Acks /<c-r><c-w>/<c-r><c-w>/gc<left><left><left>

nnoremap <leader>sv :Subvert/<c-R><c-w>/<c-r><c-w>/g<left><left>
vnoremap <leader>sv :Subvert/<c-R><c-w>/<c-r><c-w>/g<left><left>

nnoremap <leader>sr :s/<c-R><c-w>/<c-r><c-w>/g<left><left>
vnoremap <leader>sr :s/<c-R><c-w>/<c-r><c-w>/g<left><left>

nnoremap <silent> <leader>Y :<C-u>CocList --normal yank<cr>

nnoremap <C-]> mO<Plug>(fzf_tags)
nnoremap <leader>bt :TagbarOpenAutoClose<cr>

nmap <silent> <leader>ts <Plug>(simple-todo-new-start-of-line)
nmap <leader>to <Plug>(simple-todo-below)
nmap <leader>td <Plug>(simple-todo-mark-switch)

nnoremap <leader>u :MundoToggle<cr>

nnoremap <leader>c :Commentary<cr>
vnoremap <leader>c :Commentary<cr>

nnoremap <leader>p "+p
vnoremap <leader>y "+y
vnoremap <leader>p "+p
vnoremap <silent> y y`]

nnoremap <silent> <c-p> :ALEPreviousWrap<cr>
nnoremap <silent> <c-n> :ALENextWrap<cr>
nnoremap <leader>lb :call ToggleQfLocListBinds()<cr>
nnoremap <leader>lt :call LocListToggle()<cr>
nnoremap <leader>lc :lclose<cr>:cclose<cr>

nnoremap <silent> <leader>vi :e $MYVIMRC<CR>
"" edit ft plugin files
function! EditFtPluginFile(ft)
  exec ':e ~/.dotfiles/roles/neovim/files/ftplugin/'.a:ft.'.vim'
endfunction
nnoremap <leader>vc :call EditFtPluginFile(&filetype)<cr>
nnoremap <leader>vf :call EditFtPluginFile('')<left><left>


"" tabs
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprev<CR>
nnoremap <leader>tc :tabclose<CR>


" remove buffer without deleting window
nnoremap <silent> <leader>bd :bp<bar>bd #<cr>
" nnoremap <silent> <leader>bd :bd<cr>
" Close all buffers except this one
nnoremap <leader>bc :call CloseHiddenBuffers()<cr>

command! -range FormatShellCmd <line1>!format_shell_cmd.py

command! Markmap silent execute '!markmap '.expand('%:p').' -o '.expand('%:p').'.html'

"" tmux
if !exists('$TMUX')
  let g:obvious_resize_run_tmux = 0
  nnoremap <c-j> <c-w>j
  nnoremap <c-k> <c-w>k
  nnoremap <c-h> <c-w>h
  nnoremap <c-l> <c-w>l
  nnoremap <silent> <C-Left> :vertical resize -5<cr>
  nnoremap <silent> <C-Down> :resize +5<cr>
  nnoremap <silent> <C-Up> :resize -5<cr>
  nnoremap <silent> <C-Right> :vertical resize +5<cr>
else
  let g:obvious_resize_run_tmux = 1
endif
" todo: fix broken
  " nnoremap <c-j> <c-w>j
  " nnoremap <c-k> <c-w>k
  " nnoremap <c-h> <c-w>h
  " nnoremap <c-l> <c-w>l

nnoremap <silent> <C-Up> :<C-U>ObviousResizeUp<CR>
nnoremap <silent> <C-Down> :<C-U>ObviousResizeDown<CR>
nnoremap <silent> <C-Left> :<C-U>ObviousResizeLeft<CR>
nnoremap <silent> <C-Right> :<C-U>ObviousResizeRight<CR>

" scrolling in terminal mode - todo: clashes with fzf, only needed for
" vim-test
" tnoremap <Esc> <C-\><C-n>
" configure treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

" configure nvcode-color-schemes
" let g:nvcode_termcolors=256

syntax on
" colorscheme gruvbox " Or whatever colorscheme you make
colorscheme gruvbox8


" checks if your terminal has 24-bit color support
" if (has("termguicolors"))
"     set termguicolors
"     hi LineNr ctermbg=NONE guibg=NONE
" endif
"
let g:lua_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0,
    \ }
let g:lua_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': "",
    \   'symlink': "",
    \   }
    \ }

let g:lua_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:lua_tree_indent_markers = 1
