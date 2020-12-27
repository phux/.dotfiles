local U = require "utils"
-- don't show the help in normal mode
-- let g:Lf_HideHelp = 1
vim.g.Lf_UseCache = 1
vim.g.Lf_UseVersionControlTool = 1
vim.g.Lf_IgnoreCurrentBufferName = 1
-- " popup mode
-- vim.g.Lf_WindowPosition = "popup"
vim.g.Lf_NeedCacheTime = 0.1
vim.g.Lf_UseMemoryCache = 1
vim.g.Lf_DefaultMode = "FullPath"
vim.g.Lf_CursorBlink = 0
vim.g.Lf_WindowHeight = 10
vim.g.Lf_FollowLinks = 1
-- not using it
vim.g.Lf_MruMaxFiles = 0
vim.cmd("let g:Lf_StlSeparator = { 'left': '', 'right': '' }")
vim.g.Lf_ReverseOrder = 1
vim.g.Lf_PreviewInPopup = 1
-- vim.g.Lf_PreviewCode = 1
-- vim.g.Lf_PreviewResult = {
--     File = 1,
--     Buffer = 0,
--     Mru = 0,
--     Tag = 1,
--     BufTag = 1,
--     Function = 1,
--     Line = 0,
--     Colorscheme = 0,
--     Rg = 1,
--     Gtags = 0
-- }

U.map("n", "<leader>of", ":Leaderf file<cr>", {noremap = true})
-- U.map("n", "<leader>ob", ":Leaderf buffer<cr>", {noremap = true})
vim.g.Lf_ShortcutB = "<leader>ob"
vim.g.Lf_GtagsAutoGenerate = 1
vim.g.Lf_Gtagslabel = "native-pygments"
vim.g.Lf_GtagsStoreInRootMarker = 1
U.map("n", "<leader>oo", ":Leaderf --recall<cr>", {noremap = true})
U.map("n", "<leader>su", ":Leaderf rg -LFi --hidden --cword<cr>", {noremap = true})
U.map("n", "<leader>st", ":Leaderf rg<cr>", {noremap = true})
U.map("n", "<leader>ot", ":Leaderf gtags<cr>", {noremap = true})
U.map("n", "<leader>vl", ":Leaderf file " .. os.getenv("HOME") .. "/.config/nvim/lua<cr>", {noremap = true})

-- U.map("v", "<leader>su", ':<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>', {noremap = true})
-- xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
vim.api.nvim_set_keymap("n", "<leader>or", "<cmd>lua findFromGitRoot()<cr>", {noremap = true})
function _G.findFromGitRoot()
    vim.cmd(":Leaderf file " .. U.GitRoot())
end
