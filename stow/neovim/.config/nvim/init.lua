vim.loader.enable()

local U = require "utils"

vim.o.termguicolors = true

vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_nvim_zip_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("language en_US.utf8")
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true })
vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<leader>vi", ":e ~/.config/nvim/init.lua<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>vc", "<cmd>lua EditFtPluginFile()<cr>",
    { noremap = true })
function _G.EditFtPluginFile()
    vim.cmd("e ~/.config/nvim/ftplugin/" .. vim.bo.filetype ..
        ".vim")
end

vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true })

vim.opt.conceallevel = 1
vim.opt.concealcursor = "nc"

vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.cmd("set foldlevel=1")
vim.cmd("set foldnestmax=1")


if vim.fn.exists("g:colors_name") == 0 then
    if U.load_bright_theme() then
        vim.o.background = "light"
    end
end

vim.o.splitbelow = true
vim.o.splitright = true

vim.cmd("set diffopt+=algorithm:histogram")
vim.cmd("set diffopt+=vertical")
vim.cmd("set diffopt+=hiddenoff")

vim.o.wildmode = "longest,list,full"


vim.o.showmode = false
vim.o.showmatch = false -- don't show matching brackets when text indicator is over them
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.o.ignorecase = true   -- Ignore case when searching...
vim.o.smartcase = true    -- ... unless there is a capital letter in the query
vim.wo.signcolumn = "yes" -- always show the signcolumne to avoid flicker
vim.o.cursorline = false  -- Don't highlight the current line
vim.o.equalalways = false --
vim.o.updatetime = 300    -- Make updates happen faster
vim.o.scrolloff = 10      -- always ten lines below the cursor



vim.o.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
vim.o.breakindent = true
vim.o.breakindentopt = "sbr"
-- wrap lines
vim.o.wrap = true
vim.o.whichwrap = "b,s,<,>,[,],h,l"
-- but don't split words
vim.o.linebreak = true


vim.o.clipboard = "unnamed"

vim.cmd("set undofile")
vim.cmd("set undodir=~/.vim/undo")
vim.o.inccommand = "split"
vim.o.swapfile = false -- Living on the edge
-- vim.o.shada          = { "!", "'1000", "<50", "s10", "h" }

vim.o.mouse = "n"

vim.api.nvim_set_keymap("n", "<leader>sv",
    ":Subs/<c-R><c-w>/<c-r><c-w>/g<left><left>", { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>sv",
    ":Subs/<c-R><c-w>/<c-r><c-w>/g<left><left>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>sr",
    ":s/<c-R><c-w>/<c-r><c-w>/g<left><left>", { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>sr",
    ":s/<c-R><c-w>/<c-r><c-w>/g<left><left>", { noremap = true })

-- shorten messages, don't display intro
vim.cmd("set shortmess+=aIc")

vim.o.formatoptions = "qrn1tclj"

-- if count supplied, move with line numbers, otherwise move visual lines
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", {
    noremap = true,
    expr = true
})
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", {
    noremap = true,
    expr = true
})
vim.api.nvim_set_keymap("n", "<Up>", "&diff ? '[c' : '<Up>'", {
    noremap = true,
    expr = true
})
vim.api.nvim_set_keymap("n", "<Down>", "&diff ? ']c' : '<Down>'", {
    noremap
            = true,
    expr    = true
})

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

vim.api.nvim_set_keymap("n", "<leader>bd", ":bp<bar>bd #<cr>", { noremap = true
})

