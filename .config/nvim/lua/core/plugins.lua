local status, packer = pcall(require, "packer")
if (not status) then
    print("Packer is not installed")
    return
end

packer.startup(function(use)
    use "wbthomason/packer.nvim" -- plugin manager

    -- Colorscheme
    -- use({ "rose-pine/neovim", as = "rose-pine" })
    -- use({ "dracula/vim", as = "dracula" })
    use "ellisonleao/gruvbox.nvim"

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

        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        require = { "neovim/nvim-lspconfig" },
    }

    use "numToStr/Comment.nvim"
    use "folke/which-key.nvim"
end)
