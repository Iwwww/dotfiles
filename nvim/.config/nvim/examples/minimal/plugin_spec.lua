-- =============================================================================
-- Minimal lazy.nvim Plugin Spec
-- Source: lazy.nvim documentation + kickstart.nvim
-- Scope: Минимальный рабочий пример спецификации плагина
-- Note: Этот файл должен возвращать таблицу (или таблицу таблиц)
-- =============================================================================

return {
  -- Простейший spec: только репозиторий + opts (вызывает setup(opts))
  { "NMAC427/guess-indent.nvim", opts = {} },

  -- Spec с зависимостями и build-шагом
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
    config = function()
      require("nvim-treesitter").install({ "lua", "vim", "vimdoc" })
    end,
  },

  -- Spec с event, keys и config
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
      delay = 0,
      spec = {
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle" },
      },
    },
  },

  -- Spec с dependencies и conditional loading
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = function() return vim.fn.executable("make") == 1 end },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_dropdown() },
        },
      })
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
    end,
  },

  -- Spec с priority (для цветовых схем)
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("tokyonight").setup({ styles = { comments = { italic = false } } })
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  -- Spec с keys (lazy-loading по keymaps)
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function() require("conform").format({ async = true }) end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      formatters_by_ft = { lua = { "stylua" } },
    },
  },
}