vim.api.nvim_set_keymap("n", "<leader>p", '"+p', { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>p", '"+p', { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true })
-- vnoremap <silent> y y`]

-- cmode terminal like mappings
vim.api.nvim_set_keymap("c", "<c-p>", "<Up>", { noremap = true })
vim.api.nvim_set_keymap("c", "<c-n>", "<Down>", { noremap = true })
vim.api.nvim_set_keymap("c", "<M-b>", "<S-Left>", { noremap = true })
vim.api.nvim_set_keymap("c", "<M-f>", "<S-Right>", { noremap = true })

-- format json
vim.api.nvim_set_keymap("n", "<M-f>", ":set ft=json <bar> :%!python3 -m json.tool<cr>", { noremap = true })

vim.api.nvim_set_keymap("c", "<M-a>", "<Home>", { noremap = true })

--


vim.filetype.add({
    extension = { har = "json" },
    pattern = { [".*%.ya?ml%.jinja"] = { "yaml", { priority = 10 } } },
})

vim.api.nvim_create_autocmd({ "FocusLost", "WinLeave" }, {
    callback = function() vim.cmd("silent! update") end,
})

-- better time tracking via ActivityWatch (aw-watcher)
vim.cmd("set title")







if vim.fn.executable("rg") == 1 then
    vim.o.grepprg = "rg --vimgrep --no-heading"
    vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

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
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local dark = vim.o.background == "dark"

require("lazy").setup(
    {
        {
            'ellisonleao/gruvbox.nvim',
            lazy = false,
            priority = 1000,
            config = function()
                require("gruvbox").setup({
                    terminal_colors = true, -- add neovim terminal colors
                    undercurl = true,
                    underline = true,
                    bold = true,
                    italic = {
                        strings = false,
                        emphasis = true,
                        comments = true,
                        operators = false,
                        folds = true,
                    },
                    strikethrough = true,
                    invert_selection = false,
                    invert_signs = false,
                    invert_tabline = false,
                    invert_intend_guides = false,
                    inverse = true, -- invert background for search, diffs, statuslines and errors
                    contrast = "",  -- can be "hard", "soft" or empty string
                    palette_overrides = {},
                    overrides = {
                        DiffAdd = { bg = "#335E00" },
                        -- The picker list is never the current window, so dim_inactive painted it with NormalNC,
                        -- the same bg as CursorLine: the selected row vanished. Keep the list on Normal, give the
                        -- selected row its own bg and keep the dimmed directory part readable on both.
                        SnacksPickerList = { link = "Normal" },
                        SnacksPickerListCursorLine = { bg = dark and "#504945" or "#d5c4a1", bold = true },
                        SnacksPickerDir = { fg = dark and "#bdae93" or "#665c54" },
                        -- codediff's history panel draws file counts in NonText and authors in Comment, and
                        -- its selected row in Visual. Gruvbox's NonText is nearly the pane bg (1.3:1), so lift
                        -- it and keep the end-of-buffer tildes as faint as before. Greys are exact xterm-256
                        -- entries: #a89984 snapped to pink (#af8787) through tmux.
                        NonText = { fg = dark and "#a8a8a8" or "#6c6c6c" },
                        EndOfBuffer = { fg = dark and "#504945" or "#d5c4a1" },
                        Comment = { fg = dark and "#a8a8a8" or "#6c6c6c", italic = true },
                        CodeDiffExplorerSelected = { bg = dark and "#504945" or "#d5c4a1" },
                        -- DiffDelete = { bg = "#801919" },
                        -- DiffChange = { bg = "#1d2739" },
                        -- DiffText = { bg = "#3c4e77" },
                    },
                    dim_inactive = true,
                    transparent_mode = false,
                })
                vim.cmd.colorscheme('gruvbox')
            end
        },
        {
            "godlygeek/tabular",
            cmd = "Tabularize",
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
            "tpope/vim-fugitive",
            event = "VeryLazy",
            config = function()
                vim.api.nvim_set_keymap("n", "<leader>gw", ":Gwrite<cr>", { noremap = true })
                vim.api.nvim_set_keymap("n", "<leader>ge", ":Gedit<cr>", { noremap = true })
                -- vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<cr>", {noremap = true})
                vim.api.nvim_set_keymap("n", "<leader>gb", ":Git blame<cr>", { noremap = true })
                -- vim.api.nvim_set_keymap("n", "<leader>gc", ":Gcommit -v<cr>", {noremap = true}) -- replaced by diffview

                function _G.pushIfNotMainMasterOrStaging()
                    local branch = vim.trim(vim.fn.system("git branch --show-current"))
                    if vim.tbl_contains({ "main", "master", "staging" }, branch) then
                        print("you are in main/staging - no direct push")
                    else
                        vim.cmd("Git push")
                    end
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
        {
            "tpope/vim-rhubarb",
            event = "VeryLazy",
        },
        {
            "esmuellert/codediff.nvim",
            cmd = "CodeDiff",
            keys = {
                { "<leader>gs", "<cmd>CodeDiff<cr>" },
                { "<leader>gc", "<cmd>CodeDiff<cr>" },
                { "<leader>df", ":CodeDiff history %",     mode = { "n" } },
                { "<leader>df", ":CodeDiff history %<cr>", mode = { "v" } },
            },
            opts = {
                -- Highlight configuration
                highlights = {
                    -- Line-level: accepts highlight group names or hex colors (e.g., "#2ea043")
                    -- Hex, not DiffAdd/DiffDelete: gruvbox `inverse` makes those reverse-video and the
                    -- derived char colors came out orange/olive, with syntax colors unreadable on top.
                    -- urxvt behind tmux has no truecolor: tmux snaps every color to the xterm-256 palette,
                    -- and dark tints like #2d4a22 snapped to plain grey. Use exact palette entries here.
                    line_insert = dark and "#005f00" or "#d7ffd7", -- Line-level insertions
                    line_delete = dark and "#5f0000" or "#ffd7d7", -- Line-level deletions

                    -- Character-level: accepts highlight group names or hex colors
                    -- If specified, these override char_brightness calculation
                    char_insert = dark and "#008700" or "#afffaf", -- Character-level insertions
                    char_delete = dark and "#af0000" or "#ffafaf", -- Character-level deletions

                    -- Brightness multiplier (only used when char_insert/char_delete are nil)
                    -- nil = auto-detect based on background (1.4 for dark, 0.92 for light)
                    char_brightness = nil, -- Auto-adjust based on your colorscheme

                    -- Conflict sign highlights (for merge conflict views)
                    -- Accepts highlight group names or hex colors (e.g., "#f0883e")
                    -- nil = use default fallback chain
                    conflict_sign = nil,          -- Unresolved: DiagnosticSignWarn -> #f0883e
                    conflict_sign_resolved = nil, -- Resolved: Comment -> #6e7681
                    conflict_sign_accepted = nil, -- Accepted: GitSignsAdd -> DiagnosticSignOk -> #3fb950
                    conflict_sign_rejected = nil, -- Rejected: GitSignsDelete -> DiagnosticSignError -> #f85149
                },

                -- Diff view behavior
                diff = {
                    layout = "side-by-side", -- Diff layout: "side-by-side" (two panes) or "inline" (single pane with virtual lines)
                    filler_text = "╱", -- Repeated filler pattern; use "" for blank alignment rows
                    disable_inlay_hints = true, -- Disable inlay hints in diff windows for cleaner view
                    max_computation_time_ms = 5000, -- Maximum time for diff computation (VSCode default)
                    ignore_trim_whitespace = false, -- Ignore leading and trailing whitespace changes
                    hide_merge_artifacts = false, -- Hide merge tool temp files (*.orig, *.BACKUP.*, *.BASE.*, *.LOCAL.*, *.REMOTE.*)
                    original_position = "left", -- Position of original (old) content: "left" or "right"
                    conflict_ours_position = "right", -- Position of ours (:2) in conflict view: "left" or "right"
                    conflict_result_position = "bottom", -- "bottom" (default): result below diff panes or "center": result between diff panes (three columns)
                    conflict_result_height = 30, -- Height of result pane in bottom layout (% of total height)
                    conflict_result_width_ratio = { 1, 1, 1 }, -- Width ratio for center layout panes {left, center, right} (e.g., {1, 2, 1} for wider result)
                    cycle_next_hunk = true, -- Wrap around when navigating hunks (]c/[c): false to stop at first/last
                    cycle_next_file = true, -- Wrap around when navigating files (]f/[f): false to stop at first/last
                    cycle_hunks_across_files = false, -- ]c/[c at file boundary hops to first/last hunk of next/prev file (explorer/history)
                    jump_to_first_change = true, -- Auto-scroll to first change when opening a diff: false to stay at same line
                    highlight_added_deleted_files = false, -- Tint full contents of added, untracked, and deleted files
                    highlight_priority = 100, -- Priority for line-level diff highlights (increase to override LSP highlights)
                    gutter_signs = false, -- Gutter +/- signs; see Gutter signs below
                    compute_moves = false, -- Detect moved code blocks (opt-in, matches VSCode experimental.showMoves)
                    compact_context_lines = 3, -- Number of context lines around hunks in compact mode
                    compact_sync_folds = true, -- Sync fold open/close across panes (mirrors Vim diff mode behavior)
                    compact = true, -- Default compact preference for each CodeDiff session; toggle with gc
                },

                -- Explorer panel configuration
                explorer = {
                    position = "left", -- "left" or "bottom"
                    hidden = false, -- Initial visibility state
                    width = 40, -- Width when position is "left" (columns)
                    height = 15, -- Height when position is "bottom" (lines)
                    auto_refresh = true, -- Native file watching with polling fallback (R still refreshes manually)
                    indent_markers = true, -- Show indent markers in tree view (│, ├, └)
                    initial_focus = "explorer", -- Initial focus: "explorer", "original", or "modified"
                    icons = {
                        folder_closed = "\u{e5ff}", -- Nerd Font folder icon
                        folder_open = "\u{e5fe}", -- Nerd Font open-folder icon
                    },
                    view_mode = "list", -- "list" or "tree"
                    flatten_dirs = true, -- Flatten single-child directory chains in tree view
                    file_filter = {
                        ignore = { ".git/**", ".jj/**" }, -- Glob patterns to hide (e.g., {"*.lock", "dist/*"})
                    },
                    untracked = "all", -- Untracked scan: "all", "normal" (collapse dirs), or "no" (skip; use for huge work trees like GIT_WORK_TREE=$HOME that hang, #389)
                    focus_on_select = false, -- Jump to modified pane after selecting a file (default: stay in explorer)
                    auto_open_on_cursor = false, -- Rebind j/k/Down/Up in the explorer to also open the file under the cursor
                    status_right_margin = 1, -- Trailing cells between status symbol (M/A/D) and right edge; increase if Nerd Font icons clip it
                    line_stats = {
                        enabled = false, -- Fetch and show Git line statistics
                        count_untracked = false, -- Count untracked file lines as insertions
                        max_untracked_bytes = 1024 * 1024, -- Skip larger untracked files
                    },
                    ellipsis = "…", -- Text appended to truncated Explorer regions
                    formatters = { -- Optional function(ctx) -> line layout callbacks; omit to use the built-ins
                        file = nil, -- File rows
                        folder = nil, -- Directory rows in tree view
                        group = nil, -- Section headers such as Changes and Staged Changes
                    },
                    visible_groups = { -- Which groups to show (can be toggled at runtime)
                        staged = true,
                        unstaged = true,
                        conflicts = true,
                    },
                },

                -- History panel configuration (for :CodeDiff history)
                history = {
                    position = "bottom",       -- "left" or "bottom" (default: bottom)
                    width = 40,                -- Width when position is "left" (columns)
                    height = 15,               -- Height when position is "bottom" (lines)
                    initial_focus = "history", -- Initial focus: "history", "original", or "modified"
                    view_mode = "list",        -- "list" or "tree" for files under commits
                    date_format = "%ar",       -- Commit date rendering: "%ar" (default, relative), "%ai" (ISO), "%ad" (git default), or any strftime string (e.g. "%Y/%m/%d %H:%M:%S")
                },

                -- Keymaps in diff view
                keymaps = {
                    view = {
                        quit = "q",                        -- Close diff tab
                        toggle_explorer = "<leader>b",     -- Toggle explorer visibility (explorer mode only)
                        focus_explorer = "<leader>e",      -- Focus explorer panel (explorer mode only)
                        next_hunk = "]c",                  -- Jump to next change
                        prev_hunk = "[c",                  -- Jump to previous change
                        next_file = "]f",                  -- Next file in explorer/history mode
                        prev_file = "[f",                  -- Previous file in explorer/history mode
                        diff_get = "do",                   -- Get change from other buffer (like vimdiff)
                        diff_put = "dp",                   -- Put change to other buffer (like vimdiff)
                        open_in_prev_tab = "gf",           -- Open current buffer in previous tab (or create one before)
                        close_on_open_in_prev_tab = false, -- Close codediff tab after gf opens file in previous tab
                        toggle_stage = "-",                -- Stage/unstage current file (works in explorer and diff buffers)
                        toggle_staged_view = "gS",         -- Swap between staged/unstaged view of current file (#352)
                        stage_hunk = "<leader>hs",         -- Stage hunk under cursor to git index
                        unstage_hunk = "<leader>hu",       -- Unstage hunk under cursor from git index
                        discard_hunk = "<leader>hr",       -- Discard hunk under cursor (working tree only)
                        hunk_textobject = "ih",            -- Textobject for hunk (vih to select, yih to yank, etc.)
                        show_help = "g?",                  -- Show floating window with available keymaps
                        align_move = "gm",                 -- Temporarily align moved code blocks across panes
                        toggle_layout = "t",               -- Toggle between side-by-side and inline layout
                        toggle_compact = "gc",             -- Toggle compact mode (fold unchanged regions)
                    },
                    -- explorer = { icons = { folder_closed = "", folder_open = "" } },
                    explorer = {
                        select = "<CR>",              -- Open diff for selected file
                        hover = "K",                  -- Show full path
                        refresh = "R",                -- Refresh git status
                        toggle_view_mode = "i",       -- Toggle between 'list' and 'tree' views
                        stage_all = "S",              -- Stage all files
                        unstage_all = "U",            -- Unstage all files
                        restore = "X",                -- Discard changes (restore file)
                        toggle_changes = "gu",        -- Toggle Changes (unstaged) group visibility
                        toggle_staged = "gs",         -- Toggle Staged Changes group visibility
                        -- Fold keymaps (Vim-style)
                        fold_open = "zo",             -- Open fold (expand current node)
                        fold_open_recursive = "zO",   -- Open fold recursively (expand all descendants)
                        fold_close = "zc",            -- Close fold (collapse current node)
                        fold_close_recursive = "zC",  -- Close fold recursively (collapse all descendants)
                        fold_toggle = "za",           -- Toggle fold (expand/collapse current node)
                        fold_toggle_recursive = "zA", -- Toggle fold recursively
                        fold_open_all = "zR",         -- Open all folds in tree
                        fold_close_all = "zM",        -- Close all folds in tree
                    },
                    history = {
                        select = "<CR>",              -- Select commit/file or toggle expand
                        toggle_view_mode = "i",       -- Toggle between 'list' and 'tree' views
                        refresh = "R",                -- Refresh history (re-fetch commits)
                        -- Fold keymaps (Vim-style, apply to directory nodes only)
                        fold_open = "zo",             -- Open fold (expand current node)
                        fold_open_recursive = "zO",   -- Open fold recursively (expand all descendants)
                        fold_close = "zc",            -- Close fold (collapse current node)
                        fold_close_recursive = "zC",  -- Close fold recursively (collapse all descendants)
                        fold_toggle = "za",           -- Toggle fold (expand/collapse current node)
                        fold_toggle_recursive = "zA", -- Toggle fold recursively
                        fold_open_all = "zR",         -- Open all folds in tree
                        fold_close_all = "zM",        -- Close all folds in tree
                    },
                    conflict = {
                        accept_incoming = "<leader>ct",     -- Accept incoming (theirs/left) change
                        accept_current = "<leader>co",      -- Accept current (ours/right) change
                        accept_both = "<leader>cb",         -- Accept both changes
                        discard = "<leader>cx",             -- Discard both, keep base
                        -- Accept all (whole file) - uppercase versions
                        accept_all_incoming = "<leader>cT", -- Accept ALL incoming changes
                        accept_all_current = "<leader>cO",  -- Accept ALL current changes
                        accept_all_both = "<leader>cB",     -- Accept ALL both changes
                        discard_all = "<leader>cX",         -- Discard ALL, reset to base
                        next_conflict = "]x",               -- Jump to next conflict
                        prev_conflict = "[x",               -- Jump to previous conflict
                        diffget_incoming = "2do",           -- Get hunk from incoming (left/theirs) buffer
                        diffget_current = "3do",            -- Get hunk from current (right/ours) buffer
                    },
                },
            },
            -- opts = {
            -- },
        },
        {
            "pwntester/octo.nvim",
            cmd = "Octo",
            opts = {
                -- or "fzf-lua" or "snacks" or "default"
                picker = require("picker").octo,
                -- bare Octo command opens picker of commands
                enable_builtin = true,
            },
            keys = {
                {
                    "<leader>op",
                    "<CMD>Octo pr list<CR>",
                    desc = "List GitHub PullRequests",
                },
                {
                    "<leader>on",
                    "<CMD>Octo notification list<CR>",
                    desc = "List GitHub Notifications",
                },
                -- {
                --     "<leader>os",
                --     function()
                --         require("octo.utils").create_base_search_command { include_current_repo = true }
                --     end,
                --     desc = "Search GitHub",
                -- },
            },
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
            },
        },
        {
            "MagicDuck/grug-far.nvim",
            cmd = "GrugFar",
            keys = {
                { "<leader>SR", function() require("grug-far").open() end, mode = { "n", "x" }, desc = "Search and replace" },
            },
            opts = {},
        },
        {
            "aaronhallaert/advanced-git-search.nvim",
            cmd = "AdvancedGitSearch",
            keys = {
                { "<leader>gf", ":AdvancedGitSearch search_log_content_file<cr>" },
                { "<leader>gl", ":AdvancedGitSearch<cr>" },
            },
            dependencies = { "tpope/vim-fugitive" },
            config = function()
                local opts = { diff_plugin = "fugitive" }
                local picker = require("picker").current
                if picker == "telescope" then
                    require("telescope").setup({ extensions = { advanced_git_search = opts } })
                    require("telescope").load_extension("advanced_git_search")
                else
                    require("advanced_git_search." .. (picker == "fzf" and "fzf" or "snacks")).setup(opts)
                end
            end,
        },
        {
            "lewis6991/gitsigns.nvim",
            event = "VeryLazy",
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
                    -- yadm = {
                    --     enable = false
                    -- },
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
                                        gs.nav_hunk("next")
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
                                        gs.nav_hunk("prev")
                                    end
                                )
                                return "<Ignore>"
                            end,
                            { expr = true }
                        )

                        -- Actions
                        map("n", "<leader>hs", gs.stage_hunk)
                        map("n", "<leader>hr", gs.reset_hunk)

                        map('n', '<leader>hq', function() gs.setqflist('all') end)
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
                        map("n", "<leader>hi", gs.preview_hunk_inline)
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

                        -- Text object
                        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                    end
                }
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
            'Wansmer/treesj',
            keys = { '<space>k', '<space>j', },
            dependencies = { 'nvim-treesitter/nvim-treesitter' },
            config = function()
                require('treesj').setup({
                    use_default_keymaps = false,
                })

                vim.keymap.set('n', '<leader>j', require('treesj').toggle)
                vim.keymap.set('n', '<leader>k', require('treesj').toggle)
            end,
        },
        {
            "kevinhwang91/nvim-hlslens",
            event = "VeryLazy",
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
            "nvim-treesitter/nvim-treesitter",
            branch = "main",
            lazy = false, -- the main branch does not support lazy-loading
            build = ":TSUpdate",
            config = function()
                local ts = require("nvim-treesitter")
                ts.install({
                    "bash", "css", "diff", "dockerfile", "git_config", "git_rebase", "gitcommit",
                    "gitignore", "go", "gomod", "gosum", "gowork", "graphql", "hcl", "html", "javascript",
                    "jsdoc", "json", "lua", "luadoc", "make", "markdown", "markdown_inline",
                    "php", "phpdoc", "python", "query", "regex", "scss", "sql", "terraform", "toml",
                    "tsx", "typescript", "vim", "vimdoc", "xml", "yaml",
                })
                vim.api.nvim_create_autocmd("FileType", {
                    callback = function(ev)
                        local lang = vim.treesitter.language.get_lang(ev.match)
                        if not lang then
                            return
                        end
                        if not pcall(vim.treesitter.start, ev.buf, lang) then
                            -- parser missing: install it, highlighting starts on the next open
                            if vim.tbl_contains(ts.get_available(), lang) then
                                ts.install(lang)
                            end
                            return
                        end
                        if vim.treesitter.query.get(lang, "indents") then
                            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        end
                    end,
                })
            end
        },
        {
            "nvim-treesitter/nvim-treesitter-context",
            opts = {
                max_lines = 0, -- no limit
                mode = "topline",
            },
        },
        {
            "johmsalas/text-case.nvim",
            keys = {
                "ga", -- Default invocation prefix
                { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
            },
            cmd = {
                -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
                "Subs",
                "TextCaseOpenTelescope",
                "TextCaseOpenTelescopeQuickChange",
                "TextCaseOpenTelescopeLSPChange",
                "TextCaseStartReplacingCommand",
            },
            config = function()
                require('textcase').setup {}
                vim.cmd([[
                    nnoremap ga_ :lua require('textcase').current_word('to_snake_case')<CR>
                    nnoremap ga- :lua require('textcase').current_word('to_dash_case')<CR>
        ]])
            end
        }, -- nvim abolish alternative
        -- { "adoy/vim-php-refactoring-toolbox", ft = "php" },
        { "phux/php-doc-modded",    ft = "php" },
        {
            "olexsmir/gopher.nvim",
            ft = "go",
            dependencies = { "nvim-treesitter/nvim-treesitter" },
            opts = {
                gotag = { transform = "camelcase", option = "json=omitempty" },
            },
        },
        {
            "akinsho/bufferline.nvim",
            event = "VeryLazy",
            dependencies = "nvim-tree/nvim-web-devicons",
            config = function()
                require "bufferline".setup()
            end
        },
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            opts = {},
        },
        {
            'Kicamon/markdown-table-mode.nvim',
            ft = "markdown",
            config = function()
                require('markdown-table-mode').setup()
            end
        },
        {
            "hedyhli/markdown-toc.nvim",
            ft = "markdown",  -- Lazy load on markdown filetype
            cmd = { "Mtoc" }, -- Or, lazy load on "Mtoc" command
            opts = {
                -- Your configuration here (optional)
            },
        },

        {
            "hiphish/rainbow-delimiters.nvim",
            event = "VeryLazy",
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
        -- { "hashivim/vim-terraform", ft = "tf" },
        {
            "folke/flash.nvim",
            keys = {
                {
                    "<leader>f",
                    function()
                        -- label every word start, like easymotion-bd-w
                        require("flash").jump({
                            search = { mode = "search", max_length = 0 },
                            label = { after = { 0, 0 } },
                            pattern = [[\<]],
                        })
                    end,
                    mode = { "n", "x", "o" },
                    desc = "Jump to word",
                },
            },
        },

        {
            'ojroques/nvim-hardline',
            config = function()
                require('hardline').setup {
                    bufferline = false,           -- disable bufferline
                    bufferline_settings = {
                        exclude_terminal = false, -- don't show terminal buffers in bufferline
                        show_index = false,       -- show buffer indexes (not the actual buffer numbers) in bufferline
                    },
                    -- theme = 'default',            -- change theme
                    theme = 'gruvbox', -- change theme
                    sections = {       -- define sections
                        { class = 'mode', item = require('hardline.parts.mode').get_item },
                        { class = 'high', item = require('hardline.parts.git').get_item,     hide = 100 },
                        { class = 'med',  item = require('hardline.parts.filename').get_item },
                        '%<',
                        { class = 'med',     item = '%=' },
                        { class = 'low',     item = require('hardline.parts.wordcount').get_item, hide = 100 },
                        { class = 'error',   item = require('hardline.parts.lsp').get_error },
                        { class = 'warning', item = require('hardline.parts.lsp').get_warning },
                        { class = 'warning', item = require('hardline.parts.whitespace').get_item },
                        { class = 'high',    item = require('hardline.parts.filetype').get_item,  hide = 60 },
                        { class = 'mode',    item = require('hardline.parts.line').get_item },
                    },
                }
            end

        },

        {
            'iamcco/markdown-preview.nvim',
            ft = "markdown",
            -- event = "VeryLazy",
            init = function()
                vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/mkdp.css"
            end,
            build = 'cd app && npx --yes yarn install',
        },


        {
            "Zeioth/markmap.nvim",
            cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
            opts = {
                html_output = "/home/jm/tmp/markmap.html", -- (default) Setting a empty string "" here means: [Current buffer path].html
                hide_toolbar = false,                      -- (default)
                grace_period = 3600000                     -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
            },
            config = function(_, opts) require("markmap").setup(opts) end
        },
        -- {
        --     "lukas-reineke/headlines.nvim",
        --     dependencies = { "nvim-treesitter/nvim-treesitter", lazy = true },
        --     config = true, -- or `opts = {}`
        -- },
        -- {
        --     "dhruvasagar/vim-table-mode",
        --     event = "VeryLazy",
        -- },
        {
            "nacro90/numb.nvim",
            keys = { ":" },
            config = function()
                require('numb').setup()
            end
        }, -- peek lines
        {
            "christoomey/vim-tmux-navigator",
            event = "VeryLazy",
        },
        { 'williamboman/mason.nvim' },
        {
            "mfussenegger/nvim-lint",
            event = "VeryLazy",
            config = function()
                require('lint').linters_by_ft = {
                    -- markdown = { 'proselint' },
                    markdown = { 'markdownlint-cli2' },
                    python = { 'ruff' },
                    text = { 'proselint' },
                    yaml = { 'yamllint' },
                    -- php = { 'php' },
                    php = { 'php', 'phpstan' },
                    -- lua = { 'luacheck' },
                    html = { 'tidy' },
                    typescript = { 'eslint_d' },
                }
                -- markdownlint-cli2 only reads configs from the working directory. --config adds a base that project configs override.
                require('lint').linters['markdownlint-cli2'].args = { '--config', vim.fn.expand(
                '~/.markdownlint-cli2.yaml'), '-' }
                vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                    callback = function()
                        -- try_lint without arguments runs the linters defined in `linters_by_ft`
                        -- for the current filetype
                        require("lint").try_lint()
                    end,
                })
            end
        },
        { "williamboman/mason-lspconfig.nvim" },
        {
            "neovim/nvim-lspconfig",
            -- event = "VeryLazy",
        },
        {
            "b0o/schemastore.nvim",
            lazy = true,
        },
        {
            "aznhe21/actions-preview.nvim",
            keys = {
                { "<leader>ca", function() require("actions-preview").code_actions() end, mode = { "v", "n" } },
                { "<leader>ll", function() require("actions-preview").code_actions() end, mode = { "v", "n" } },
            },
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
            "saghen/blink.cmp",
            version = "1.*", -- release tags ship a prebuilt fuzzy matcher
            event = "InsertEnter",
            dependencies = { "L3MON4D3/LuaSnip" },
            opts = function()
                local function has_words_before()
                    local col = vim.api.nvim_win_get_cursor(0)[2]
                    return col ~= 0 and vim.api.nvim_get_current_line():sub(col, col):match("%s") == nil
                end

                return {
                    keymap = {
                        preset = "none",
                        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
                        ["<C-e>"] = { "hide", "fallback" },
                        ["<CR>"] = { "accept", "fallback" },
                        ["<C-y>"] = { "select_and_accept" },
                        ["<C-n>"] = { "select_next", "fallback" },
                        ["<C-p>"] = { "select_prev", "fallback" },
                        ["<Down>"] = { "select_next", "fallback" },
                        ["<Up>"] = { "select_prev", "fallback" },
                        ["<Tab>"] = {
                            "select_next",
                            "snippet_forward",
                            function(cmp) if has_words_before() then return cmp.show() end end,
                            "fallback",
                        },
                        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
                        ["<C-j>"] = { "snippet_forward", "fallback" },
                        ["<C-k>"] = { "snippet_backward", "fallback" },
                        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
                    },
                    completion = {
                        list = { selection = { preselect = false } }, -- <CR> only accepts an item you picked
                        documentation = { auto_show = true },
                    },
                    cmdline = { enabled = false },
                    snippets = { preset = "luasnip" },
                    sources = {
                        default = { "lsp", "snippets", "buffer", "path" },
                        providers = {
                            snippets = { min_keyword_length = 2 },
                            buffer = { min_keyword_length = 2 },
                        },
                    },
                    signature = { enabled = true },
                }
            end,
        }, -- completion plugin
        {
            "gbprod/yanky.nvim",
            dependencies = {
                { "kkharji/sqlite.lua" },
                { "folke/snacks.nvim" }
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
                { "<leader>P", function() require("picker").run("yanky") end, desc = "Open Yank History" },
                { "y",         "<Plug>(YankyYank)",                           mode = { "n", "x" },                           desc = "Yank text" },
                { "p",         "<Plug>(YankyPutAfter)",                       mode = { "n", "x" },                           desc = "Put yanked text after cursor" },
                { "P",         "<Plug>(YankyPutBefore)",                      mode = { "n", "x" },                           desc = "Put yanked text before cursor" },
                { "]p",        "<Plug>(YankyPutIndentAfterLinewise)",         desc = "Put indented after cursor (linewise)" },
                { "[p",        "<Plug>(YankyPutIndentBeforeLinewise)",        desc = "Put indented before cursor (linewise)" },
                -- { "]P",        "<Plug>(YankyPutIndentAfterLinewise)",                                        desc = "Put indented after cursor (linewise)" },
                -- { "[P",        "<Plug>(YankyPutIndentBeforeLinewise)",                                       desc = "Put indented before cursor (linewise)" },
                { ">p",        "<Plug>(YankyPutIndentAfterShiftRight)",       desc = "Put and indent right" },
                { "<p",        "<Plug>(YankyPutIndentAfterShiftLeft)",        desc = "Put and indent left" },
                -- { ">P",        "<Plug>(YankyPutIndentBeforeShiftRight)",                                     desc = "Put before and indent right" },
                -- { "<P",        "<Plug>(YankyPutIndentBeforeShiftLeft)",                                      desc = "Put before and indent left" },
                -- { "=p",        "<Plug>(YankyPutAfterFilter)",                                                desc = "Put after applying a filter" },
                -- { "=P",        "<Plug>(YankyPutBeforeFilter)",                                               desc = "Put before applying a filter" },
            },
        },
        {
            "L3MON4D3/LuaSnip",
            event = "VeryLazy",
            dependencies = {
                "rafamadriz/friendly-snippets",
            },
            build = "make install_jsregexp",
            config = function()
                vim.api.nvim_create_user_command(
                    'ES',
                    function(opts)
                        require("luasnip.loaders").edit_snippet_files()
                    end,
                    {}
                )
                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip.loaders.from_vscode").load({ paths = { "~/.config/nvim/luasnippets" } })
            end
        },

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
            event = "VeryLazy",
            opts = {
                -- options
            },
        },
        {
            'stevearc/conform.nvim',
            event = "BufWritePre",
            cmd = "ConformInfo",
            config = function()
                require("conform").setup({
                    formatters_by_ft = {
                        ansible = { lsp_format = "first", "ansible-lint" },
                        lua = { lsp_format = "first" },
                        python = { lsp_format = "first", "ruff_organize_imports", "ruff_format" },
                        javascript = { lsp_format = "first", "prettierd", },
                        typescript = { lsp_format = "first", "prettierd", },
                        -- typescriptreact = { lsp_format = "first", "prettierd" },
                        -- yaml = { lsp_format = "first", "yamlfix", "yamlfmt" },
                        terraform = { lsp_format = "first", "terraform_fmt" },
                        markdown = { lsp_format = "first", "prettierd" },
                        json = { "prettierd" },
                        php = { "php_cs_fixer", lsp_format = "last" },
                        sh = { lsp_format = "first", "shfmt" },
                        -- sql = { "sqlfmt", "sql_formatter" },
                        sql = { "sqruff" },
                    },
                    log_level = vim.log.levels.ERROR,
                    notify_on_error = true,
                    notify_no_formatters = true,
                    default_format_opts = {
                        lsp_format = "fallback",
                    },
                    format_on_save = {
                        -- These options will be passed to conform.format()
                        -- timeout_ms = 500,
                        lsp_format = "fallback",
                    },
                })
                -- Without a project config php-cs-fixer asks to create one. Neovim answers yes, so the first save
                -- writes .php-cs-fixer.dist.php and .gitignore into the project and formats nothing.
                require("conform").formatters.php_cs_fixer = {
                    append_args = { "--no-interaction", "--using-cache=no" },
                }
            end
        },
        {
            "dnlhc/glance.nvim",
            event = "VeryLazy",
            config = function()
                require('glance').setup({
                    height = 18, -- Height of the window
                    zindex = 45,
                    detached = function(winid)
                        -- Automatically detach when parent window width < 100 columns
                        return vim.api.nvim_win_get_width(winid) < 100
                    end,
                    list = {
                        position = 'left', -- Position of the list window 'left'|'right'
                        width = 0.5
                    },
                    border = {
                        enable = true, -- Show window borders. Only horizontal borders allowed
                        top_char = '―',
                        bottom_char = '―',
                    },
                    hooks = {
                        before_open = function(results, open, jump, method)
                            if #results == 1 then
                                jump(results[1]) -- argument is optional
                            else
                                open(results)    -- argument is optional
                            end
                        end,
                    }
                })
                -- <leader>nd/nr/nD/ni open the same lookups in the picker (lua/picker.lua)
                vim.keymap.set('n', 'gd', '<CMD>Glance definitions<CR>')
                vim.keymap.set('n', 'gr', '<CMD>Glance references<CR>')
                vim.keymap.set('n', 'gD', '<CMD>Glance type_definitions<CR>')
                vim.keymap.set('n', 'gi', '<CMD>Glance implementations<CR>')
            end,
        },
        {
            "folke/trouble.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            cmd = "Trouble",
            keys = {
                {
                    "<leader>dd",
                    "<cmd>Trouble diagnostics toggle<cr>",
                    desc = "Diagnostics (Trouble)",
                },
                {
                    "<leader>cl",
                    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                    desc = "LSP Definitions / references / ... (Trouble)",
                },
            },
            opts = {},
        },
        {
            "folke/todo-comments.nvim",
            event = "VeryLazy",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        },
        {
            "wellle/targets.vim",
            event = "VeryLazy",
        },
        {
            "rgroli/other.nvim",
            ft = "go",
            config = function()
                require("other-nvim").setup({
                    mappings = { "golang" },
                })

                vim.api.nvim_set_keymap("n", "<leader>na", "<cmd>:Other<CR>", { noremap = true, silent = true })
            end
        },
        {
            "maxandron/goplements.nvim",
            ft = "go",
            opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            },
        },

        {
            "folke/snacks.nvim",
            priority = 1000,
            lazy = false, -- bigfile, quickfile and replace_netrw only work when snacks loads at startup
            keys = {
                { "<leader>ot", function() Snacks.explorer() end,           desc = "Explorer" },
                { "<leader>rf", function() Snacks.rename.rename_file() end, desc = "Rename file" },
            },
            opts = {
                bigfile = { enabled = true },
                quickfile = { enabled = true },
                input = { enabled = true },
                words = { enabled = true },
                explorer = { replace_netrw = true },
                picker = {
                    enabled = true,
                    layout = { preset = "ivy_split" },
                    formatters = { file = { filename_first = true } },
                    -- one <Esc> closes the picker (same as the old telescope mapping) instead of leaving insert mode
                    win = { input = { keys = { ["<Esc>"] = { "close", mode = { "n", "i" } } } } },
                    previewers = { file = { max_size = 100000 } },
                    sources = {
                        -- vendor, node_modules, dist, var and .git are excluded for all tools in ~/.ignore
                        files = { hidden = true },
                        grep = { hidden = true, exclude = { "mocks" } },
                    },
                },
            },
        },
        {
            "nvim-telescope/telescope.nvim",
            branch = "master",
            lazy = true,
            dependencies = {
                "nvim-lua/plenary.nvim",
                { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
                "debugloop/telescope-undo.nvim",
            },
            config = function()
                local telescope = require("telescope")
                telescope.setup({
                    defaults = {
                        layout_strategy = "vertical",
                        layout_config = { height = 0.95, width = 0.95 },
                        dynamic_preview_title = true,
                        color_devicons = false,
                        preview = { filesize_limit = 0.1 }, -- MB
                        vimgrep_arguments = {
                            "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column",
                            "--smart-case", "--glob=!mocks/",
                        },
                        mappings = { i = { ["<esc>"] = require("telescope.actions").close } },
                    },
                    extensions = {
                        undo = {
                            side_by_side = true,
                            layout_strategy = "vertical",
                            layout_config = { preview_height = 0.8 },
                            mappings = {
                                i = {
                                    ["<cr>"] = function(...) return require("telescope-undo.actions").yank_additions(...) end,
                                    ["<c-y>"] = function(...) return require("telescope-undo.actions").yank_deletions(...) end,
                                    ["<c-r>"] = function(...) return require("telescope-undo.actions").restore(...) end,
                                },
                                n = {
                                    ["y"] = function(...) return require("telescope-undo.actions").yank_additions(...) end,
                                    ["Y"] = function(...) return require("telescope-undo.actions").yank_deletions(...) end,
                                    ["r"] = function(...) return require("telescope-undo.actions").restore(...) end,
                                },
                            },
                        },
                    },
                })
                telescope.load_extension("fzf")
                telescope.load_extension("undo")
            end,
        },
        {
            "ibhagwan/fzf-lua",
            lazy = true,
            dependencies = { "nvim-tree/nvim-web-devicons" },
            opts = {
                grep = {
                    rg_opts =
                    "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --glob=!mocks/ -e",
                },
            },
        },
        -- {
        -- 'ray-x/guihua.lua', build = 'cd lua/fzy && make'
        -- },
        {
            "andythigpen/nvim-coverage",
            ft = { "go", "php" },
            dependencies = "nvim-lua/plenary.nvim",
            config = function()
                require("coverage").setup()
            end,
        },
        {
            "MattesGroeger/vim-bookmarks",
            config = function()
                vim.cmd([[
                    let g:bookmark_auto_save = 1
                    let g:bookmark_save_per_working_dir = 1
                    let g:bookmark_show_warning = 1
                    let g:bookmark_no_default_key_mappings = 1
                ]])
                vim.keymap.set("n", "mm", "<cmd>BookmarkToggle<CR>")
                vim.keymap.set("n", "ma", "<cmd>BookmarkShowAll<CR>")
            end
        },
        {
            "lowitea/aw-watcher.nvim",
            opts = { -- required, but can be empty table: {}
                -- add any options here
                -- for example:
                aw_server = {
                    host = "127.0.0.1",
                    port = 5600,
                },
            },
        },
        {
            "obsidian-nvim/obsidian.nvim",
            version = "*", -- recommended, use latest release instead of latest commit
            cmd = "Obsidian",
            event = {
                "BufReadPre " .. vim.fn.expand("~/Dropbox/Apps/remotely-save/ObsidianVault") .. "/*.md",
                "BufNewFile " .. vim.fn.expand("~/Dropbox/Apps/remotely-save/ObsidianVault") .. "/*.md",
            },
            -- lazy = true,
            -- ft = "markdown",
            -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
            -- event = {
            --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
            --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
            --   -- refer to `:h file-pattern` for more examples
            --   "BufReadPre path/to/my-vault/*.md",
            --   "BufNewFile path/to/my-vault/*.md",
            -- },
            ---@module 'obsidian'
            ---@type obsidian.config

            opts = {
                legacy_commands = false,
                picker = { name = require("picker").obsidian },
                workspaces = {
                    -- {
                    --     name = "personal",
                    --     path = "~/vaults/personal",
                    -- },
                    {
                        name = "work",
                        path = "~/Dropbox/Apps/remotely-save/ObsidianVault",
                    },
                },

            },
        },
        {
            "OXY2DEV/markview.nvim",
            lazy = false, -- readme: lazy-loading slows the preview; loads after the colorscheme (priority 1000)
            -- no hybrid_modes: it re-parses and re-renders the whole buffer on every j/k (~45ms on a 225-line file)
            config = function()
                local tables = require("markview.config.markdown")
                .tables                                                   -- the wiki's spec.default.markdown no longer exists
                local no_border = require("markview.presets").tables.none
                -- the default heading icons and signs are U+F0000+ glyphs, which urxvt draws as boxes
                local headings = { enable = true }
                for level = 1, 6 do
                    headings["heading_" .. level] = { style = "simple", hl = "MarkviewHeading" .. level }
                end
                require("markview").setup({
                    markdown = {
                        headings = headings,
                        tables = function(buffer)
                            if buffer and vim.b[buffer].noborder == true then
                                return vim.tbl_deep_extend("force", tables, no_border)
                            end
                            return tables
                        end,
                    },
                })
                vim.keymap.set("n", "<leader>mb", function()
                    vim.b.noborder = not vim.b.noborder
                    require("markview").commands.Render()
                end, { desc = "markview: toggle table borders" })
                -- for a manual :Markview splitToggle: the split inherits spell and conceallevel from the source window
                vim.api.nvim_create_autocmd("User", {
                    pattern = "MarkviewSplitviewOpen",
                    callback = function(ev)
                        vim.schedule(function()
                            local win = ev.data.preview_window
                            if not vim.api.nvim_win_is_valid(win) then return end
                            vim.wo[win].spell = false
                            vim.wo[win].conceallevel = 3
                            vim.wo[win].concealcursor = "nvic"
                        end)
                    end,
                })
            end,
        },
        -- {
        --     'MeanderingProgrammer/render-markdown.nvim',
        --     dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        --     -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        --     -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        --     ---@module 'render-markdown'
        --     ---@type render.md.UserConfig
        --     opts = {},
        -- },
    }
)

require("picker").setup()

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = true })
        end

        bufmap('n', '<leader>rr', vim.lsp.buf.rename)
        bufmap('n', '<leader>F', vim.lsp.buf.format)
        bufmap('n', 'gl', vim.diagnostic.open_float)
        bufmap('n', '<c-p>', function() vim.diagnostic.jump({ count = -1, float = true }) end)
        bufmap('n', '<c-n>', function() vim.diagnostic.jump({ count = 1, float = true }) end)
    end
})

-- glance owns `gr`; without this `gr` waits for 'timeoutlen' because of the built-in `gr?` maps
for _, lhs in ipairs({ "grn", "grr", "gri", "grt", "grx" }) do
    pcall(vim.keymap.del, "n", lhs)
end
pcall(vim.keymap.del, { "n", "x" }, "gra")

-- Neovim 0.11 turned virtual text off by default
vim.diagnostic.config({ virtual_text = true, severity_sort = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        local params = vim.lsp.util.make_range_params(0, "utf-16")
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
    end
})

vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.config('gopls', {
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

-- vim.lsp.config('intelephense', {
--     settings = {
--         intelephense = {
--             files = {
--                 exclude = {
--                     "**/var/cache/**"
--                 }
--             },
--         },
--     },
-- })

vim.lsp.config('jsonls', {
    before_init = function(_, config)
        config.settings.json.schemas = require('schemastore').json.schemas()
    end,
    settings = {
        json = {
            validate = { enable = true },
        },
    },
})

vim.lsp.config('yamlls', {
    settings = {
        yaml = {
            schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
            },
        },
    },
    before_init = function(_, config)
        config.settings.yaml.schemas = require('schemastore').yaml.schemas()
    end,
})

require('mason').setup({})
require('mason-lspconfig').setup({
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
        -- 'tsserver',
        'marksman', -- markdown
        -- 'spectral', -- openapi
        -- 'phpactor',
        'intelephense',
        -- 'php_ls',
        'pyright',
        -- 'ruby_ls',
        'sqlls',
        'taplo', -- toml
        -- 'terraformls',
        'vimls',
        'lemminx',
        'yamlls',
        -- 'hadolint',
        -- 'tfsec',
    },
})


-- move quotes & brackets around
vim.api.nvim_set_keymap("i", "<m-e>", "<esc>lxepi", { noremap = true })
vim.api.nvim_set_keymap("n", "<m-e>", "xep", { noremap = true })
