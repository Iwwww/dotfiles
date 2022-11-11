local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- plugin manager

  use 'RRethy/nvim-base16' -- colorscheme
  use 'hoob3rt/lualine.nvim' -- statusline

  -- complition
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'

  use 'L3MON4D3/LuaSnip' -- snippets

  -- colorize code syntax
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }

  use 'windwp/nvim-autopairs'

  -- telescope
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  use 'kyazdani42/nvim-web-devicons' -- File icons

  use 'akinsho/nvim-bufferline.lua' -- Snezzy buffer

  use 'norcalli/nvim-colorizer.lua' -- Colorize colors

  use 'glepnir/lspsaga.nvim' -- LSP UIs

  -- LSP
  use 'neovim/nvim-lspconfig'

  use 'lewis6991/gitsigns.nvim'

  use 'dinhhuy258/git.nvim'

  use 'nvim-tree/nvim-tree.lua' -- File tree

  use "lukas-reineke/indent-blankline.nvim" -- Show indents

  use "ray-x/lsp_signature.nvim" -- Signature hint while typing

  -- mason
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "WhoIsSethDaniel/mason-tool-installer.nvim"

  use "numToStr/Comment.nvim" -- Comment

  use "nmac427/guess-indent.nvim" -- Smart indent
end)



