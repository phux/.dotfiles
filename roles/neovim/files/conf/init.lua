local execute = vim.api.nvim_command
local fn = vim.fn
local vim = vim
local U = require "utils"

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

vim.o.termguicolors = true

local disable_distribution_plugins = function()
    vim.g.loaded_gzip = 1
    vim.g.loaded_tar = 1
    vim.g.loaded_tarPlugin = 1
    vim.g.loaded_zip = 1
    vim.g.loaded_zipPlugin = 1
    vim.g.loaded_getscript = 1
    vim.g.loaded_getscriptPlugin = 1
    vim.g.loaded_vimball = 1
    vim.g.loaded_vimballPlugin = 1
    vim.g.loaded_matchit = 1
    vim.g.loaded_matchparen = 1
    vim.g.loaded_2html_plugin = 1
    vim.g.loaded_logiPat = 1
    vim.g.loaded_rrhelper = 1
    -- vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrwSettings = 1
    vim.g.loaded_netrwFileHandlers = 1
end
disable_distribution_plugins()

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", {noremap = true})
vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<leader>vi", ":e ~/.dotfiles/roles/neovim/files/conf/init.lua<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>vc", "<cmd>lua EditFtPluginFile()<cr>", {noremap = true})
function _G.EditFtPluginFile()
    vim.cmd("e ~/.dotfiles/roles/neovim/files/ftplugin/" .. vim.bo.filetype .. ".vim")
end
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", {noremap = true})

vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.smarttab = true
vim.o.expandtab = true

vim.cmd("set foldlevel=1")
vim.cmd("set foldnestmax=1")
-- vim.cmd("let g:sneak#label = 1")
vim.g.indentLine_enabled = 0

require "plugins"

require "plugins/_ale"
require "plugins/_coc"
require "plugins/_easymotion"
-- require "plugins/_sneak"
require "plugins/_fugitive"
require "plugins/_hardtime"
require "plugins/_fzf"
-- require "plugins/_leaderf"
-- require "plugins/_galaxyline"
require "plugins/_lualine"
require "plugins/_gv"
require "plugins/_nvimtree"
require "plugins/_splitjoin"
require "plugins/_telescope"
require "plugins/_treesitter"
require "plugins/_vimtest"
require "plugins/_vimwiki"
require "plugins/_zettel"
require "plugins/_simpletodo"
-- require "plugins/_notoire"

if vim.fn.exists("g:colors_name") == 0 then
    if U.load_bright_theme() then
        vim.o.background = "light"
    end
    vim.cmd("colorscheme gruvbox8")
end

vim.o.hidden = true
-- -- create a vertical split below the current pane
vim.o.splitbelow = true
-- -- create a horizontal split to the right of the current pane
vim.o.splitright = true

vim.g.terraform_align = 1
vim.g.terraform_fmt_on_save = 1

vim.cmd("set diffopt+=algorithm:histogram")
vim.cmd("set diffopt+=vertical")
vim.cmd("set diffopt+=indent-heuristic")

-- vim.api.nvim_set_keymap('n', '<leader>of', ':Telescope find_files<cr>', {noremap = true})

vim.o.wildmenu = true
vim.o.wildmode = "longest,list,full"
vim.o.wildoptions = "pum"

-- Cool floating window popup menu for completion on command line

vim.o.showmode = false
vim.o.showcmd = true
vim.o.cmdheight = 1 -- Height of the command bar
vim.o.incsearch = true -- Makes search act like search in modern browsers
vim.o.showmatch = false -- don't show matching brackets when text indicator is over them
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.o.ignorecase = true -- Ignore case when searching...
vim.o.smartcase = true -- ... unless there is a capital letter in the query
vim.wo.signcolumn = "yes" -- always show the signcolumne to avoid flicker
-- vim.api.nvim_command("set signcolumn=yes")
vim.o.hidden = true -- having more than 1 buffor open
vim.o.cursorline = false -- Don't highlight the current line
vim.o.equalalways = false --
vim.o.splitright = true -- Prefer windows splitting to the right
vim.o.splitbelow = true -- Prefer windows splitting to the bottom
vim.o.updatetime = 300 -- Make updates happen faster
vim.o.hlsearch = true -- highlight search matches
vim.o.scrolloff = 10 -- always ten lines below the cursor
vim.g.buftabline_show = 1

