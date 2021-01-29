local lualine = require("lualine")
lualine.theme = "gruvbox"
lualine.extensions = {"fzf"}

local function rel_filename()
    -- return vim.fn.substitute(vim.fn.expand("%"), vim.fn.getcwd(), "", "")
    return vim.fn.expand("%:f")
end
lualine.sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch"},
    lualine_c = {rel_filename},
    lualine_x = {"encoding", "fileformat", "filetype"},
    lualine_y = {"progress"},
    lualine_z = {"location"},
    lualine_diagnostics = {}
}

lualine.inactiveSections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {rel_filename},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
}

lualine.status()
