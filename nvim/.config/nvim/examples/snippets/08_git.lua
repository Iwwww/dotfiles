-- =============================================================================
-- Snippet: Git Integration
-- Source: kickstart.nvim (gitsigns) + mini.nvim (mini.git + mini.diff)
-- Scope: Визуализация git-изменений и навигация по хункам
-- Note: kickstart использует gitsigns; mini.nvim предлагает лёгкую альтернативу
-- =============================================================================

-- ============================================================================
-- ВАРИАНТ A: gitsigns.nvim (как в kickstart)
-- Source: kickstart.nvim (строки ~210-240)
-- ============================================================================
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
}

-- ============================================================================
-- ВАРИАНТ B: mini.diff + mini.git (альтернатива из mini.nvim)
-- Source: mini.nvim readmes
-- Scope: Легковесная замена gitsigns без зависимостей
-- ============================================================================
--[[
return {
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Визуализация diff-хунков в sign column
      require("mini.diff").setup({
        view = {
          style = "sign",
          signs = { add = "+", change = "~", delete = "_" },
        },
      })

      -- Git интеграция: :Git команда, буфер-локальные данные
      require("mini.git").setup()
    end,
  },
}
--]]

-- ============================================================================
-- Дополнительно: keymaps для git (независимо от плагина)
-- Source: tjdevries/config.nvim
-- ============================================================================
-- vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>", { desc = "[G]it [B]lame" })
-- vim.keymap.set("n", "<leader>gs", "<cmd>Git status<cr>", { desc = "[G]it [S]tatus" })