-- Tabs
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.tabstop = 4
vim.o.cindent = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.autoindent = true

vim.o.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
vim.o.breakindent = true
vim.o.breakindentopt = "sbr"
-- wrap lines
vim.o.wrap = true
vim.o.whichwrap = "b,s,<,>,[,],h,l"
-- but don't split words
vim.o.linebreak = true

vim.o.belloff = "all"

vim.o.clipboard = "unnamed"

vim.cmd("set undofile")
vim.o.inccommand = "split"
vim.o.swapfile = false -- Living on the edge
execute("set noswapfile")
-- vim.o.shada          = { "!", "'1000", "<50", "s10", "h" }

vim.o.mouse = "n"

vim.api.nvim_set_keymap("n", "<leader>sv", ":Subvert/<c-R><c-w>/<c-r><c-w>/g<left><left>", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>sv", ":Subvert/<c-R><c-w>/<c-r><c-w>/g<left><left>", {noremap = true})

vim.api.nvim_set_keymap("n", "<leader>sr", ":s/<c-R><c-w>/<c-r><c-w>/g<left><left>", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>sr", ":s/<c-R><c-w>/<c-r><c-w>/g<left><left>", {noremap = true})

-- shorten messages, don't display intro
vim.cmd("set shortmess+=aI")

vim.o.formatoptions = "qrn1tclj"

-- if count supplied, move with line numbers, otherwise move visual lines
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", {noremap = true, expr = true})
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", {noremap = true, expr = true})

vim.o.joinspaces = false
vim.o.confirm = true

-- inoremap <c-l> <del>
vim.api.nvim_set_keymap("i", "<c-l>", "<del>", {noremap = true})

-- keep selection after indent
-- vnoremap < <gv
vim.api.nvim_set_keymap("v", "<", "<gv", {noremap = true})
vim.api.nvim_set_keymap("v", ">", ">gv", {noremap = true})
-- nnoremap <m-l> :bn<cr>
vim.api.nvim_set_keymap("n", "<m-l>", ":bn<cr>", {noremap = true})
-- nnoremap <m-h> :bp<cr>
vim.api.nvim_set_keymap("n", "<m-h>", ":bp<cr>", {noremap = true})

vim.api.nvim_set_keymap("n", "<leader>tn", ":tabnext<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tp", ":tabprev<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<cr>", {noremap = true})

vim.api.nvim_set_keymap("n", "<leader>bd", ":bp<bar>bd #<cr>", {noremap = true})

vim.api.nvim_set_keymap("n", "<leader>p", '"+p', {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>p", '"+p', {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', {noremap = true})
-- vnoremap <silent> y y`]

-- cmode terminal like mappings
vim.api.nvim_set_keymap("c", "<c-p>", "<Up>", {noremap = true})
vim.api.nvim_set_keymap("c", "<c-n>", "<Down>", {noremap = true})
vim.api.nvim_set_keymap("c", "<M-b>", "<S-Left>", {noremap = true})
vim.api.nvim_set_keymap("c", "<M-f>", "<S-Right>", {noremap = true})
vim.api.nvim_set_keymap("c", "<M-a>", "<Home>", {noremap = true})

vim.api.nvim_set_keymap("n", "<leader>bt", ":TagbarOpenAutoClose<cr>", {noremap = true})

vim.cmd("hi! def link BufTabLineCurrent PmenuSel")
vim.cmd("hi! def link BufTabLineActive TabLineSel")

local autocmds = {
    conf = {
        {"BufWritePost", "~/.dotfiles/*.lua", ":luafile %"},
        {"WinEnter", "*", ":call ResizeSplits()"},
        {"FocusLost,WinLeave", "*", ":silent! update"},
        {
            "FileType",
            "vimwiki",
            'let b:AutoPairs = {\'```\': \'```\', \'`\': \'`\', \'"\': \'"\', \'\'\'\': \'\'\'\', \'(\': \')\', \'\'\'\'\'\'\'\': \'\'\'\'\'\'\'\', \'{\': \'}\', \'"""\': \'"""\'}'
        }
    }
}
U.augroups(autocmds)

