local CodeGPTModule = require("codegpt")
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
        lualine_b = {"branch", "b:gitsigns_status"},
        lualine_c = {
            {
                "diagnostics",
                -- table of diagnostic sources, available sources:
                -- 'nvim_lsp', 'nvim', 'coc', 'ale', 'vim_lsp'
                -- Or a function that returns a table like
                --   {error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt}
                sources = {"nvim_diagnostic", "coc", "ale"},
                -- displays diagnostics from defined severity
                sections = {"error", "warn", "info", "hint"},
                diagnostics_color = {
                    -- Same values like general color option can be used here.
                    error = "DiagnosticError", -- changes diagnostic's error color
                    warn = "DiagnosticWarn", -- changes diagnostic's warn color
                    info = "DiagnosticInfo", -- Changes diagnostic's info color
                    hint = "DiagnosticHint" -- Changes diagnostic's hint color
                },
                symbols = {error = "E", warn = "W", info = "I", hint = "H"},
                colored = true, -- displays diagnostics status in color if set to true
                update_in_insert = false, -- Update diagnostics in insert mode
                always_visible = false -- Show diagnostics even if count is 0, boolean or function returning boolean
            },
            {"filename", full_name = true, path = 1}
        },
        lualine_x = {"encoding", "fileformat", "filetype"},
        lualine_y = {"progress"},
        lualine_z = {"location"}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {{"filename", full_name = true, path = 1}},
        lualine_x = {CodeGPTModule.get_status, "encoding", "fileformat"},
        lualine_y = {},
        lualine_z = {}
    },
    extensions = {"fzf"}
}

-- lualine.theme = "gruvbox"
-- lualine.extensions = {"fzf"}
-- lualine.options.diagnostics = {sources = {"nvim_lsp"}}
