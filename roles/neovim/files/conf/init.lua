local execute = vim.api.nvim_command
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

-- vim.api.nvim_set_keymap("n", "<leader>;", ":TagbarToggle<cr>", { noremap = true })

vim.cmd("hi! def link BufTabLineCurrent PmenuSel")
vim.cmd("hi! def link BufTabLineActive TabLineSel")

local autocmds = {
    conf = {
        -- { "BufWritePost",       "~/.dotfiles/*.lua", ":luafile %" },
        -- {"WinEnter", "*", ":call ResizeSplits()"},
        { "BufNewFile,BufRead", "*.graphqls",   "set ft=graphql" },
        { "BufNewFile,BufRead", "*.yaml.jinja", "set ft=yaml" },
        { "BufNewFile,BufRead", "*.yml.jinja",  "set ft=yaml" },
        { "BufNewFile,BufRead", "*.tf",         "set ft=tf" },
        { "BufNewFile,BufRead", "Dockerfile*",  "set ft=dockerfile" },
        { "FocusLost,WinLeave", "*",            ":silent! update" },
        {
            "FileType",
            "vimwiki",
            'let b:AutoPairs = {\'```\': \'```\', \'`\': \'`\', \'"\': \'"\', \'\'\'\': \'\'\'\', \'(\': \')\', \'\'\'\'\'\'\'\': \'\'\'\'\'\'\'\', \'{\': \'}\', \'"""\': \'"""\'}'
        }
    }
}
U.augroups(autocmds)

-- better time tracking via ActivityWatch
vim.cmd("set title")

vim.cmd('nmap gx :exe "!chromium-browser ".shellescape(expand("<cWORD>"))<cr><cr>')


vim.g.notetaker_root_dir = "~/Dropbox/1vimwiki/notes/"

