local execute = vim.api.nvim_command
local fn = vim.fn
local vim = vim
local U = require "utils"

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
vim.cmd("language en_US.utf8")
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true })
vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<leader>vi", ":e ~/.dotfiles/roles/neovim/files/conf/init.lua<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>vc", "<cmd>lua EditFtPluginFile()<cr>", { noremap = true })
function _G.EditFtPluginFile()
    vim.cmd("e ~/.dotfiles/roles/neovim/files/ftplugin/" .. vim.bo.filetype .. ".vim")
end

vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true })

vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"

vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.smarttab = true
vim.o.expandtab = true

vim.cmd("set foldlevel=1")
vim.cmd("set foldnestmax=1")
vim.g.indentLine_enabled = 0


if vim.fn.exists("g:colors_name") == 0 then
    if U.load_bright_theme() then
        vim.o.background = "light"
    end
end

vim.o.hidden = true
-- -- create a vertical split below the current pane
vim.o.splitbelow = true
-- -- create a horizontal split to the right of the current pane
vim.o.splitright = true

vim.g.terraform_align = 1
vim.g.terraform_fmt_on_save = 1

vim.cmd("set diffopt+=algorithm:patience")
vim.cmd("set diffopt+=vertical")
vim.cmd("set diffopt+=indent-heuristic")

vim.o.wildmenu = true
vim.o.wildmode = "longest,list,full"
vim.o.wildoptions = "pum"

-- Cool floating window popup menu for completion on command line

vim.o.showmode = false
vim.o.showcmd = true
vim.o.cmdheight = 1     -- Height of the command bar
vim.o.incsearch = true  -- Makes search act like search in modern browsers
vim.o.showmatch = false -- don't show matching brackets when text indicator is over them
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.o.ignorecase = true   -- Ignore case when searching...
vim.o.smartcase = true    -- ... unless there is a capital letter in the query
vim.wo.signcolumn = "yes" -- always show the signcolumne to avoid flicker
-- vim.api.nvim_command("set signcolumn=yes")
vim.o.hidden = true       -- having more than 1 buffor open
vim.o.cursorline = false  -- Don't highlight the current line
vim.o.equalalways = false --
vim.o.splitright = true   -- Prefer windows splitting to the right
vim.o.splitbelow = true   -- Prefer windows splitting to the bottom
vim.o.updatetime = 300    -- Make updates happen faster
vim.o.hlsearch = true     -- highlight search matches
vim.o.scrolloff = 10      -- always ten lines below the cursor
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
vim.cmd("set undodir=~/.vim/undo")
vim.o.inccommand = "split"
vim.o.swapfile = false -- Living on the edge
execute("set noswapfile")
-- vim.o.shada          = { "!", "'1000", "<50", "s10", "h" }

vim.o.mouse = "n"

vim.api.nvim_set_keymap("n", "<leader>sv", ":Subvert/<c-R><c-w>/<c-r><c-w>/g<left><left>", { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>sv", ":Subvert/<c-R><c-w>/<c-r><c-w>/g<left><left>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>sr", ":s/<c-R><c-w>/<c-r><c-w>/g<left><left>", { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>sr", ":s/<c-R><c-w>/<c-r><c-w>/g<left><left>", { noremap = true })

-- shorten messages, don't display intro
vim.cmd("set shortmess+=aIc")

vim.o.formatoptions = "qrn1tclj"

-- if count supplied, move with line numbers, otherwise move visual lines
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true })
vim.api.nvim_set_keymap("n", "<Up>", "&diff ? '[c' : '<Up>'", { noremap = true, expr = true })
vim.api.nvim_set_keymap("n", "<Down>", "&diff ? ']c' : '<Down>'", { noremap = true, expr = true })

vim.o.joinspaces = false
vim.o.confirm = true
vim.o.autowriteall = true

-- inoremap <c-l> <del>
vim.api.nvim_set_keymap("i", "<c-l>", "<del>", { noremap = true })

