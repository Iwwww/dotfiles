local status, packer = pcall(require, "packer")
if (not status) then
    print("Packer is not installed")
    return
end

packer.startup(function(use)
    use "wbthomason/packer.nvim" -- plugin manager

    -- Colorscheme
    use({ "rose-pine/neovim", as = "rose-pine" })
    -- use({ "dracula/vim", as = "dracula" })
    use "ellisonleao/gruvbox.nvim"
    use "navarasu/onedark.nvim"

    -- General
    use "ryanoasis/vim-devicons"
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }
    use "nvim-treesitter/nvim-treesitter"
    use {

        "nvim-telescope/telescope.nvim", tag = "0.1.x",
        requires = { { "nvim-lua/plenary.nvim" } },
        "nvim-telescope/telescope-file-browser.nvim",
    }
    use "nvim-lua/plenary.nvim"
    use {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }
    use {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp-signature-help",

        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        require = { "neovim/nvim-lspconfig" },
    }
    use "folke/neodev.nvim"
    use {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
        end,
    }
    use "numToStr/Comment.nvim"
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    use "echasnovski/mini.surround"
    use "windwp/nvim-autopairs"
    use "lewis6991/impatient.nvim"
    use "chaoren/vim-wordmotion"

    -- Git
    use "lewis6991/gitsigns.nvim"

    -- Web Dev
    use "AndrewRadev/tagalong.vim"
    use "ap/vim-css-color"
    use "norcalli/nvim-colorizer.lua"
    use({
        "ziontee113/color-picker.nvim",
        config = function()
            require("color-picker")
        end,
    })

    -- UI
    use "folke/which-key.nvim"
    use({
        "folke/noice.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
        }
    })
    use "echasnovski/mini.indentscope"
    use "aveplen/ruscmd.nvim"
    use "mhinz/vim-startify"
    use "RRethy/vim-illuminate"
    use "MunifTanjim/nui.nvim"

    -- Language specific
    use "simrat39/rust-tools.nvim"
    -- use "p00f/clangd_extensions.nvim"
end)