vim.api.nvim_exec(
    [[
function! OpenNote(file)
exe 'edit '.a:file
normal! Go
exe 'normal! Go## ' . strftime("%Y-%m-%d %H:%M")
normal! 2o
startinsert
endfunction
]],
    true
)

vim.api.nvim_exec(
    [[
function! OpenMeetingNote()
let l:name = input('Title: ')
exe 'edit ~/Dropbox/1vimwiki/notes/meetings/'. strftime("%Y-%m-%d %H:%M").'-'.l:name.'.md'
exe 'normal! i# '.l:name
normal! 2o
normal! i## Pre-Meeting Notes
normal! 2o
normal! i## Agenda
normal! 2o
normal! i## Notes
endfunction
]],
    true
)

vim.cmd("command! OpenMeetingNote :call OpenMeetingNote()")
vim.cmd("command! OpenTodoNote :call OpenNote('~/Dropbox/1vimwiki/notes/todo.md')")
vim.cmd("command! OpenInboxNote :call OpenNote('~/Dropbox/1vimwiki/inbox/inbox.md')")

vim.api.nvim_exec(
    [[
let g:qf_loc_toggle_binds = 0
function! ToggleQfLocListBinds()
  if g:qf_loc_toggle_binds == 1
    nnoremap <silent> <c-p> :ALEPreviousWrap<cr>
    nnoremap <silent> <c-n> :ALENextWrap<cr>
    let g:qf_loc_toggle_binds = 0
    echo 'ale wrap binds loaded'
  else
    let g:qf_loc_toggle_binds = 1
    nnoremap <c-p> :cp<cr>
    nnoremap <c-n> :cn<cr>
    echo 'qf binds loaded'
  endif
endfunction
]],
    true
)

vim.api.nvim_set_keymap("n", "<leader>lb", ":call ToggleQfLocListBinds()<cr>", {noremap = true})

vim.api.nvim_exec(
    [[
function! ZettelHierarchy(...)
    let l:startingHierarchy = get(a:, 1, '')
    let l:result = system('rg "^title: n:'.l:startingHierarchy.'"')
    let l:files = []
    for item in split(l:result, "\n")
        let l:parts = split(item, ":")
        let l:file = l:parts[0]
        let l:match = {'title': join(l:parts[3:], ':'), 'file': l:file}
        call add(l:files, l:match)
    endfor
    call sort(l:files, function("SortZettelEntries"))

    for item in l:files
        exe 'normal! o- ['.item['title'].']('.item['file'].')'
    endfor
    " return l:files
endfunction

function! SortZettelEntries(leftArg, rightArg)
  if a:leftArg['title'] == a:rightArg['title']
    return 0
  elseif a:leftArg['title'] < a:rightArg['title']
    return -1
  else
    return 1
  endif
endfunction
]],
    true
)

vim.cmd("set title")
vim.cmd('nmap gx yiW:!xdg-open <cWORD><CR> <C-r>" & <CR><CR>')

vim.g.obvious_resize_run_tmux = 1
vim.g.obvious_resize_default = 5
vim.api.nvim_set_keymap("n", "<C-Up>", ":<C-U>ObviousResizeUp<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-Down>", ":<C-U>ObviousResizeDown<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-Left>", ":<C-U>ObviousResizeLeft<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-Right>", ":<C-U>ObviousResizeRight<CR>", {noremap = true})

vim.api.nvim_exec([[
function! ResizeSplits()
    set winwidth=85
    wincmd =
endfunction
]], true)
