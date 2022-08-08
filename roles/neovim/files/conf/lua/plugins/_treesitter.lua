-- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

require("orgmode").setup_ts_grammar()

require("nvim-treesitter.configs").setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {"org"}, -- list of language that will be disabled
        use_languagetree = false,
        additional_vim_regex_highlighting = {"org"} -- Required since TS highlighter doesn't support all syntax features (conceal)
    },
    -- incremental_selection = { -- doesn't work yet
    --     enable = true,
    --     keymaps = {
    --         init_selection = "gnn",
    --         node_incremental = "grn",
    --         scope_incremental = "grc",
    --         node_decremental = "grm"
    --     }
    -- },
    indent = {
        enable = true
    }
}
-- vim.o.foldmethod = "expr"
-- vim.cmd("set foldmethod=expr")
-- vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")

require "treesitter-context".setup {
    enable = true, -- Enable this plugin (Can be enabled/disabled later via TSContextToggle)
    throttle = true, -- Throttles plugin updates (may improve performance)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    -- patterns = {
    -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
    -- For all filetypes
    -- Note that setting an entry here replaces all other patterns for this entry.
    -- By setting the 'default' entry below, you can control which nodes you want to
    -- appear in the context window.
    -- default = {
    --     "class",
    --     "function",
    --     "method"
    -- 'for', -- These won't appear in the context
    -- 'while',
    -- 'if',
    -- 'switch',
    -- 'case',
    -- }
    -- Example for a specific filetype.
    -- If a pattern is missing, *open a PR* so everyone can benefit.
    --   rust = {
    --       'impl_item',
    --   },
    -- }
    mode = "topline" -- Line used to calculate context. Choices: 'cursor', 'topline'
}
