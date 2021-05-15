local packer = require("packer")
local use = packer.use
local U = require "utils"

packer.init()
-- Packer can manage itself as an optional plugin
-- use { 'wbthomason/packer.nvim', opt = true }
use {"wbthomason/packer.nvim"}

-- " For navigating b/w tmux window, specially for navigating with NERDTree
use "christoomey/vim-tmux-navigator"

-- " FocusGained and FocusLost autocommand events are not working in terminal
-- vim. This plugin restores them when using vim inside Tmux.
use "tmux-plugins/vim-tmux-focus-events"

use {"neoclide/coc.nvim", branch = "release"}
use "antoinemadec/coc-fzf"
use {"rafcamlet/coc-nvim-lua", ft = "lua"}
use "honza/vim-snippets"

use {"junegunn/fzf", run = "./install --all"}
use {"junegunn/fzf.vim"}
use {"junegunn/gv.vim", cmd = "GV"}
use "sinetoami/fzy.nvim"
-- use {"lotabout/skim", run = "./install"}
-- use "lotabout/skim.vim"

use {"majutsushi/tagbar", cmd = "TagbarOpenAutoClose"}

-- " For various text objects
use "wellle/targets.vim"
use "wellle/tmux-complete.vim"
use {
    "wellle/context.vim",
    config = function()
        vim.g.context_enabled = false
    end
}

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
    config = function()
        require "colorizer".setup()
    end
}
use "w0rp/ale"

-- Wrapping/delimiters
use {"machakann/vim-sandwich", {"andymass/vim-matchup", event = "VimEnter *"}}

-- Indentation tracking
use "yggdroot/indentLine"

use "talek/obvious-resize"

-- " git stuff
-- use {"rhysd/git-messenger.vim", cmd = "GitMessenger"}
use {"rhysd/git-messenger.vim"}
use "tpope/vim-fugitive"
use "tpope/vim-rhubarb"
use "samoshkin/vim-mergetool"
-- use {"whiteinge/diffconflicts", cmd = "DiffConflicts"}
-- use "christoomey/vim-conflicted"
use {"jreybert/vimagit", cmd = {"Magit", "MagitOnly"}}
use "sodapopcan/vim-twiggy"
use "airblade/vim-gitgutter"
-- use {
--     "lewis6991/gitsigns.nvim",
--     requires = {
--         "nvim-lua/plenary.nvim"
--     },
--     config = function()
--         require("gitsigns").setup()
--     end
-- }

use {"AndrewRadev/splitjoin.vim", cmd = "SplitjoinSplit"}

use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
-- use "romgrk/nvim-treesitter-context"

use {"lifepillar/vim-gruvbox8"}
-- use {"sainnhe/gruvbox-material"}

use {"tweekmonster/startuptime.vim", cmd = "StartupTime"}

use "tpope/vim-commentary"

use "tpope/vim-abolish"
-- use "tpope/vim-sleuth"

use {"vim-test/vim-test", ft = {"go", "php"}}
use {"adoy/vim-php-refactoring-toolbox", ft = "php"}
use {"phux/php-doc-modded", ft = "php"}

use {
    "phpactor/phpactor",
    run = " composer install --no-dev -o",
    ft = {"php"}
}

use {"laher/gothx.vim", ft = "go"}
use {"sebdah/vim-delve", ft = "go"}
use {"rhysd/vim-go-impl", ft = "go"}
use {"benmills/vim-golang-alternate", ft = "go"}

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
    -- requires = {"kyazdani42/nvim-web-devicons", opt = true},
    cmd = {"NvimTreeToggle", "NvimTreeFindFile"}
}

use {"hashivim/vim-terraform", ft = "tf"}

-- " Vim motion in lightning fast speed
use {"easymotion/vim-easymotion"}
-- use {"phaazon/hop.nvim"}
-- use "zsugabubus/vim-jumpmotion"
-- use "justinmk/vim-sneak"

-- automatically clearing search highlights
use "pgdouyon/vim-evanesco"

-- use "mlaursen/vim-react-snippets"
use "leafOfTree/vim-svelte-plugin"
use {"mattn/emmet-vim", ft = {"html", "javascript", "typescriptreact", "svelte"}}
use {"MaxMEllon/vim-jsx-pretty", ft = {"typescript", "javascript"}}
use {"jparise/vim-graphql", ft = {"graphql"}}
use {"nelsyeung/twig.vim", ft = "twig"}
-- use "sheerun/vim-polyglot"

-- use {
--     "glepnir/galaxyline.nvim",
--     branch = "main",
--     -- some optional icons
--     requires = {"kyazdani42/nvim-web-devicons", opt = true}
-- }

use "hoob3rt/lualine.nvim"
-- requires = {"kyazdani42/nvim-web-devicons", opt = true}
use {"ThePrimeagen/vim-be-good", cmd = "VimBeGood"}

-- use {"Yggdroot/LeaderF"}

use {"phux/vim-hardtime"}
use {"brooth/far.vim", cmd = "Far"}

use {"iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app & yarn install"}
use {"SidOfc/mkdx", ft = "markdown"}

use {"junegunn/goyo.vim", ft = {"markdown", "vimwiki"}}
use {"junegunn/limelight.vim", ft = {"markdown", "vimwiki"}}

use {"vimwiki/vimwiki"}
use {"michal-h21/vim-zettel"}

-- use {"vitalk/vim-simple-todo", ft = {"markdown", "text"}}
use {"dbeniamine/todo.txt-vim", ft = {"text"}}
-- use "dhruvasagar/vim-dotoo"

use "ActivityWatch/aw-watcher-vim"
-- use "KevinBockelandt/notoire"

use "~/code/vim-marker"
use "~/code/notetaker.vim"
use "mtth/scratch.vim"
use "gcmt/wildfire.vim"
use "rhysd/vim-grammarous"
use "simnalamburt/vim-mundo"

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
use {
    "hrsh7th/vim-vsnip",
    requires = {
        "hrsh7th/vim-vsnip-integ",
        "golang/vscode-go"
    }
}

--

local autocmds = {
    plugins = {
        {"BufWritePost", "plugins.lua", ":luafile %"},
        {"BufWritePost", "plugins.lua", ":PackerCompile"}
    }
}

U.augroups(autocmds)
