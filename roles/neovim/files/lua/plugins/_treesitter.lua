local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

-- TODO: requires :TSInstall norg
parser_configs.norg = {
    install_info = {
        url = "https://github.com/vhyrro/tree-sitter-norg",
        files = {"src/parser.c"},
        branch = "main"
    }
}
require("nvim-treesitter.configs").setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true, -- false will disable the whole extension
        -- disable = {"php"}, -- list of language that will be disabled
        use_languagetree = false
    }
    -- incremental_selection = { -- doesn't work yet
    --     enable = true,
    --     keymaps = {
    --         init_selection = "gnn",
    --         node_incremental = "grn",
    --         scope_incremental = "grc",
    --         node_decremental = "grm"
    --     }
    -- },
    -- indent = {
    --     enable = true
    -- }
}
-- vim.o.foldmethod = "expr"
-- vim.cmd("set foldmethod=expr")
-- vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
