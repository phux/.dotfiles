local packer = require("packer")
local use = packer.use
local U = require "utils"

packer.init()
-- Packer can manage itself as an optional plugin
-- use { 'wbthomason/packer.nvim', opt = true }
use {"wbthomason/packer.nvim"}

use {"lifepillar/vim-gruvbox8"}
use {"sainnhe/gruvbox-material"}

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
        "nvim-lua/plenary.nvim"
    }
}

-- " For showing the actual color of the hex value
use "norcalli/nvim-colorizer.lua"

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
use "tpope/vim-sleuth"

use {"vim-test/vim-test", ft = {"go", "php"}}

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

use "cohama/lexima.vim"

-- use "itchyny/lightline.vim"

-- " For getting file icons in status-line, nerdtree etc. " Note: Make sure you
-- have installed ttf-nerd-fonts-symbols, if you manjaro just run `pamac
-- install ttf-nerd-fonts-symbols` use 'ryanoasis/vim-devicons'
use {
    "kyazdani42/nvim-tree.lua",
    requires = {"kyazdani42/nvim-web-devicons", opt = true}
}

use {"hashivim/vim-terraform", ft = "tf"}

-- " Vim motion in lightning fast speed
use "easymotion/vim-easymotion"

-- automatically clearing search highlights
use "pgdouyon/vim-evanesco"

use "jparise/vim-graphql"

use {
    "glepnir/galaxyline.nvim",
    branch = "main",
    -- some optional icons
    requires = {"kyazdani42/nvim-web-devicons", opt = true}
}

use {"ThePrimeagen/vim-be-good", cmd = "VimBeGood"}

use {"Yggdroot/LeaderF"}

use {"phux/vim-hardtime"}
use "kassio/neoterm"
use "brooth/far.vim"

local autocmds = {
    plugins = {
        {"BufWritePost", "plugins.lua", ":luafile %"}
    }
}
U.augroups(autocmds)
