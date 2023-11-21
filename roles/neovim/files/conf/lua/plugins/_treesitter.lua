
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
    enable = true, -- Enable this plugin (Can be enabled/disabled later via TSContextToggle)
    throttle = true, -- Throttles plugin updates (may improve performance)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    mode = "topline" -- Line used to calculate context. Choices: 'cursor', 'topline'
}
