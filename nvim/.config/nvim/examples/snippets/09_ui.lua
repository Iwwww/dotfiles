-- =============================================================================
-- Snippet: UI Setup (Colorscheme + Statusline + Tabline)
-- Source: kickstart.nvim + mini.nvim + tjdevries/config.nvim
-- Scope: Визуальная часть: тема, статуслайн, иконки
-- =============================================================================

-- ============================================================================
-- Цветовая схема (kickstart.nvim)
-- ============================================================================
return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- загружать ДО других плагинов
    config = function()
      require("tokyonight").setup({
        styles = {
          comments = { italic = false },
        },
      })
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  -- ============================================================================
  -- Статуслайн: mini.statusline (легковесный вариант)
  -- Source: kickstart.nvim (строки ~810-830) + mini.nvim
  -- ============================================================================
  {
    "echasnovski/mini.nvim",
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      -- Кастомизация секции с позицией курсора
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },

  -- ============================================================================
  -- Альтернатива статуслайну: lualine.nvim
  -- Source: сообщество (не в kickstart, но популярно)
  -- ============================================================================
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   opts = {
  --     options = {
  --       theme = "tokyonight",
  --       component_separators = "|",
  --       section_separators = "",
  --     },
  --   },
  -- },

  -- ============================================================================
  -- Иконки: mini.icons (замена nvim-web-devicons)
  -- Source: mini.nvim
  -- ============================================================================
  -- {
  --   "echasnovski/mini.nvim",
  --   config = function()
  --     require("mini.icons").setup()
  --     -- Мокаем nvim-web-devicons для совместимости с другими плагинами
  --     MiniIcons.mock_nvim_web_devicons()
  --   end,
  -- },

  -- ============================================================================
  -- Todo-comments (подсветка TODO, FIXME, NOTE в комментариях)
  -- Source: kickstart.nvim
  -- ============================================================================
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
}
