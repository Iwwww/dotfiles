return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      -- NOTE: tree-sitter-cli нужен для :TSInstallFromGrammar и некоторых парсеров.
      -- На NixOS ставь через nix: pkgs.tree-sitter
      local config = require("nvim-treesitter.config")

      config.setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        autotag = {
          enable = true,
        },
        auto_install = false,
        ensure_installed = {
          "bash",
          "c",
          "cmake",
          "cpp",
          "css",
          "html",
          "javascript",
          "json",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "nix",
          "python",
          "sql",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-Tab>",
            node_incremental = "<C-Tab>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
}
