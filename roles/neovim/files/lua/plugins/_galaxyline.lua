local gl = require("galaxyline")
local U = require("utils")
local gls = gl.section
gl.short_line_list = {"LuaTree", "vista", "dbui"}

local colors = {
    bg = "#282828",
    line_bg = "#32302f",
    fg = "#a89984",
    fg_green = "#65a380",
    fg_blueish = "#83a598",
    yellow = "#fabd2f",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#83a598",
    orange = "#FF8800",
    purple = "#5d4d7a",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
    bright = "#ebdbb2",
    bright_bg = "#fbf1c7"
}

if U.load_bright_theme() then
    colors.fg = colors.bg
    colors.bg = colors.bright_bg
    colors.line_bg = colors.bright
end

local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
        return true
    end
    return false
end

gls.left[1] = {
    FirstElement = {
        provider = function()
            -- return "▊ "
            return " "
        end,
        highlight = {colors.blue, colors.line_bg}
    }
}
-- gls.left[1] = {
--     ViMode = {
--         provider = function()
--             -- auto change color according the vim mode
--             local mode_color = {
--                 n = colors.magenta,
--                 i = colors.green,
--                 v = colors.blue,
--                 [""] = colors.blue,
--                 V = colors.blue,
--                 c = colors.red,
--                 no = colors.magenta,
--                 s = colors.orange,
--                 S = colors.orange,
--                 [""] = colors.orange,
--                 ic = colors.yellow,
--                 R = colors.purple,
--                 Rv = colors.purple,
--                 cv = colors.red,
--                 ce = colors.red,
--                 r = colors.cyan,
--                 rm = colors.cyan,
--                 ["r?"] = colors.cyan,
--                 ["!"] = colors.red,
--                 t = colors.red
--             }
--             vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
--             return "  "
--         end,
--         highlight = {colors.red, colors.line_bg, "bold"}
--     }
-- }
gls.left[2] = {
    GitIcon = {
        provider = function()
            return "  "
        end,
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.orange, colors.line_bg}
    }
}
gls.left[3] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.fg_blueish, colors.line_bg}
    }
}

gls.left[4] = {
    Space = {
        provider = function()
            return " "
        end
    }
}
gls.left[5] = {
    FileIcon = {
        provider = "FileIcon",
        condition = buffer_not_empty,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.line_bg}
    }
}
gls.left[6] = {
    FileName = {
        provider = function()
            return vim.fn.expand("%:f")
        end,
        -- provider = {"FileName", "FileSize"},
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.line_bg, "bold"}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

gls.left[7] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.green, colors.line_bg}
    }
}
gls.left[8] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.orange, colors.line_bg}
    }
}
gls.left[9] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.red, colors.line_bg}
    }
}
gls.left[10] = {
    LeftEnd = {
        provider = function()
            return ""
        end,
        separator = "",
        separator_highlight = {colors.bg, colors.line_bg},
        highlight = {colors.line_bg, colors.line_bg}
    }
}
gls.left[11] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}
gls.left[12] = {
    Space = {
        provider = function()
            return " "
        end
    }
}
gls.left[13] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.blue, colors.bg}
    }
}
gls.right[1] = {
    FileFormat = {
        provider = "FileFormat",
        separator = " ",
        separator_highlight = {colors.bg, colors.line_bg},
        highlight = {colors.fg, colors.line_bg}
    }
}
gls.right[2] = {
    LineInfo = {
        provider = "LineColumn",
        separator = " | ",
        separator_highlight = {colors.fg_green, colors.line_bg},
        highlight = {colors.fg, colors.line_bg}
    }
}
gls.right[3] = {
    PerCent = {
        provider = "LinePercent",
        separator = " ",
        separator_highlight = {colors.line_bg, colors.line_bg},
        highlight = {colors.fg, colors.line_bg}
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = "FileTypeName",
        separator = " ",
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.fg, colors.bg},
        condition = buffer_not_empty
    }
}

gls.short_line_left[2] = {
    File = {
        provider = function()
            return vim.fn.expand("%:f")
        end,
        -- provider = {"FileName", "FileSize"},
        condition = buffer_not_empty
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = "BufferIcon",
        separator = "",
        separator_highlight = {colors.purple, colors.bg},
        highlight = {colors.fg, colors.purple}
    }
}