vim.g.scratch_persistence_file = ".scratch.vim"
vim.g.scratch_height = 10

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
        { "godlygeek/tabular" },
        -- { "roman/golden-ratio" },
        {
            "beauwilliams/focus.nvim",
            config = function()
                require("focus").setup({
                    enable = true,            -- Enable module
                    commands = true,          -- Create Focus commands
                    autoresize = {
                        enable = true,        -- Enable or disable auto-resizing of splits
                        width = 0,            -- Force width for the focused window
                        height = 0,           -- Force height for the focused window
                        minwidth = 0,         -- Force minimum width for the unfocused window
                        minheight = 0,        -- Force minimum height for the unfocused window
                        height_quickfix = 10, -- Set the height of quickfix panel
                    },
                    split = {
                        bufnew = false, -- Create blank buffer for new split windows
                        tmux = false,   -- Create tmux splits instead of neovim splits
                    },
                    ui = {
                        number = false,                    -- Display line numbers in the focussed window only
                        relativenumber = false,            -- Display relative line numbers in the focussed window only
                        hybridnumber = false,              -- Display hybrid line numbers in the focussed window only
                        absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

                        cursorline = true,                 -- Display a cursorline in the focussed window only
                        cursorcolumn = false,              -- Display cursorcolumn in the focussed window only
                        colorcolumn = {
                            enable = false,                -- Display colorcolumn in the foccused window only
                            list = '+1',                   -- Set the comma-saperated list for the colorcolumn
                        },
                        signcolumn = true,                 -- Display signcolumn in the focussed window only
                        winhighlight = false,              -- Auto highlighting for focussed/unfocussed windows
                    }
                })

                local ignore_filetypes = { 'neo-tree', 'Outline' }
                local ignore_buftypes = { 'nofile', 'prompt', 'popup' }

                local augroup =
                    vim.api.nvim_create_augroup('FocusDisable', { clear = true })

                vim.api.nvim_create_autocmd('WinEnter', {
                    group = augroup,
                    callback = function(_)
                        if vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
                        then
                            vim.w.focus_disable = true
                        else
                            vim.w.focus_disable = false
                        end
                    end,
                    desc = 'Disable focus autoresize for BufType',
                })

                vim.api.nvim_create_autocmd('FileType', {
                    group = augroup,
                    callback = function(_)
                        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
                            vim.b.focus_disable = true
                        else
                            vim.b.focus_disable = false
                        end
                    end,
                    desc = 'Disable focus autoresize for FileType',
                })
            end
        },
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
                -- vim.api.nvim_set_keymap("n", "<leader>gc", ":Gcommit -v<cr>", {noremap = true}) -- replaced by diffview

                function _G.pushIfNotMainMasterOrStaging()
                    vim.cmd([[
                        let gitBranch = system("git rev-parse --abbrev-ref HEAD")
                        if "main" ==# gitBranch || "staging" ==# gitBranch
                            echo "you are in main/staging - no direct push"
                        else
                            execute ":Git push"
                        endif
                    ]])
                end

                vim.api.nvim_set_keymap("n", "<leader>gp", "<cmd>lua pushIfNotMainMasterOrStaging()<cr>",
                    { noremap = true, silent = true })
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
                vim.api.nvim_set_keymap("n", "<leader>do", ":DiffviewOpen<cr>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<leader>do", ":DiffviewOpen<cr>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<leader>gs", ":DiffviewOpen<cr>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<leader>gc", ":DiffviewOpen<cr>", { noremap = true })
                vim.keymap.set({ "n", "v" }, "<leader>df", ":DiffviewFileHistory", { noremap = true })
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
            "mfussenegger/nvim-lint",
            config = function()
                require('lint').linters_by_ft = {
                    markdown = { 'vale', 'markdownlint' },
                    -- markdown = { 'markdownlint' },
                    text = { 'vale' },
                    yaml = { 'yamllint' },
                    json = { 'jsonlint' },
                    php = { 'php', 'phpstan' },
                    go = { 'golangcilint' },
                    terraform = { 'tfsec', 'tflint' },
                    dockerfile = { 'hadolint' },
                    bash = { 'shellcheck' },
                    lua = { 'luacheck' },
                    html = { 'tidy' },
                    typescript = { 'eslint_d' },
                }
                vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                    callback = function()
                        require("lint").try_lint()
                    end,
                })
            end
        },
        {
            "kylechui/nvim-surround",
            version = "*", -- Use for stability; omit to use `main` branch for the latest features
            event = "VeryLazy",
            config = function()
                require("nvim-surround").setup({
                    -- Configuration here, or leave empty to use defaults
                })
            end
        },
        {
            "pwntester/octo.nvim",
            cmd = "Octo",
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
            keys = { '<space>k', '<space>j', },
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
                require("hlslens").setup {
                    calm_down = true -- [[If calm_down is true, clear all lens and highlighting When the cursor is out of the position range of the matched instance or any texts are changed]],
                }

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
                                enabled = true,        -- This will find and focus the file in the active buffer every time
                                --              -- the current file is changed while the tree is open.
                                leave_dirs_open = true -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                            },
                            group_empty_dirs = true,   -- when true, empty folders will be grouped together
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
        {
            "nvim-treesitter/nvim-treesitter-context",
        },
        {
            'numToStr/Comment.nvim',
            opts = {},
            lazy = false,
            config = function()
                require('Comment').setup()
            end
        },
        {
            "johmsalas/text-case.nvim",
            config = function()
                require('textcase').setup {}
                vim.cmd([[
                    nnoremap ga_ :lua require('textcase').current_word('to_snake_case')<CR>
                    nnoremap ga- :lua require('textcase').current_word('to_dash_case')<CR>
                    nnoremap ga. :lua require('textcase').current_word('to_dot_case')<CR>
        ]])
            end
        }, -- nvim abolish alternative
        { "adoy/vim-php-refactoring-toolbox", ft = "php" },
        { "phux/php-doc-modded",              ft = "php" },
        {
            "phpactor/phpactor",
            ft = "php",
            build = " composer install --no-dev -o"
        },
        { "sebdah/vim-delve",  ft = "go" },
        {
            'simondrake/gomodifytags',
            dependencies = { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
            opts = {
                transformation = "camelCase",
                skip_unexported = true,
                override = false,
                options = {}
            },
        },
        {
            "phux/gotests-vim",
            branch = "patch-1",
            ft = "go",
            config = function()
                vim.api.nvim_set_keymap("n", "<leader>gt", ":GoTests<cr>", { noremap = true })
            end
        },
        { "rhysd/vim-go-impl", ft = "go" },
        {
            "akinsho/bufferline.nvim",
            dependencies = "nvim-tree/nvim-web-devicons",
            config = function()
                require "bufferline".setup()
            end
        },
        -- {
        --     "windwp/nvim-autopairs",
        --     config = function()
        --         local npairs = require "nvim-autopairs"
        --         require("nvim-autopairs").setup({
        --             npairs.setup {
        --                 check_ts = true,
        --             },
        --             npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")
        --         })
        --     end
        -- },
        {
            'altermo/ultimate-autopair.nvim',
            event = { 'InsertEnter', 'CmdlineEnter' },
            branch = 'v0.6', --recomended as each new version will have breaking changes
            opts = {
                --Config goes here
            },
        },
        {
            "RRethy/nvim-treesitter-endwise",
            config = function()
                require('nvim-treesitter.configs').setup {
                    endwise = {
                        enable = true,
                    },
                }
            end
        },
        {
            'monkoose/matchparen.nvim',
            config = function()
                require('matchparen').setup({
                    on_startup = true,           -- Should it be enabled by default
                    hl_group = 'MatchParen',     -- highlight group of the matched brackets
                    augroup_name = 'matchparen', -- almost no reason to touch this unless there is already augroup with such name
                    debounce_time = 100,         -- debounce time in milliseconds for rehighlighting of brackets.
                })
            end
        },
        {
            "hiphish/rainbow-delimiters.nvim",
            config = function()
                local rainbow_delimiters = require 'rainbow-delimiters'

                vim.g.rainbow_delimiters = {
                    strategy = {
                        [''] = rainbow_delimiters.strategy['global'],
                        vim = rainbow_delimiters.strategy['local'],
                    },
                    query = {
                        [''] = 'rainbow-delimiters',
                        lua = 'rainbow-blocks',
                    },
                    priority = {
                        [''] = 110,
                        lua = 210,
                    },
                    highlight = {
                        -- 'RainbowDelimiterRed',
                        'RainbowDelimiterYellow',
                        'RainbowDelimiterOrange',
                        'RainbowDelimiterGreen',
                        'RainbowDelimiterBlue',
                        'RainbowDelimiterViolet',
                        'RainbowDelimiterCyan',
                    },
                }
            end
        },
        { "hashivim/vim-terraform", ft = "tf" },
        {
            "easymotion/vim-easymotion",
            keys = { "<space>f" },
            config = function()
                local util = require "utils"
                util.map("n", "<leader>f", "<Plug>(easymotion-bd-w)", { noremap = false })
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
                        lualine_a = { "mode" },
                        lualine_b = { "branch", "b:gitsigns_status" },
                        lualine_c = {
                            {
                                "diagnostics",
                                -- table of diagnostic sources, available sources:
                                -- 'nvim_lsp', 'nvim', 'coc', 'ale', 'vim_lsp'
                                -- Or a function that returns a table like
                                --   {error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt}
                                sources = { "nvim_diagnostic", },
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
                                always_visible = false    -- Show diagnostics even if count is
                                -- 0, boolean or function returning boolean
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
                -- listen lsp-progress event and refresh lualine
                vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
                vim.api.nvim_create_autocmd("User", {
                    group = "lualine_augroup",
                    pattern = "LspProgressStatusUpdated",
                    callback = require("lualine").refresh,
                })
            end
        },
        { "zhaozg/vim-diagram",   ft = "markdown" },
        {
            "SidOfc/mkdx",
            ft = { "markdown", "vimwiki", "vimwiki.markdown" },
            config = function()
                vim.api.nvim_exec(
                    [[
                let g:mkdx#settings     = { 'highlight': { 'enable': 1 },  'enter': { 'shift': 1, 'malformed': 1 },  'links': { 'external': { 'enable': 1 } },  'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },  'fold': { 'enable': 1 }, 'map': {'prefix': '<leader>'}}
                let g:polyglot_disabled = ['markdown']

                let g:mkdx#settings.fold.enable = 1


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
            ft = { "org" },
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
        {
            "dhruvasagar/vim-table-mode",
        },
        {
            "nacro90/numb.nvim",
            keys = { ":" },
            config = function()
                require('numb').setup()
            end
        }, -- peek lines
        {
            "chrisgrieser/nvim-puppeteer",
        },
        -- { "ggandor/lightspeed.nvim", keys={"S", "s"} },
        {
            "christoomey/vim-tmux-navigator",
        },
        {
            "tmux-plugins/vim-tmux-focus-events",
        },
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v3.x',
        },
        {
            'williamboman/mason.nvim',
            config = function()
                require("mason").setup()
            end
        },
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("mason-lspconfig").setup {
                    -- A list of servers to automatically install if they're not already installed.
                    -- Example: { "rust_analyzer@nightly", "lua_ls" }
                    -- This setting has no relation with the `automatic_installation` setting.
                    -- see https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
                    ---@type string[]
                    ensure_installed = {
                        'lua_ls',
                        'ansiblels',
                        'bashls',
                        'cssls',
                        'dockerls',
                        'docker_compose_language_service',
                        'gopls',
                        'golangci_lint_ls',
                        'graphql',
                        'html',
                        'jsonls',
                        'tsserver',
                        'marksman', -- markdown
                        'spectral', -- openapi
                        'intelephense',
                        'pyright',
                        -- 'ruby_ls',
                        'sqlls',
                        'taplo', -- toml
                        'terraformls',
                        'vimls',
                        'lemminx',
                        'yamlls',
                        -- 'hadolint',
                        -- 'tfsec',
                    },

                    -- Whether servers that are set up (via lspconfig) should be automatically installed
                    -- if they're not already installed.
                    -- This setting has no relation with the `ensure_installed` setting.
                    -- Can either be:
                    --   - false: Servers are not automatically installed.
                    --   - true: All servers set up via lspconfig are automatically installed.
                    --   - { exclude: string[] }: All servers set up via lspconfig,
                    --   except the ones provided in the list, are automatically installed.
                    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
                    ---@type boolean
                    automatic_installation = true,
                }
            end
        },
        { "neovim/nvim-lspconfig" },
        {
            "b0o/schemastore.nvim",
        },
        {
            "ray-x/lsp_signature.nvim",
            event = "VeryLazy",
            opts = {
                floating_window_above_cur_line = true,
                close_timeout = 1000,
                hint_enable = false,
            },
            config = function(_, opts) require 'lsp_signature'.setup(opts) end
        },
        {
            "aznhe21/actions-preview.nvim",
            -- keys = { '<space>ca' },
            config = function()
                vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions)
            end,
        },
        {
            "smjonas/inc-rename.nvim",
            keys = { '<space>rn' },
            config = function()
                require("inc_rename").setup()
                vim.keymap.set("n", "<leader>rn", function()
                    return ":IncRename " .. vim.fn.expand("<cword>")
                end, { expr = true })
            end,
        },
        {
            "hrsh7th/nvim-cmp",
            config = function()
                -- import nvim-cmp plugin safely
            end,
            dependencies = {
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
                "chrisgrieser/cmp_yanky",
                "hrsh7th/cmp-calc",
                "saadparwaiz1/cmp_luasnip",
                "andersevenrud/cmp-tmux",
                "lukas-reineke/cmp-rg",
            }

        }, -- completion plugin
        {
            "gbprod/yanky.nvim",
            dependencies = {
                { "kkharji/sqlite.lua" }
            },
            opts = {
                ring = { storage = "sqlite" },
                highlight = {
                    on_put = true,
                    on_yank = true,
                    timer = 200,
                },
            },
            keys = {
                { "<leader>P", function() require("telescope").extensions.yank_history.yank_history({}) end, desc = "Open Yank History" },
                { "y",         "<Plug>(YankyYank)",                                                          mode = { "n", "x" },                           desc = "Yank text" },
                { "p",         "<Plug>(YankyPutAfter)",                                                      mode = { "n", "x" },                           desc = "Put yanked text after cursor" },
                { "P",         "<Plug>(YankyPutBefore)",                                                     mode = { "n", "x" },                           desc = "Put yanked text before cursor" },
                { "]p",        "<Plug>(YankyPutIndentAfterLinewise)",                                        desc = "Put indented after cursor (linewise)" },
                { "[p",        "<Plug>(YankyPutIndentBeforeLinewise)",                                       desc = "Put indented before cursor (linewise)" },
                -- { "]P",        "<Plug>(YankyPutIndentAfterLinewise)",                                        desc = "Put indented after cursor (linewise)" },
                -- { "[P",        "<Plug>(YankyPutIndentBeforeLinewise)",                                       desc = "Put indented before cursor (linewise)" },
                { ">p",        "<Plug>(YankyPutIndentAfterShiftRight)",                                      desc = "Put and indent right" },
                { "<p",        "<Plug>(YankyPutIndentAfterShiftLeft)",                                       desc = "Put and indent left" },
                -- { ">P",        "<Plug>(YankyPutIndentBeforeShiftRight)",                                     desc = "Put before and indent right" },
                -- { "<P",        "<Plug>(YankyPutIndentBeforeShiftLeft)",                                      desc = "Put before and indent left" },
                -- { "=p",        "<Plug>(YankyPutAfterFilter)",                                                desc = "Put after applying a filter" },
                -- { "=P",        "<Plug>(YankyPutBeforeFilter)",                                               desc = "Put before applying a filter" },
            },
        },
        {
            "L3MON4D3/LuaSnip",
            config = function()
                vim.api.nvim_create_user_command(
                    'ES',
                    function(opts)
                        require("luasnip.loaders").edit_snippet_files()
                    end,
                    {}
                )
                vim.cmd([[
                    " press <Tab> to expand or jump in a snippet. These can also be mapped separately
                    " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
                    " imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
                    imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
                    " -1 for jumping backwards.
                    " inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
                    inoremap <silent> <c-k> <cmd>lua require'luasnip'.jump(-1)<Cr>
                ]])
                require("luasnip.loaders.from_vscode").load({ paths = { "~/.dotfiles/roles/neovim/files/luasnippets" } })
            end
        }, -- snippet engine
        {
            "rafamadriz/friendly-snippets",
        },
        -- "honza/vim-snippets",
        {
            "triglav/vim-visual-increment",
        },

        {
            'linrongbin16/lsp-progress.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            config = function()
                require('lsp-progress').setup()
            end
        },
        {
            "junegunn/gv.vim",
            config = function()
                vim.api.nvim_set_keymap("v", "<leader>gl", ":GV<cr>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<leader>gS", ":GV! -S", { noremap = true })
            end
        },
        -- { "majutsushi/tagbar",                        cmd = "TagbarToggle" },
        {
            "hedyhli/outline.nvim",
            cmd = { "Outline", "OutlineOpen" },
            keys = { -- Example mapping to toggle outline
                { "<leader>;", "<cmd>Outline<CR>", desc = "Toggle outline" },
            },
            opts = {},
        },
        {
            "j-hui/fidget.nvim",
            opts = {
                -- options
            },
        },
        {
            "elentok/format-on-save.nvim",
            config = function()
                local format_on_save = require("format-on-save")
                local formatters = require("format-on-save.formatters")

                format_on_save.setup({
                    exclude_path_patterns = {
                        "/node_modules/",
                        ".local/share/nvim/lazy",
                    },
                    formatter_by_ft = {
                        css = formatters.lsp,
                        html = formatters.lsp,
                        java = formatters.lsp,
                        json = formatters.lsp,
                        lua = formatters.lsp,
                        -- go = formatters.lsp,
                        markdown = formatters.prettierd,
                        openscad = formatters.lsp,
                        rust = formatters.lsp,
                        scad = formatters.lsp,
                        scss = formatters.lsp,
                        sh = formatters.shfmt,
                        terraform = formatters.lsp,
                        typescript = formatters.prettierd,
                        typescriptreact = formatters.prettierd,
                        yaml = formatters.lsp,

                        -- Add lazy formatter that will only run when formatting:
                        my_custom_formatter = function()
                            if vim.api.nvim_buf_get_name(0):match("/README.md$") then
                                return formatters.prettierd
                            else
                                return formatters.lsp()
                            end
                        end,

                        -- Add custom formatter
                        -- filetype1 = formatters.remove_trailing_whitespace,
                        -- filetype2 = formatters.custom({
                        --     format = function(lines)
                        --         return vim.tbl_map(function(line)
                        --             return line:gsub("true", "false")
                        --         end, lines)
                        --     end
                        -- }),

                        -- Concatenate formatters
                        python = {
                            formatters.remove_trailing_whitespace,
                            formatters.shell({ cmd = "tidy-imports" }),
                            formatters.black,
                            formatters.ruff,
                        },

                        -- Use a tempfile instead of stdin
                        -- go = {
                        --     formatters.shell({
                        --         cmd = { "goimports-reviser", "-set-alias", "-format", "%" },
                        --         tempfile = function()
                        --             return vim.fn.expand("%") .. '.formatter-tmp'
                        --         end
                        --     }),
                        --     -- formatters.shell({ cmd = { "gofmt" } }),
                        -- },

                    },

                    -- Optional: fallback formatter to use when no formatters match the current filetype
                    fallback_formatter = {
                        formatters.remove_trailing_whitespace,
                        formatters.remove_trailing_newlines,
                        -- formatters.prettierd,
                    },

                    -- By default, all shell commands are prefixed with "sh -c" (see PR #3)
                    -- To prevent that set `run_with_sh` to `false`.
                    run_with_sh = false,
                })
            end
        },
        {
            "dnlhc/glance.nvim",
            config = function()
                require('glance').setup({
                    detached = true,
                    list = {
                        position = 'left', -- Position of the list window 'left'|'right'
                    },
                })
                vim.keymap.set('n', '<leader>nd', '<CMD>Glance definitions<CR>')
                vim.keymap.set('n', 'gd', '<CMD>Glance definitions<CR>')
                vim.keymap.set('n', '<leader>nr', '<CMD>Glance references<CR>')
                vim.keymap.set('n', 'gr', '<CMD>Glance references<CR>')
                vim.keymap.set('n', '<leader>nD', '<CMD>Glance type_definitions<CR>')
                vim.keymap.set('n', 'gD', '<CMD>Glance type_definitions<CR>')
                vim.keymap.set('n', '<leader>ni', '<CMD>Glance implementations<CR>')
                vim.keymap.set('n', 'gi', '<CMD>Glance implementations<CR>')
            end,
        },
        {
            "folke/trouble.nvim",
            keys = { '<space>dd', "<space>dw" },
            dependencies = { "nvim-tree/nvim-web-devicons" },
            opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            },
            config = function()
                vim.keymap.set("n", "<leader>dd", function() require("trouble").toggle() end)
                vim.keymap.set("n", "<leader>dw", function() require("trouble").toggle("workspace_diagnostics") end)
            end
        },
        "wellle/targets.vim",
        {
            "rgroli/other.nvim",
            config = function()
                require("other-nvim").setup({
                    mappings = {
                        -- builtin mappings
                        -- "livewire",
                        -- "angular",
                        "laravel",
                        -- "rails",
                        "golang",
                        -- custom mapping
                        {
                            pattern = "(.*).php$",
                            target = "%1_Test.php",
                            transformer = "lowercase"
                        }
                    }
                })

                vim.api.nvim_set_keymap("n", "<leader>na", "<cmd>:Other<CR>", { noremap = true, silent = true })
            end
        },
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

                vim.api.nvim_set_keymap("n", "<leader>li", ":Telescope lsp_incoming_calls theme=get_ivy<cr>",
                    { noremap = true, silent = true })
                vim.api.nvim_set_keymap("n", "<leader>lo", ":Telescope lsp_outgoing_calls theme=get_ivy<cr>",
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
        {
            'ray-x/guihua.lua', build = 'cd lua/fzy && make'
        },
        {
            "ray-x/sad.nvim",
            config = function()
                require("sad").setup {}
            end,
        },
        { "nvim-telescope/telescope-fzy-native.nvim" },
        { "fannheyward/telescope-coc.nvim" },
        {
            "andythigpen/nvim-coverage",
            dependencies = "nvim-lua/plenary.nvim",
            config = function()
                require("coverage").setup()
            end,
        }
    }
)

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Displays hover information about the symbol under the cursor
        bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

        -- Jump to the definition
        -- bufmap('n', '<leader>nd', '<cmd>lua vim.lsp.buf.definition()<cr>') -- glance

        -- Jump to declaration
        -- bufmap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.declaration()<cr>') -- glance

        -- Lists all the implementations for the symbol under the cursor
        -- bufmap('n', '<leader>ni', '<cmd>lua vim.lsp.buf.implementation()<cr>') -- glance

        -- Jumps to the definition of the type symbol
        -- bufmap('n', '<leader>nD', '<cmd>lua vim.lsp.buf.type_definition()<cr>') -- glance

        -- Lists all the references  // telescope
        -- bufmap('n', '<leader>nr', '<cmd>lua vim.lsp.buf.references()<cr>')

        -- Displays a function's signature information
        -- bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

        -- Renames all references to the symbol under the cursor
        bufmap('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<cr>')

        -- Selects a code action available at the current cursor position
        bufmap('n', '<leader>ll', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        bufmap('v', '<leader>ll', '<cmd>lua vim.lsp.buf.code_action()<cr>')

        bufmap('n', '<leader>F', '<cmd>lua vim.lsp.buf.format()<cr>')

        -- Show diagnostics in a floating window
        bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

        -- Move to the previous diagnostic
        bufmap('n', '<c-p>', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

        -- Move to the next diagnostic
        bufmap('n', '<c-n>', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    end
})

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        -- vim.api.nvim_create_autocmd("BufWritePre", {
        --     group = augroup,
        --     buffer = bufnr,
        --     callback = function()
        --         vim.lsp.buf.format { async = true }
        --     end,
        -- })
    end
end)

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        -- buf_request_sync defaults to a 1000ms timeout. Depending on your
        -- machine and codebase, you may want longer. Add an additional
        -- argument after params if you find that you have to write the file
        -- twice for changes to be saved.
        -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
        for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
            end
        end
        vim.lsp.buf.format({ async = false })
    end
})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = { "*.go" },
--     callback = function()
--         local params = vim.lsp.util.make_range_params(nil, "utf-16")
--         params.context = { only = { "source.organizeImports" } }
--         local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
--         for _, res in pairs(result or {}) do
--             for _, r in pairs(res.result or {}) do
--                 if r.edit then
--                     vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
--                 else
--                     vim.lsp.buf.execute_command(r.command)
--                 end
--             end
--         end
--     end,
-- })
--
require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,
        gopls = function()
            require('lspconfig').gopls.setup({
                settings = {
                    gopls = {
                        experimentalPostfixCompletions = true,
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                        usePlaceholders = true,
                        gofumpt = true,
                    },
                },
            })
        end,
        jsonls = function()
            require('lspconfig').jsonls.setup {
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            }
        end,
        yamlls = function()
            require('lspconfig').yamlls.setup {
                settings = {
                    yaml = {
                        schemaStore = {
                            -- You must disable built-in schemaStore support if you want to use
                            -- this plugin and its advanced options like `ignore`.
                            enable = false,
                            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                            url = "",
                        },
                        schemas = require('schemastore').yaml.schemas(),
                    },
                },
            }
        end
        -- intelephense expects the licence key in $HOME/intelephense/licence.txt
    },
})