-- keep selection after indent
-- vnoremap < <gv
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true })
-- nnoremap <m-l> :bn<cr>
vim.api.nvim_set_keymap("n", "<m-l>", ":bn<cr>", { noremap = true })
-- nnoremap <m-h> :bp<cr>
vim.api.nvim_set_keymap("n", "<m-h>", ":bp<cr>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>tn", ":tabnext<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tp", ":tabprev<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<cr>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>bd", ":bp<bar>bd #<cr>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>p", '"+p', { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>p", '"+p', { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true })
-- vnoremap <silent> y y`]

-- cmode terminal like mappings
vim.api.nvim_set_keymap("c", "<c-p>", "<Up>", { noremap = true })
vim.api.nvim_set_keymap("c", "<c-n>", "<Down>", { noremap = true })
vim.api.nvim_set_keymap("c", "<M-b>", "<S-Left>", { noremap = true })
vim.api.nvim_set_keymap("c", "<M-f>", "<S-Right>", { noremap = true })

vim.api.nvim_set_keymap("c", "<M-a>", "<Home>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>;", ":TagbarToggle<cr>", { noremap = true })

vim.cmd("hi! def link BufTabLineCurrent PmenuSel")
vim.cmd("hi! def link BufTabLineActive TabLineSel")

local autocmds = {
    conf = {
        { "BufWritePost",       "~/.dotfiles/*.lua", ":luafile %" },
        -- {"WinEnter", "*", ":call ResizeSplits()"},
        { "BufNewFile,BufRead", "*.graphqls",        "set ft=graphql" },
        { "BufNewFile,BufRead", "*.yaml.jinja",      "set ft=yaml" },
        { "BufNewFile,BufRead", "*.yml.jinja",       "set ft=yaml" },
        { "BufNewFile,BufRead", "*.tf",              "set ft=tf" },
        { "BufNewFile,BufRead", "Dockerfile*",       "set ft=dockerfile" },
        { "FocusLost,WinLeave", "*",                 ":silent! update" },
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
let g:qf_loc_toggle_binds = 0
nnoremap <silent> <c-p> :ALEPreviousWrap<cr>
nnoremap <silent> <c-n> :ALENextWrap<cr>
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

vim.api.nvim_set_keymap("n", "<leader>lb", ":call ToggleQfLocListBinds()<cr>", { noremap = true })

-- better time tracking via ActivityWatch
vim.cmd("set title")

-- vim.cmd('nmap gx "ayiW:exe "call system("chromium-browser ".shellescape(expand("<cWORD>"))."<CR>')

vim.cmd('nmap gx :exe "!chromium-browser ".shellescape(expand("<cWORD>"))<cr><cr>')


-- vim.api.nvim_exec([[
-- function! ResizeSplits()
--     set winwidth=85
--     wincmd =
-- endfunction
-- ]], true)

-- sw - start/stop writing mode
vim.api.nvim_set_keymap("n", "<leader>sw", "<cmd>lua ToggleWritingMode()<cr>", { noremap = true })
function _G.ToggleWritingMode()
    vim.cmd("Goyo")
    vim.cmd("Limelight!!")
end

vim.api.nvim_set_keymap("n", "<leader>M", ":Magit<CR>", { noremap = true })

vim.g.notetaker_root_dir = "~/Dropbox/1vimwiki/notes/"

vim.g.scratch_persistence_file = ".scratch.vim"
vim.g.scratch_height = 10

-- TODO: disable autopairs and map to <m-n>, <m-p>
vim.api.nvim_set_keymap("n", "<leader>mn", ":call marker#NextMark()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>mp", ":call marker#PrevMark()<cr>", { noremap = true })

vim.api.nvim_exec(
    [[
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
]],
    true
)

vim.cmd([[hi link diffAdded DiffAdd]])
vim.cmd([[hi link diffRemoved DiffDelete]])
-- vim.cmd([[hi diffFile cterm=NONE ctermfg=DarkBlue]])
-- vim.cmd([[hi gitcommitDiff cterm=NONE ctermfg=DarkBlue]])
-- vim.cmd([[hi diffIndexLine cterm=NONE ctermfg=DarkBlue]])
-- vim.cmd([[hi diffLine cterm=NONE ctermfg=DarkBlue]])
vim.api.nvim_exec(
    [[
nmap <F12> :call SynStack()<CR>
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
]],
    true
)

vim.g.vim_svelte_plugin_use_typescript = 1
vim.cmd(
    [[
let g:grammarous#disabled_rules = {}
let g:grammarous#disabled_rules['*'] = ["DASH_RULE", "WHITESPACE_RULE", "EN_QUOTES", "COMMA_PARENTHESIS_WHITESPACE"]
]]
)

vim.api.nvim_set_keymap("n", "<M-f>", ":set ft=json | CocCommand editor.action.formatDocument<cr>", { noremap = true })
vim.cmd([[
nnoremap <Leader>sw :%s/\<<C-r><C-w>\>//g<Left><Left>
    ]])


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        {
            "sainnhe/gruvbox-material",
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd("let g:gruvbox_material_better_performance = 1")
                -- vim.cmd("let g:gruvbox_material_foreground = 'original'")
                vim.cmd("colorscheme gruvbox-material")
            end
        },
        { "yggdroot/indentLine" },
        { "godlygeek/tabular", lazy=true },
        {"roman/golden-ratio"},
        {
            "talek/obvious-resize",
            keys = {
                "<C-Up>", "<C-Down>", "<C-Left>", "<C-Right>"
            },
            config = function()
                vim.g.obvious_resize_run_tmux = 1
                vim.g.obvious_resize_default = 5
                vim.api.nvim_set_keymap("n", "<C-Up>", ":<C-U>ObviousResizeUp<CR>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<C-Down>", ":<C-U>ObviousResizeDown<CR>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<C-Left>", ":<C-U>ObviousResizeLeft<CR>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<C-Right>", ":<C-U>ObviousResizeRight<CR>", { noremap = true })
            end
        },
        {
            "rhysd/git-messenger.vim",
            lazy = true,
            config = function()
                vim.g.git_messenger_include_diff = "current"
                vim.g.git_messenger_always_into_popup = 1
            end
        },
        {
            "tpope/vim-fugitive",
            config = function()
                vim.api.nvim_set_keymap("n", "<leader>gw", ":Gwrite<cr>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<leader>ge", ":Gedit<cr>", { noremap = true })
                -- vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<cr>", {noremap = true})
                vim.api.nvim_set_keymap("n", "<leader>gb", ":Git blame<cr>", { noremap = true })
                -- vim.api.nvim_set_keymap("n", "<leader>gc", ":Gcommit -v<cr>", {noremap = true})
                vim.api.nvim_set_keymap("n", "<leader>gp", ":Gpush<cr>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<leader>gdh", ":Git! difftool<cr>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<leader>gmt", ":Git! mergetool<cr>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<leader>gds", ":Gdiffsplit<cr>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<leader>go", "V:GBrowse<cr>", { noremap = true })
                vim.api.nvim_set_keymap("v", "<leader>go", ":GBrowse<cr>", { noremap = true })
            end
        },
        { "tpope/vim-rhubarb" },
        {
            "sindrets/diffview.nvim",
            config = function()
                vim.g.git_messenger_include_diff = "current"
                vim.g.git_messenger_always_into_popup = 1
            end
        },
        {
            "whiteinge/diffconflicts",
            cmd = "DiffConflicts",
            config = function()
                vim.g.git_messenger_include_diff = "current"
                vim.g.git_messenger_always_into_popup = 1
            end
        },
        {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("gitsigns").setup {
                    signs = {
                        add = { text = "│" },
                        change = { text = "│" },
                        delete = { text = "_" },
                        topdelete = { text = "‾" },
                        changedelete = { text = "~" },
                        untracked = { text = "┆" }
                    },
                    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
                    numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
                    linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
                    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
                    watch_gitdir = {
                        follow_files = true
                    },
                    attach_to_untracked = true,
                    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                    current_line_blame_opts = {
                        virt_text = true,
                        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                        delay = 1000,
                        ignore_whitespace = false,
                        virt_text_priority = 100
                    },
                    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
                    sign_priority = 6,
                    update_debounce = 100,
                    status_formatter = nil,  -- Use default
                    max_file_length = 40000, -- Disable if file is longer than this (in lines)
                    preview_config = {
                        -- Options passed to nvim_open_win
                        border = "single",
                        style = "minimal",
                        relative = "cursor",
                        row = 0,
                        col = 1
                    },
                    yadm = {
                        enable = false
                    },
                    on_attach = function(bufnr)
                        local gs = package.loaded.gitsigns

                        local function map(mode, l, r, opts)
                            opts = opts or {}
                            opts.buffer = bufnr
                            vim.keymap.set(mode, l, r, opts)
                        end

                        -- Navigation
                        map(
                            "n",
                            "]c",
                            function()
                                if vim.wo.diff then
                                    return "]c"
                                end
                                vim.schedule(
                                    function()
                                        gs.next_hunk()
                                    end
                                )
                                return "<Ignore>"
                            end,
                            { expr = true }
                        )

                        map(
                            "n",
                            "[c",
                            function()
                                if vim.wo.diff then
                                    return "[c"
                                end
                                vim.schedule(
                                    function()
                                        gs.prev_hunk()
                                    end
                                )
                                return "<Ignore>"
                            end,
                            { expr = true }
                        )

                        -- Actions
                        map("n", "<leader>hs", gs.stage_hunk)
                        -- map("n", "<leader>hr", gs.reset_hunk)
                        map(
                            "v",
                            "<leader>hs",
                            function()
                                gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
                            end
                        )
                        -- map(
                        --     "v",
                        --     "<leader>hr",
                        --     function()
                        --         gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")}
                        --     end
                        -- )
                        map("n", "<leader>hS", gs.stage_buffer)
                        -- map("n", "<leader>hu", gs.undo_stage_hunk)
                        map("n", "<leader>hR", gs.reset_buffer)
                        map("n", "<leader>hp", gs.preview_hunk)
                        map(
                            "n",
                            "<leader>hb",
                            function()
                                gs.blame_line { full = true }
                            end
                        )
                        map("n", "<leader>tb", gs.toggle_current_line_blame)
                        map("n", "<leader>hd", gs.diffthis)
                        map(
                            "n",
                            "<leader>hD",
                            function()
                                gs.diffthis("~")
                            end
                        )
                        map("n", "<leader>td", gs.toggle_deleted)

                        -- Text object
                        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                    end
                }
            end
        },
        {
            "w0rp/ale",
            lazy = true,
            config = function()
                require("gitsigns").setup {
                    signs = {
                        add = { text = "│" },
                        change = { text = "│" },
                        delete = { text = "_" },
                        topdelete = { text = "‾" },
                        changedelete = { text = "~" },
                        untracked = { text = "┆" }
                    },
                    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
                    numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
                    linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
                    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
                    watch_gitdir = {
                        follow_files = true
                    },
                    attach_to_untracked = true,
                    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                    current_line_blame_opts = {
                        virt_text = true,
                        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                        delay = 1000,
                        ignore_whitespace = false,
                        virt_text_priority = 100
                    },
                    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
                    sign_priority = 6,
                    update_debounce = 100,
                    status_formatter = nil,  -- Use default
                    max_file_length = 40000, -- Disable if file is longer than this (in lines)
                    preview_config = {
                        -- Options passed to nvim_open_win
                        border = "single",
                        style = "minimal",
                        relative = "cursor",
                        row = 0,
                        col = 1
                    },
                    yadm = {
                        enable = false
                    },
                    on_attach = function(bufnr)
                        local gs = package.loaded.gitsigns

                        local function map(mode, l, r, opts)
                            opts = opts or {}
                            opts.buffer = bufnr
                            vim.keymap.set(mode, l, r, opts)
                        end

                        -- Navigation
                        map(
                            "n",
                            "]c",
                            function()
                                if vim.wo.diff then
                                    return "]c"
                                end
                                vim.schedule(
                                    function()
                                        gs.next_hunk()
                                    end
                                )
                                return "<Ignore>"
                            end,
                            { expr = true }
                        )

                        map(
                            "n",
                            "[c",
                            function()
                                if vim.wo.diff then
                                    return "[c"
                                end
                                vim.schedule(
                                    function()
                                        gs.prev_hunk()
                                    end
                                )
                                return "<Ignore>"
                            end,
                            { expr = true }
                        )

                        -- Actions
                        map("n", "<leader>hs", gs.stage_hunk)
                        -- map("n", "<leader>hr", gs.reset_hunk)
                        map(
                            "v",
                            "<leader>hs",
                            function()
                                gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
                            end
                        )
                        -- map(
                        --     "v",
                        --     "<leader>hr",
                        --     function()
                        --         gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")}
                        --     end
                        -- )
                        map("n", "<leader>hS", gs.stage_buffer)
                        -- map("n", "<leader>hu", gs.undo_stage_hunk)
                        map("n", "<leader>hR", gs.reset_buffer)
                        map("n", "<leader>hp", gs.preview_hunk)
                        map(
                            "n",
                            "<leader>hb",
                            function()
                                gs.blame_line { full = true }
                            end
                        )
                        map("n", "<leader>tb", gs.toggle_current_line_blame)
                        map("n", "<leader>hd", gs.diffthis)
                        map(
                            "n",
                            "<leader>hD",
                            function()
                                gs.diffthis("~")
                            end
                        )
                        map("n", "<leader>td", gs.toggle_deleted)

                        -- Text object
                        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                    end
                }
            end
        },
        -- {"andymass/vim-matchup"},
         {
             "machakann/vim-sandwich",
             event = "VimEnter *",
            config = function()
                vim.cmd("runtime macros/sandwich/keymap/surround.vim")
            end

         },
        {
            "pwntester/octo.nvim",
            cmd = "Octo",
            lazy=true,
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope.nvim",
                "nvim-tree/nvim-web-devicons"
            },
            config = function()
                require "octo".setup()
                vim.api.nvim_set_keymap(
                    "n",
                    "<leader>opl",
                    [[ <Esc><Cmd>Octo pr list<CR>]],
                    { noremap = true, silent = true, expr = false }
                )
                vim.api.nvim_set_keymap(
                    "n",
                    "<leader>ors",
                    [[ <Esc><Cmd>Octo review start<CR>]],
                    { noremap = true, silent = true, expr = false }
                )
            end
        },
        {
            'Wansmer/treesj',
            keys = { '<space>k', '<space>j', '<space>s' },
            dependencies = { 'nvim-treesitter/nvim-treesitter' },
            config = function()
                require('treesj').setup({
                    use_default_keymaps = false,
                })

                vim.keymap.set('n', '<leader>j', require('treesj').toggle)
                -- getting used to it
                vim.keymap.set('n', '<leader>k', require('treesj').toggle)
            end,
        },
        {
            "kevinhwang91/nvim-hlslens",
            config = function()
                require("hlslens").setup()

                local kopts = {
                    noremap = true,
                    silent = true,
                }

                vim.api.nvim_set_keymap(
                    "n",
                    "n",
                    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
                    kopts
                )
                vim.api.nvim_set_keymap(
                    "n",
                    "N",
                    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
                    kopts
                )
                vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
                vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
                vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
                vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
            end
        },
        {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",
            keys = { '<space>ot' },
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim"
                -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
                -- {
                --     "s1n7ax/nvim-window-picker",
                --     version = "2.*",
                --     config = function()
                --         require "window-picker".setup(
                --             {
                --                 filter_rules = {
                --                     include_current_win = false,
                --                     autoselect_one = true,
                --                     -- filter using buffer options
                --                     bo = {
                --                         -- if the file type is one of following, the window will be ignored
                --                         filetype = {"neo-tree", "neo-tree-popup", "notify"},
                --                         -- if the buffer type is one of following, the window will be ignored
                --                         buftype = {"terminal", "quickfix"}
                --                     }
                --                 }
                --             }
                --         )
                --     end
                -- }
            },
            config = function()
                require("neo-tree").setup(
                    {
                        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
                        popup_border_style = "rounded",
                        enable_git_status = false,
                        enable_diagnostics = false,
                        enable_normal_mode_for_inputs = false,                             -- Enable normal mode for input dialogs.
                        open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
                        sort_case_insensitive = true,                                      -- used when sorting files and directories in the tree
                        sort_function = nil,                                               -- use a custom function for sorting files and directories in the tree
                        default_component_configs = {
                            container = {
                                enable_character_fade = true
                            },
                            indent = {
                                indent_size = 2,
                                padding = 1, -- extra padding on left hand side
                                -- indent guides
                                with_markers = true,
                                indent_marker = "│",
                                last_indent_marker = "└",
                                highlight = "NeoTreeIndentMarker",
                                -- expander config, needed for nesting files
                                with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                                expander_collapsed = "",
                                expander_expanded = "",
                                expander_highlight = "NeoTreeExpander"
                            },
                            icon = {
                                folder_closed = "",
                                folder_open = "",
                                folder_empty = "󰜌",
                                -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                                -- then these will never be used.
                                default = "*",
                                highlight = "NeoTreeFileIcon"
                            },
                            modified = {
                                symbol = "[+]",
                                highlight = "NeoTreeModified"
                            },
                            name = {
                                trailing_slash = false,
                                use_git_status_colors = true,
                                highlight = "NeoTreeFileName"
                            },
                            git_status = {
                                symbols = {
                                    -- Change type
                                    added = "",    -- or "✚", but this is redundant info if you use git_status_colors on the name
                                    modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                                    deleted = "✖",
                                    -- this can only be used in the git_status source
                                    renamed = "󰁕",
                                    -- this can only be used in the git_status source
                                    -- Status type
                                    untracked = "",
                                    ignored = "",
                                    unstaged = "󰄱",
                                    staged = "",
                                    conflict = ""
                                }
                            },
                            -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
                            file_size = {
                                enabled = true,
                                required_width = 64 -- min width of window required to show this column
                            },
                            type = {
                                enabled = true,
                                required_width = 122 -- min width of window required to show this column
                            },
                            last_modified = {
                                enabled = true,
                                required_width = 88 -- min width of window required to show this column
                            },
                            created = {
                                enabled = true,
                                required_width = 110 -- min width of window required to show this column
                            },
                            symlink_target = {
                                enabled = false
                            }
                        },
                        -- A list of functions, each representing a global custom command
                        -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
                        -- see `:h neo-tree-custom-commands-global`
                        commands = {},
                        window = {
                            position = "left",
                            width = 40,
                            mapping_options = {
                                noremap = true,
                                nowait = true
                            },
                            mappings = {
                                ["<space>"] = {
                                    "toggle_node",
                                    nowait = false -- disable `nowait` if you have existing combos starting with this char that you want to use
                                },
                                ["<2-LeftMouse>"] = "open",
                                ["<cr>"] = "open",
                                ["<esc>"] = "cancel", -- close preview or floating neo-tree window
                                ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
                                -- Read `# Preview Mode` for more information
                                -- ["l"] = "focus_preview",
                                ["l"] = "open",
                                ["S"] = "open_split",
                                ["s"] = "open_vsplit",
                                -- ["S"] = "split_with_window_picker",
                                -- ["s"] = "vsplit_with_window_picker",
                                ["t"] = "open_tabnew",
                                -- ["<cr>"] = "open_drop",
                                -- ["t"] = "open_tab_drop",
                                ["w"] = "open_with_window_picker",
                                --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
                                ["C"] = "close_node",
                                ["h"] = "close_node",
                                -- ['C'] = 'close_all_subnodes',
                                ["z"] = "close_all_nodes",
                                --["Z"] = "expand_all_nodes",
                                ["a"] = {
                                    "add",
                                    -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
                                    -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                                    config = {
                                        show_path = "none" -- "none", "relative", "absolute"
                                    }
                                },
                                ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
                                ["d"] = "delete",
                                ["r"] = "rename",
                                ["y"] = "copy_to_clipboard",
                                ["x"] = "cut_to_clipboard",
                                ["p"] = "paste_from_clipboard",
                                ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
                                -- ["c"] = {
                                --  "copy",
                                --  config = {
                                --    show_path = "none" -- "none", "relative", "absolute"
                                --  }
                                --}
                                ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
                                ["q"] = "close_window",
                                ["R"] = "refresh",
                                ["?"] = "show_help",
                                ["<"] = "prev_source",
                                [">"] = "next_source",
                                ["i"] = "show_file_details"
                            }
                        },
                        nesting_rules = {},
                        filesystem = {
                            filtered_items = {
                                visible = false, -- when true, they will just be displayed differently than normal items
                                hide_dotfiles = false,
                                hide_gitignored = true,
                                hide_hidden = true, -- only works on Windows for hidden files/directories
                                hide_by_name = {},
                                hide_by_pattern = {},
                                always_show = {},
                                never_show = {},
                                never_show_by_pattern = {}
                            },
                            follow_current_file = {
                                enabled = true,                     -- This will find and focus the file in the active buffer every time
                                --               -- the current file is changed while the tree is open.
                                leave_dirs_open = false             -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                            },
                            group_empty_dirs = false,               -- when true, empty folders will be grouped together
                            hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                            -- in whatever position is specified in window.position
                            -- "open_current",  -- netrw disabled, opening a directory opens within the
                            -- window like netrw would, regardless of window.position
                            -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                            use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                            -- instead of relying on nvim autocmd events.
                            window = {
                                mappings = {
                                    ["<bs>"] = "navigate_up",
                                    ["."] = "set_root",
                                    ["H"] = "toggle_hidden",
                                    ["/"] = "fuzzy_finder",
                                    ["D"] = "fuzzy_finder_directory",
                                    ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                                    -- ["D"] = "fuzzy_sorter_directory",
                                    ["f"] = "filter_on_submit",
                                    ["<c-x>"] = "clear_filter",
                                    ["[g"] = "prev_git_modified",
                                    ["]g"] = "next_git_modified",
                                    ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                                    ["oc"] = { "order_by_created", nowait = false },
                                    ["od"] = { "order_by_diagnostics", nowait = false },
                                    ["og"] = { "order_by_git_status", nowait = false },
                                    ["om"] = { "order_by_modified", nowait = false },
                                    ["on"] = { "order_by_name", nowait = false },
                                    ["os"] = { "order_by_size", nowait = false },
                                    ["ot"] = { "order_by_type", nowait = false }
                                },
                                fuzzy_finder_mappings = {
                                    -- define keymaps for filter popup window in fuzzy_finder_mode
                                    ["<down>"] = "move_cursor_down",
                                    ["<C-n>"] = "move_cursor_down",
                                    ["<up>"] = "move_cursor_up",
                                    ["<C-p>"] = "move_cursor_up"
                                }
                            },
                            commands = {} -- Add a custom command or override a global one using the same function name
                        },
                        buffers = {
                            follow_current_file = {
                                enabled = true,         -- This will find and focus the file in the active buffer every time
                                --              -- the current file is changed while the tree is open.
                                leave_dirs_open = true -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                            },
                            group_empty_dirs = true,    -- when true, empty folders will be grouped together
                            show_unloaded = true,
                            window = {
                                mappings = {
                                    ["bd"] = "buffer_delete",
                                    ["<bs>"] = "navigate_up",
                                    ["."] = "set_root",
                                    ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                                    ["oc"] = { "order_by_created", nowait = false },
                                    ["od"] = { "order_by_diagnostics", nowait = false },
                                    ["om"] = { "order_by_modified", nowait = false },
                                    ["on"] = { "order_by_name", nowait = false },
                                    ["os"] = { "order_by_size", nowait = false },
                                    ["ot"] = { "order_by_type", nowait = false }
                                }
                            }
                        },
                        git_status = {
                            window = {
                                position = "float",
                                mappings = {
                                    ["A"] = "git_add_all",
                                    ["gu"] = "git_unstage_file",
                                    ["ga"] = "git_add_file",
                                    ["gr"] = "git_revert_file",
                                    ["gc"] = "git_commit",
                                    ["gp"] = "git_push",
                                    ["gg"] = "git_commit_and_push",
                                    ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                                    ["oc"] = { "order_by_created", nowait = false },
                                    ["od"] = { "order_by_diagnostics", nowait = false },
                                    ["om"] = { "order_by_modified", nowait = false },
                                    ["on"] = { "order_by_name", nowait = false },
                                    ["os"] = { "order_by_size", nowait = false },
                                    ["ot"] = { "order_by_type", nowait = false }
                                }
                            }
                        }
                    }
                )

                vim.api.nvim_set_keymap("n", "<leader>ot", ":Neotree toggle reveal<cr>", { noremap = true })
            end
        },
        {
            "nvim-treesitter/nvim-treesitter",
            -- build = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup {
                    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                    -- Install parsers synchronously (only applied to `ensure_installed`)
                    sync_install = false,
                    -- Automatically install missing parsers when entering buffer
                    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                    auto_install = true,
                    highlight = {
                        enable = true, -- false will disable the whole extension
                        additional_vim_regex_highlighting = false
                    },
                    indent = {
                        enable = true
                    }
                }
                require "treesitter-context".setup {
                    enable = true,   -- Enable this plugin (Can be enabled/disabled later via TSContextToggle)
                    throttle = true, -- Throttles plugin updates (may improve performance)
                    max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
                    mode = "topline" -- Line used to calculate context. Choices: 'cursor', 'topline'
                }
            end
        },
        { "nvim-treesitter/nvim-treesitter-context" },
        {"tpope/vim-commentary"},
        "tpope/vim-abolish",
        { "adoy/vim-php-refactoring-toolbox", ft = "php" },
        { "phux/php-doc-modded",              ft = "php" },
        {
            "phpactor/phpactor",
            ft="php",
            build = " composer install --no-dev -o"
        },
        { "sebdah/vim-delve",  ft = "go" },
        { "rhysd/vim-go-impl", ft = "go" },
        {
            "akinsho/bufferline.nvim",
            dependencies = "nvim-tree/nvim-web-devicons",
            config = function()
                require "bufferline".setup()
            end
        },
        {
            "windwp/nvim-autopairs",
            lazy=true,
            config = function()
                require("nvim-autopairs").setup {}
            end
        },
        { "hashivim/vim-terraform", lazy = true,       ft = "tf" },
        {
            "easymotion/vim-easymotion",
            lazy = true,
            keys = {"<space>f"},
            config = function()
                local U = require "utils"
                U.map("n", "<leader>f", "<Plug>(easymotion-bd-w)", { noremap = false })
            end
        },
        { "jparise/vim-graphql",    ft = { "graphql" } },
        {
            "hoob3rt/lualine.nvim",
            config = function()
                require("lualine").setup {
                    options = {
                        theme = "gruvbox"
                    },
                    sections = {
                        lualine_a = {
                            -- "g:coc_status",
                            "mode"
                        },
                        -- lualine_b = {"branch"},
                        lualine_b = { "branch", "b:gitsigns_status" },
                        lualine_c = {
                            {
                                "diagnostics",
                                -- table of diagnostic sources, available sources:
                                -- 'nvim_lsp', 'nvim', 'coc', 'ale', 'vim_lsp'
                                -- Or a function that returns a table like
                                --   {error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt}
                                sources = { "nvim_diagnostic", "coc", "ale" },
                                -- displays diagnostics from defined severity
                                sections = { "error", "warn", "info", "hint" },
                                diagnostics_color = {
                                    -- Same values like general color option can be used here.
                                    error = "DiagnosticError", -- changes diagnostic's error color
                                    warn = "DiagnosticWarn",   -- changes diagnostic's warn color
                                    info = "DiagnosticInfo",   -- Changes diagnostic's info color
                                    hint = "DiagnosticHint"    -- Changes diagnostic's hint color
                                },
                                symbols = { error = "E", warn = "W", info = "I", hint = "H" },
                                colored = true,           -- displays diagnostics status in color if set to true
                                update_in_insert = false, -- Update diagnostics in insert mode
                                always_visible = false    -- Show diagnostics even if count is 0, boolean or function returning boolean
                            },
                            { "filename", full_name = true, path = 1 }
                        },
                        lualine_x = { "encoding", "fileformat", "filetype" },
                        lualine_y = { "progress" },
                        lualine_z = { "location" }
                    },
                    inactive_sections = {
                        lualine_a = {},
                        lualine_b = {},
                        lualine_c = { { "filename", full_name = true, path = 1 } },
                        lualine_x = { "encoding", "fileformat" },
                        lualine_y = {},
                        lualine_z = {}
                    },
                    extensions = { "fzf" }
                }
            end
        },
        { "zhaozg/vim-diagram", ft="markdown" },
        {
            "SidOfc/mkdx",
            ft = { "markdown", "vimwiki", "vimwiki.markdown" },
            config = function()
                vim.api.nvim_exec(
                    [[
                let g:mkdx#settings     = { 'highlight': { 'enable': 1 },  'enter': { 'shift': 1, 'malformed': 1 },  'links': { 'external': { 'enable': 1 } },  'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },  'fold': { 'enable': 1 }, 'map': {'prefix': '<leader>'}}
                let g:polyglot_disabled = ['markdown']

                let g:mkdx#settings.fold.enable = 1
                nmap <leader>ml <Plug>(mkdx-toggle-list-n)
                xmap <leader>ml <Plug>(mkdx-toggle-list-v)
                nmap <leader>mc <Plug>(mkdx-toggle-checkbox-n)
                xmap <leader>mc <Plug>(mkdx-toggle-checkbox-v)


                ]],
                    true
                )
            end
        },
        "ActivityWatch/aw-watcher-vim",
        {
            "phux/vim-marker",
            config = function()
                vim.api.nvim_exec(
                    [[
            let g:MarkerNextMarkMapping = '<m-,>'
            let g:MarkerPrevMarkMapping = '<m-.>'
            let g:MarkerToggleMarkMapping = '<m-m>'
            ]],
                    { noremap = true }
                )
            end
        },
        "simnalamburt/vim-mundo",
        {
            "nvim-orgmode/orgmode",
            ft = {"org"},
            config = function()
                require("orgmode").setup {
                    org_agenda_files = { "~/Dropbox/org/*" },
                    org_default_notes_file = "~/Dropbox/org/refile.org",
                    diagnostics = false,
                    org_agenda_skip_scheduled_if_done = true,
                    org_agenda_skip_deadline_if_done = true,
                    org_hide_leading_stars = true,
                    -- org_hide_emphasis_markers = true,
                    win_split_mode = "auto",
                    mappings = {
                        org = {
                            org_set_tags_command = { "gA" }
                        },
                        capture = {
                            org_set_tags_command = { "gA" }
                        }
                    },
                    org_agenda_templates = { t = { description = "Task", template = "* TODO %?\n SCHEDULED: %t\n %u" } }
                }
                require("orgmode").setup_ts_grammar()
            end,
            dependencies = {
                "akinsho/org-bullets.nvim"
            }
        },
        { "dhruvasagar/vim-table-mode" },
        {
            "nacro90/numb.nvim",
            keys = {":"},
            config = function()
                require('numb').setup()
            end
        }, -- peek lines
        { "chrisgrieser/nvim-puppeteer" },
        -- { "ggandor/lightspeed.nvim", keys={"S", "s"} },
        { "christoomey/vim-tmux-navigator" },
        { "tmux-plugins/vim-tmux-focus-events" },
        {
            "neoclide/coc.nvim",
            branch = "release",
            config = function()
                local U = require "utils"
                local vim = vim
                local api = vim.api
                local fn = vim.fn

                vim.g.coc_global_extensions = {
                    "coc-calc",
                    "coc-css",
                    "coc-docker",
                    "coc-html",
                    "coc-sumneko-lua",
                    "coc-json",
                    "coc-lists",
                    "coc-pyright",
                    "coc-sh",
                    "coc-snippets",
                    "coc-solargraph",
                    "coc-syntax",
                    "coc-vimlsp",
                    "coc-xml",
                    "coc-yaml",
                    "coc-yank",
                    "coc-tsserver",
                    "coc-phpls",
                    "coc-go",
                    "coc-markmap",
                    "coc-spell-checker",
                    "coc-cspell-dicts",
                    "coc-markdown-preview-enhanced",
                    "coc-webview",
                    "coc-toml",
                    "coc-swagger",
                    "coc-sqlfluff",
                    "@yaegassy/coc-nginx"
                }

                local autocmds = {
                    coc_go = {}
                }
                U.augroups(autocmds)

                -- Use tab for trigger completion with characters ahead and navigate.
                -- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
                -- other plugin before putting this into your config.
                -- Source: https://github.com/nanotee/nvim-lua-guide#vlua
                -- function _G.check_back_space()
                --     local col = fn.col(".") - 1
                --     if col == 0 or fn.getline("."):sub(col, col):match("%s") then
                --         return true
                --     else
                --         return false
                --     end
                -- end
                local keyset = vim.keymap.set
                function _G.check_back_space()
                    local col = vim.fn.col(".") - 1
                    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
                end

                local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
                keyset("i", "<TAB>",
                    'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
                keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

                local remap = vim.api.nvim_set_keymap
                local npairs = require("nvim-autopairs")
                npairs.setup({ map_cr = false })
                _G.MUtils = {}
                MUtils.completion_confirm = function()
                    if vim.fn["coc#pum#visible"]() ~= 0 then
                        return vim.fn["coc#pum#confirm"]()
                    else
                        return npairs.autopairs_cr()
                    end
                end

                remap("i", "<CR>", "v:lua.MUtils.completion_confirm()", { expr = true, noremap = true })

                api.nvim_set_keymap("n", "<leader>lf", "<Plug>(coc-codeaction-cursor)", { noremap = true })
                api.nvim_set_keymap("v", "<leader>lf", "<plug>(coc-codeaction-selected)", { noremap = true })
                api.nvim_set_keymap("n", "<leader>ll", "<Plug>(coc-codelens-action)", { noremap = false })
                U.map("n", "<leader>qf", "<Plug>(coc-fix-current)", { noremap = false })
                U.map("n", "<leader>rr", "<Plug>(coc-rename)", { noremap = false })
                U.map("n", "<leader>RR", "<Plug>(coc-refactor)", { noremap = true })
                U.map("n", "<leader>rs", ":CocSearch <c-r><c-w><cr>", { noremap = false })
                U.map("n", "<leader>RS", ":CocSearch -w <c-r><c-w><cr>", { noremap = false })
                U.map("n", "<leader>nd", "<Plug>(coc-definition)", { noremap = false })
                U.map("n", "<leader>nD", "<Plug>(coc-type-definition)", { noremap = false })
                U.map("n", "<leader>ni", "<Plug>(coc-implementation)", { noremap = false })
                U.map("n", "<leader>nr", "<Plug>(coc-references)", { noremap = false }) -- replaced with telescope
                api.nvim_set_keymap("n", "<leader>os", ":CocList -I symbols<cr>", { noremap = true })

                api.nvim_set_keymap("n", "<leader>lh", ":call CocAction('showIncomingCalls')<cr>", { noremap = false })
                U.map("n", "[g", "<Plug>(coc-diagnostic-prev)", { noremap = false })
                U.map("n", "]g", "<Plug>(coc-diagnostic-next)", { noremap = false })

                U.map("n", "<leader>Y", ":<C-u>CocList -A --normal yank<cr>", { noremap = false })

                keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")

                api.nvim_set_keymap("n", "<leader>gi", ":CocCommand git.chunkInfo<cr>", { noremap = true })

                function _G.show_docs()
                    local cw = vim.fn.expand("<cword>")
                    if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
                        vim.api.nvim_command("h " .. cw)
                    elseif vim.api.nvim_eval("coc#rpc#ready()") then
                        vim.fn.CocActionAsync("doHover")
                    else
                        vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
                    end
                end

                U.map("n", "K", "<CMD>lua show_docs()<CR>")

                vim.cmd(
                    [[
                let g:coc_explorer_global_presets = {'simplify': { 'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]' }}
                ]]
                )
            end
        },
        "antoinemadec/coc-fzf",
        "honza/vim-snippets",
        {
            "triglav/vim-visual-increment",
            lazy = true
        },
        {
            "junegunn/gv.vim",
            lazy = true,
            config = function()
                vim.api.nvim_set_keymap("v", "<leader>gl", ":GV<cr>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<leader>gS", ":GV! -S", { noremap = true })
            end
        },
        { "majutsushi/tagbar",                        cmd = "TagbarToggle" },
        "wellle/targets.vim",
        "wellle/tmux-complete.vim",
        {
            "nvim-telescope/telescope.nvim",
            branch = "0.1.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope-fzy-native.nvim"
            },
            config = function()
                local U = require "utils"
                local vim = vim
                local actions = require("telescope.actions")

                local telescope = require("telescope")
                local previewers = require("telescope.previewers")

                -- start customized find_files
                local telescopeConfig = require("telescope.config")

                -- Clone the default Telescope configuration
                local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

                -- I want to search in hidden/dot files.
                table.insert(vimgrep_arguments, "--hidden")
                -- I don't want to search in the `.git` directory.
                table.insert(vimgrep_arguments, "--glob")
                table.insert(vimgrep_arguments, "!**/.git/*")
                -- start customized find_files

                local new_maker = function(filepath, bufnr, opts)
                    opts = opts or {}

                    filepath = vim.fn.expand(filepath)
                    vim.loop.fs_stat(
                        filepath,
                        function(_, stat)
                            if not stat then
                                return
                            end
                            if stat.size > 100000 then
                                return
                            else
                                previewers.buffer_previewer_maker(filepath, bufnr, opts)
                            end
                        end
                    )
                end

                telescope.setup {
                    defaults = {
                        layout_strategy = "flex",
                        dynamic_preview_title = true,
                        file_ignore_patterns = { "^.git/", "^vendor/", "^node_modules/" },
                        vimgrep_arguments = {
                            "rg",
                            "--color=never",
                            "--no-heading",
                            "--with-filename",
                            "--line-number",
                            "--column",
                            "--hidden",
                            "-g",
                            "!.git/",
                            "-g",
                            "!vendor/",
                            "-g",
                            "!node_modules/",
                            "-g",
                            "!dist/",
                            "--smart-case"
                        },
                        winblend = 0,
                        color_devicons = false,
                        mappings = {
                            i = {
                                ["<esc>"] = actions.close
                            }
                        },
                        file_previewer = require "telescope.previewers".vim_buffer_cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
                        buffer_previewer_maker = new_maker,
                        grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new
                    },
                    extensions = {
                        fzy_native = {
                            override_generic_sorter = true,
                            override_file_sorter = true
                        }
                    }
                }

                telescope.load_extension("fzy_native")


                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "<leader>ob", builtin.buffers, {})
                vim.keymap.set("n", "<leader>oo", builtin.resume, {})
                vim.api.nvim_set_keymap("n", "<leader>vl", ":Telescope find_files cwd=~/.dotfiles/roles/neovim<cr>",
                    { noremap = true })

                vim.api.nvim_set_keymap("n", "<leader>GL", ":Telescope git_bcommits<cr>", { noremap = true })

                vim.keymap.set("n", "<leader>of", builtin.find_files, {})
                vim.api.nvim_set_keymap("n", "<leader>og", ":Telescope git_files theme=get_ivy<cr>",
                    { noremap = true, silent = true })
                vim.api.nvim_set_keymap("n", "<leader>sg", "<cmd>lua grepFromGitRoot()<cr>",
                    { noremap = true, silent = true })
                vim.api.nvim_set_keymap("n", "<leader>SG", "<cmd>lua grepStringFromGitRoot()<cr>",
                    { noremap = true, silent = true })
                vim.api.nvim_set_keymap("n", "<leader>su", ":Telescope grep_string theme=get_ivy<cr>",
                    { noremap = true, silent = true })
                vim.api.nvim_set_keymap("n", "<leader>st", ":Telescope live_grep theme=get_ivy<cr>",
                    { noremap = true, silent = true })

                local ivy_themed = require "telescope.themes".get_ivy({})

                function _G.fd()
                    local opts = vim.deepcopy(ivy_themed)
                    opts.hidden = true
                    require "telescope.builtin".fd(opts)
                end

                function _G.liveGrep()
                    local opts = vim.deepcopy(ivy_themed)
                    opts.prompt_prefix = "LG> "
                    opts.hidden = true
                    require "telescope.builtin".live_grep(opts)
                end

                function _G.grepFromGitRoot()
                    local opts = vim.deepcopy(ivy_themed)
                    opts.prompt_prefix = "G> "
                    opts.hidden = true
                    opts.use_regex = true
                    opts.cwd = U.GitRoot()
                    require "telescope.builtin".live_grep(opts)
                end

                function _G.grepStringFromGitRoot()
                    local opts = vim.deepcopy(ivy_themed)
                    opts.prompt_prefix = "G> "
                    opts.hidden = true
                    opts.use_regex = true
                    opts.cwd = U.GitRoot()
                    require "telescope.builtin".grep_string(opts)
                end

                function _G.fdFromGitRoot()
                    local opts = vim.deepcopy(ivy_themed)
                    opts.prompt_prefix = "FR> "
                    opts.hidden = true
                    opts.cwd = U.GitRoot()
                    require "telescope.builtin".fd(opts)
                end
            end
        },
        { "nvim-telescope/telescope-fzy-native.nvim", lazy = true },
        { "fannheyward/telescope-coc.nvim",           lazy = true }
    }
)
