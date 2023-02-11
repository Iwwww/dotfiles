local status, packer = pcall(require, 'packer')
if (not status) then
  print("Packer is not installed")
  return
end

packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- plugin manager

  use 'wadackel/vim-dogrun'

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-buffer'},
  }

  use {
    "folke/which-key.nvim",
       config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end
  }

  -- colorize code syntax
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }

  -- telescope
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-telescope/telescope-live-grep-args.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      -- vscode-like pictograms
      'onsails/lspkind-nvim',
    },
    config = function()
        require('telescope').load_extension('live_grep_args')
      end
  }
  require("telescope").load_extension('harpoon')  -- Telescope for harpoon

  -- LSP
    use { -- LSP Configuration & PluginsForHost
    'neovim/nvim-lspconfig',
    requires = {
      -- Mason
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',
      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
      -- LSP UIs
      -- 'glepnir/lspsaga.nvim',
      use({
          "glepnir/lspsaga.nvim",
          branch = "main",
          -- config = function()
          --     require("lspsaga").setup({})
          -- end,
          requires = { {"nvim-tree/nvim-web-devicons"} }
      })
    },
  }

  use 'ThePrimeagen/harpoon'  -- Buffer navigation

  use 'hoob3rt/lualine.nvim' -- statusline

  use 'windwp/nvim-autopairs'

  use 'kyazdani42/nvim-web-devicons' -- File icons

  use 'akinsho/nvim-bufferline.lua' -- Snezzy buffer

  use 'norcalli/nvim-colorizer.lua' -- Colorize colors

  use 'lewis6991/gitsigns.nvim'

  use 'dinhhuy258/git.nvim'

  use 'lukas-reineke/indent-blankline.nvim' -- Show indents

  use 'ray-x/lsp_signature.nvim' -- Signature hint while typing

  use 'numToStr/Comment.nvim' -- Comment

  use 'nmac427/guess-indent.nvim' -- Smart indent

  -- markdown preview
  use({
      'iamcco/markdown-preview.nvim',
      run = function() vim.fn['mkdp#util#install']() end,
  })

  -- use({ 'iamcco/markdown-preview.nvim', run = 'cd app && npm install', setup = function() vim.g.mkdp_filetypes = { 'markdown' } end, ft = { 'markdown' }, })

end)



