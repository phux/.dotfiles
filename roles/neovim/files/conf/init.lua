local execute = vim.api.nvim_command
local fn = vim.fn
local vim = vim
local U = require "utils"

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

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
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrwSettings = 1
    vim.g.loaded_netrwFileHandlers = 1
end
disable_distribution_plugins()

vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<leader>vi", ":e ~/.config/nvim/init.lua<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>vl", ":Files ~/.config/nvim/lua<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>vc", "<cmd>lua EditFtPluginFile()<cr>", {noremap = true})
function _G.EditFtPluginFile()
    vim.cmd("e ~/.dotfiles/roles/neovim/files/ftplugin/" .. vim.bo.filetype .. ".vim")
end
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", {noremap = true})

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.smarttab = true
vim.o.expandtab = true

require "plugins"

require "plugins/_ale"
require "plugins/_coc"
require "plugins/_easymotion"
require "plugins/_fugitive"
require "plugins/_fzf"
require "plugins/_galaxyline"
require "plugins/_gv"
require "plugins/_luatree"
require "plugins/_splitjoin"
require "plugins/_telescope"
require "plugins/_treesitter"
require "plugins/_vimtest"

if vim.fn.exists("g:colors_name") == 0 then
    if U.load_bright_theme() then
        vim.o.background = "light"
    else
        vim.o.background = "dark"
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

-- vim.api.nvim_set_keymap('n', '<leader>of', ':Telescope find_files<cr>', {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>of", ":FZF<cr>", {noremap = true})

vim.o.wildmode = "longest,list,full"
vim.o.wildoptions = "pum"

-- Cool floating window popup menu for completion on command line

vim.o.showmode = false
vim.o.showcmd = true
vim.o.cmdheight = 1 -- Height of the command bar
vim.o.incsearch = true -- Makes search act like search in modern browsers
vim.o.showmatch = false -- don't show matching brackets when text indicator is over them
-- vim.o.number = true -- show the actual number for the line we're on
vim.cmd("set number")
vim.o.ignorecase = true -- Ignore case when searching...
vim.o.smartcase = true -- ... unless there is a capital letter in the query
-- vim.o.signcolumn = "yes" -- always show the signcolumne to avoid flicker
vim.api.nvim_command("set signcolumn=yes")
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
vim.o.wrap = true

vim.o.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
vim.o.linebreak = true

vim.o.foldmethod = "marker"
vim.o.foldlevel = 0
vim.o.modelines = 1

vim.o.belloff = "all"

vim.o.clipboard = "unnamed"

vim.o.undofile = true
-- vim.o.undodir = '~/.vim_undodir'
vim.o.inccommand = "split"
vim.o.swapfile = false -- Living on the edge
execute("set noswapfile")
-- vim.o.shada          = { "!", "'1000", "<50", "s10", "h" }

vim.o.mouse = "n"

vim.o.formatoptions = "qrn1tclj"

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
vim.api.nvim_set_keymap("n", "<leader>bd", ":bp<bar>bd #<cr>", {noremap = true})

vim.api.nvim_set_keymap("n", "<leader>p", '"+p', {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>p", '"+p', {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', {noremap = true})
-- vnoremap <silent> y y`]

vim.o.termguicolors = true

require "colorizer".setup()

vim.cmd("hi! def link BufTabLineCurrent PmenuSel")
vim.cmd("hi! def link BufTabLineActive TabLineSel")

local autocmds = {
    conf = {
        {"BufWritePost", "~/.dotfiles/*.lua", ":luafile %"}
    }
}
U.augroups(autocmds)
