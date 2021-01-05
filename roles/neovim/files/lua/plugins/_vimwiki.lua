local U = require "utils"

vim.g.vimwiki_list = {
    {
        path = "~/Dropbox/1vimwiki/",
        syntax = "markdown",
        ext = ".md",
        auto_tags = 0,
        path_html = "/tmp/vimwiki/site_html/",
        custom_wiki2html = "vimwiki_markdown"
    }
}

-- vim.g.vimwiki_conceallevel = 0
vim.g.vimwiki_key_mappings = {
    all_maps = 0
}

U.map("n", "<leader>zi", "<Plug>VimwikiIndex", {noremap = false})
-- U.map("n", "<leader>zt", "<Plug>VimwikiTabIndex", {noremap = false})
-- U.map("n", "<leader>zs", "<Plug>VimwikiUISelect", {noremap = false})
-- U.map("n", "<leader>zd", "<Plug>VimwikiDiaryIndex", {noremap = false})

-- just for overriding
U.map("n", "<leader>zr", "<Plug>VimwikiRenameFile", {noremap = false})
U.map("n", "<leader>zd", "<Plug>VimwikiDeleteFile", {noremap = false})
U.map("n", "<leader>zg", "<Plug>VimwikiGoto", {noremap = false})
-- U.map("n", "<leader>zh", "<Plug>Vimwiki2HTML", {noremap = false})
U.map("n", "<leader>zh", ":VimwikiAll2HTML<cr>:!chromium-browser /tmp/vimwiki/site_html/", {noremap = false})
U.map("n", "<leader>zhh", "<Plug>Vimwiki2HTMLBrowser", {noremap = false})

local autocmds = {
    conf = {
        {
            "FileType",
            "vimwiki",
            'let b:AutoPairs = {\'```\': \'```\', \'`\': \'`\', \'"\': \'"\', \'\'\'\': \'\'\'\', \'(\': \')\', \'\'\'\'\'\'\'\': \'\'\'\'\'\'\'\', \'{\': \'}\', \'"""\': \'"""\'}'
        }
    }
}
U.augroups(autocmds)
