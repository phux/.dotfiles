local packer = require("packer")
local use = packer.use
local U = require "utils"

require("packer").startup(
    function()
        -- Packer can manage itself as an optional plugin
        -- use { 'wbthomason/packer.nvim', opt = true }
        use {"wbthomason/packer.nvim"}

        -- " For navigating b/w tmux window, specially for navigating with NERDTree

        -- " FocusGained and FocusLost autocommand events are not working in terminal
        -- vim. This plugin restores them when using vim inside Tmux.

        -- use {"rafcamlet/coc-nvim-lua", ft = "lua"}

        use {"junegunn/fzf", run = "./install --all"}
        use {"junegunn/fzf.vim"}
        use "junegunn/vim-peekaboo"
        -- use "sinetoami/fzy.nvim"
        -- use {"lotabout/skim", run = "./install"}
        -- use "lotabout/skim.vim"


        -- " For various text objects

        -- use "folke/trouble.nvim"
        -- use {"nvim-telescope/telescope-fzf-native.nvim", run = "make clean && make"}

        use {
            "ThePrimeagen/refactoring.nvim",
            requires = {
                {"nvim-lua/plenary.nvim"},
                {"nvim-treesitter/nvim-treesitter"},
                {"nvim-lua/telescope.nvim"}
            },
            config = function()
                require("refactoring").setup(
                    {
                        -- prompt for return type
                        prompt_func_return_type = {},
                        -- prompt for function parameters
                        prompt_func_param_type = {}
                    }
                )
                vim.api.nvim_set_keymap(
                    "v",
                    "<leader>rem",
                    [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
                    {noremap = true, silent = true, expr = false}
                )

                vim.api.nvim_set_keymap(
                    "v",
                    "<leader>rev",
                    [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
                    {noremap = true, silent = true, expr = false}
                )
                vim.api.nvim_set_keymap(
                    "n",
                    "<leader>reb",
                    [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
                    {noremap = true, silent = true, expr = false}
                )
                vim.api.nvim_set_keymap(
                    "n",
                    "<leader>rebf",
                    [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
                    {noremap = true, silent = true, expr = false}
                )
            end
        }

        -- " For showing the actual color of the hex value
        use {
            "norcalli/nvim-colorizer.lua",
            config = function()
                require "colorizer".setup()
            end
        }
        -- use {
        --     "blackCauldron7/surround.nvim",
        --     config = function()
        --         require "surround".setup {mappings_style = "surround"}
        --     end
        -- }
        -- Indentation tracking

        -- use {"lifepillar/vim-gruvbox8"}


        -- use "tpope/vim-sleuth"

        use {"vim-test/vim-test", ft = {"go", "php"}}
        -- use { "rcarriga/vim-ultest", requires = {"vim-test/vim-test"}, run = ":UpdateRemotePlugins" }
        -- use {
        --     "akinsho/bufferline.nvim",
        --     requires = "kyazdani42/nvim-web-devicons",
        --     config = function()
        --         require "bufferline".setup()
        --     end
        -- }
        -- use "Shougo/echodoc.vim"

        -- use "cohama/lexima.vim"
        -- use "jiangmiao/auto-pairs"

        -- use "itchyny/lightline.vim"

        -- " For getting file icons in status-line, nerdtree etc. " Note: Make sure you
        -- have installed ttf-nerd-fonts-symbols, if you manjaro just run `pamac
        -- install ttf-nerd-fonts-symbols` use 'ryanoasis/vim-devicons'
        -- use {
        --     "kyazdani42/nvim-tree.lua",
        --     -- requires = {"kyazdani42/nvim-web-devicons", opt = true},
        --     cmd = {"NvimTreeToggle", "NvimTreeFindFile"}
        -- }


        -- " Vim motion in lightning fast speed
        -- use {"phaazon/hop.nvim"}
        -- use "zsugabubus/vim-jumpmotion"
        -- use "justinmk/vim-sneak"

        -- automatically clearing search highlights
        use "pgdouyon/vim-evanesco"

        -- use "mlaursen/vim-react-snippets"
        -- use "leafOfTree/vim-svelte-plugin"
        use {"mattn/emmet-vim", ft = {"html", "javascript", "typescriptreact", "svelte"}}
        use {"MaxMEllon/vim-jsx-pretty", ft = {"typescript", "javascript"}}
        use {"nelsyeung/twig.vim", ft = "twig"}
        -- use "sheerun/vim-polyglot"

        -- use {
        --     "glepnir/galaxyline.nvim",
        --     branch = "main",
        --     -- some optional icons
        --     requires = {"kyazdani42/nvim-web-devicons", opt = true}
        -- }

        -- requires = {"kyazdani42/nvim-web-devicons", opt = true}
        use {"ThePrimeagen/vim-be-good", cmd = "VimBeGood"}

        -- use {"Yggdroot/LeaderF"}

        use {"phux/vim-hardtime"}

        -- mermaid support
        -- use(
        --     {
        --         "iamcco/markdown-preview.nvim",
        --         run = "cd app && npm install",
        --         setup = function()
        --             vim.g.mkdp_filetypes = {"markdown", "vimwiki.markdown"}
        --         end,
        --         ft = {"markdown", "vimwiki", "vimwiki.markdown"}
        --     }
        -- )

        use {"junegunn/goyo.vim", ft = {"markdown", "vimwiki"}}
        use {"junegunn/limelight.vim", ft = {"markdown", "vimwiki"}}

        -- use {"vimwiki/vimwiki"}
        use {"michal-h21/vim-zettel"}

        -- use {"vitalk/vim-simple-todo", ft = {"markdown", "text"}}
        use {"dbeniamine/todo.txt-vim", ft = {"text"}}
        -- use "dhruvasagar/vim-dotoo"

        -- use "KevinBockelandt/notoire"

        -- use "~/code/vim-marker"
        -- use "~/code/notetaker.vim"
        -- use "mtth/scratch.vim"
        -- use "gcmt/wildfire.vim"
        use "rhysd/vim-grammarous"

        -- use "neovim/nvim-lspconfig"
        -- use "nvim-lua/lsp-status.nvim"
        -- use "mattn/vim-lsp-settings"
        -- use "RishabhRD/popfix"
        -- use "glepnir/lspsaga.nvim"
        -- use "nvim-lua/completion-nvim"

        -- use "steelsojka/completion-buffers"
        -- use "albertoCaroM/completion-tmux"
        -- use "nvim-treesitter/completion-treesitter"

        -- use "hrsh7th/nvim-compe"
        -- use {
        --     "hrsh7th/vim-vsnip",
        --     requires = {
        --         "hrsh7th/vim-vsnip-integ",
        --         "golang/vscode-go"
        --     }
        -- }

    end
)

local autocmds = {
    plugins = {
        {"BufWritePost", "plugins.lua", ":luafile %"},
        {"BufWritePost", "plugins.lua", ":PackerCompile"}
    }
}

U.augroups(autocmds)
