local packer = require("packer")
local use = packer.use
local U = require "utils"

packer.init()
-- Packer can manage itself as an optional plugin
-- use { 'wbthomason/packer.nvim', opt = true }
use {"wbthomason/packer.nvim"}

use {"lifepillar/vim-gruvbox8"}
-- use {"sainnhe/gruvbox-material"}

-- " For navigating b/w tmux window, specially for navigating with NERDTree
use "christoomey/vim-tmux-navigator"

-- " FocusGained and FocusLost autocommand events are not working in terminal
-- vim. This plugin restores them when using vim inside Tmux.
use "tmux-plugins/vim-tmux-focus-events"

-- " Intellisense and completion engine
use {"neoclide/coc.nvim", branch = "release"}
use "antoinemadec/coc-fzf"
use {"rafcamlet/coc-nvim-lua", ft = "lua"}
use {"junegunn/fzf", run = "./install --all"}
use {"junegunn/fzf.vim"}
use {"junegunn/gv.vim", cmd = "GV"}

use {"majutsushi/tagbar", cmd = "TagbarOpenAutoClose"}

-- " For various text objects
use "wellle/targets.vim"
use "wellle/tmux-complete.vim"

use {
    "nvim-lua/telescope.nvim",
    requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzy-native.nvim",
        "nvim-telescope/telescope-fzf-writer.nvim"
    }
}

-- " For showing the actual color of the hex value
use {
    "norcalli/nvim-colorizer.lua",
    ft = {"conf", "css"},
    config = function()
        require "colorizer".setup()
    end
}
use "w0rp/ale"

-- Wrapping/delimiters
use {"machakann/vim-sandwich", {"andymass/vim-matchup", event = "VimEnter *"}}

-- Indentation tracking
use "yggdroot/indentLine"

-- " git stuff
-- use {"rhysd/git-messenger.vim", cmd = "GitMessenger"}
use {"rhysd/git-messenger.vim"}
use "tpope/vim-fugitive"
use "tpope/vim-rhubarb"
use {"whiteinge/diffconflicts", cmd = "DiffConflicts"}
use {
    "lewis6991/gitsigns.nvim",
    requires = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        require("gitsigns").setup()
    end
}

use {"AndrewRadev/splitjoin.vim", cmd = "SplitjoinSplit"}

use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
-- use "romgrk/nvim-treesitter-context"

use {"tweekmonster/startuptime.vim", cmd = "StartupTime"}

use "tpope/vim-commentary"

use "tpope/vim-abolish"
-- use "tpope/vim-sleuth"

use {"vim-test/vim-test", ft = {"go", "php"}}
use {"adoy/vim-php-refactoring-toolbox", ft = "php"}

use {
    "phpactor/phpactor",
    run = " composer install --no-dev -o",
    ft = {"php"}
}

use {"laher/gothx.vim", ft = "go"}
use {"sebdah/vim-delve", ft = "go"}
use {"rhysd/vim-go-impl", ft = "go"}

use "ap/vim-buftabline"
-- use 'akinsho/nvim-bufferline.lua'
use "Shougo/echodoc.vim"

-- use "cohama/lexima.vim"
use "jiangmiao/auto-pairs"

-- use "itchyny/lightline.vim"

-- " For getting file icons in status-line, nerdtree etc. " Note: Make sure you
-- have installed ttf-nerd-fonts-symbols, if you manjaro just run `pamac
-- install ttf-nerd-fonts-symbols` use 'ryanoasis/vim-devicons'
use {
    "kyazdani42/nvim-tree.lua",
    requires = {"kyazdani42/nvim-web-devicons", opt = true},
    cmd = {"NvimTreeToggle", "NvimTreeFindFile"}
}

-- use {"hashivim/vim-terraform", ft = "tf"}

-- " Vim motion in lightning fast speed
use {"easymotion/vim-easymotion"}
-- use "justinmk/vim-sneak"

-- automatically clearing search highlights
use "pgdouyon/vim-evanesco"

-- use {"jparise/vim-graphql", ft = {"typescript", "javascript", "graphql"}}
-- use {"nelsyeung/twig.vim", ft = "twig"}
use "sheerun/vim-polyglot"

-- use {
--     "glepnir/galaxyline.nvim",
--     branch = "main",
--     -- some optional icons
--     requires = {"kyazdani42/nvim-web-devicons", opt = true}
-- }

use {
    "hoob3rt/lualine.nvim",
    requires = {"kyazdani42/nvim-web-devicons", opt = true},
    config = function()
        local lualine = require("lualine")
        lualine.theme = "gruvbox"
        lualine.separator = "|"
        lualine.sections = {
            lualine_a = {"mode"},
            lualine_b = {"branch"},
            lualine_c = {"filename"},
            lualine_x = {"encoding", "fileformat", "filetype"},
            lualine_y = {"progress"},
            lualine_z = {"location"}
        }
        lualine.inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {"filename"},
            lualine_x = {"location"},
            lualine_y = {},
            lualine_z = {}
        }
        lualine.extensions = {"fzf"}
        lualine.status()
    end
}
use {"ThePrimeagen/vim-be-good", cmd = "VimBeGood"}

-- use {"Yggdroot/LeaderF"}

use {"phux/vim-hardtime"}
use {"brooth/far.vim", cmd = "Far"}

-- use {
--     "plasticboy/vim-markdown",
--     ft = "markdown",
--     requires = {"godlygeek/tabular", opt = true}
-- }

use {"iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app & yarn install"}
-- let g:mkdp_path_to_chrome = 'chromium-browser'
-- let g:mkdp_auto_close = 1
-- let g:mkdp_auto_start = 0

use {"vimwiki/vimwiki", cmd = "VimwikiIndex"}
use {"michal-h21/vim-zettel"}

use {"vitalk/vim-simple-todo", ft = {"markdown", "text"}}
use {"dbeniamine/todo.txt-vim", ft = {"text"}}

use "ActivityWatch/aw-watcher-vim"
-- use "KevinBockelandt/notoire"

local autocmds = {
    plugins = {
        {"BufWritePost", "plugins.lua", ":luafile %"},
        {"BufWritePost", "plugins.lua", ":PackerCompile"}
    }
}

U.augroups(autocmds)