local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
    return
end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
    return
end

-- load VSCode-like snippets from plugins (e.g., friendly-snippets)
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

local has_words_before = function()
    local unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_format = require('lsp-zero').cmp_format()

-- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

-- completion confirmation -> parenthesis
local ind = cmp.lsp.CompletionItemKind

local function ls_name_from_event(event)
    return event.entry.source.source.client.config.name
end

-- Add parenthesis on completion confirmation
cmp.event:on('confirm_done', function(event)
    local ok, ls_name = pcall(ls_name_from_event, event)
    if ok and vim.tbl_contains({ 'rust_analyzer', 'lua_ls', 'gopls' }, ls_name) then
        return
    end

    local completion_kind = event.entry:get_completion_item().kind
    if vim.tbl_contains({ ind.Function, ind.Method }, completion_kind) then
        local left = vim.api.nvim_replace_termcodes('<Left>', true, true, true)
        vim.api.nvim_feedkeys('()' .. left, 'n', false)
    end
end)

cmp.setup({
    formatting = cmp_format,
    preselect = 'item', -- always select first item
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<c-y>"] = cmp.mapping.confirm({ select = true }),
        ['<C-j>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-k>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                -- that way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    -- sources for autocompletion
    sources = cmp.config.sources({
        { name = "nvim_lsp", keyword_length = 1 }, -- LSP
        { name = "luasnip",  keyword_length = 2 }, -- snippets
        { name = "buffer",   keyword_length = 2 }, -- text within the current buffer
        { name = "path" },                         -- file system paths
        { name = 'orgmode' },
        { name = "cmp_yanky" },
        -- {
        --     name = "rg",
        --     -- Try it when you feel cmp performance is poor
        --     keyword_length = 3,
        -- },
        -- {
        --     name = "tmux",
        --     option = {
        --         -- Source from all panes in session instead of adjacent panes
        --         all_panes = true,
        --         capture_history = true,
        --     }
        -- },
    }),
})
