local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

-- -- TODO: requires :TSInstall norg
-- parser_configs.norg = {
--     install_info = {
--         url = "https://github.com/vhyrro/tree-sitter-norg",
--         files = {"src/parser.c"},
--         branch = "main"
--     }
-- }

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
    install_info = {
        url = "https://github.com/milisims/tree-sitter-org",
        revision = "main",
        files = {"src/parser.c", "src/scanner.cc"}
    },
    filetype = "org"
}
require "nvim-treesitter.configs".setup {
    -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
    highlight = {
        enable = true,
        disable = {"org"}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
        additional_vim_regex_highlighting = {"org"} -- Required since TS highlighter doesn't support all syntax features (conceal)
    },
    ensure_installed = {"org"} -- Or run :TSUpdate org
}

require("nvim-treesitter.configs").setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true, -- false will disable the whole extension
        -- disable = {"php"}, -- list of language that will be disabled
        use_languagetree = false,
        additional_vim_regex_highlighting = false
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
    enable = false, -- Enable this plugin (Can be enabled/disabled later via TSContextToggle)
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
}
