-- =============================================================================
-- Snippet: mini.nvim Modules
-- Source: kickstart.nvim + mini.nvim readmes + tjdevries/config.nvim
-- Scope: Минимальные примеры замены популярных плагинов через mini.nvim
-- Note: Каждый модуль независим; можно использовать отдельно
-- =============================================================================

return {
  {
    "echasnovski/mini.nvim",
    version = false, -- main branch для latest features
    config = function()
      -- ============================================================================
      -- 1. mini.ai — расширенные текстовые объекты (around/inside)
      -- Source: kickstart.nvim (строки ~780-800)
      -- ============================================================================
      require("mini.ai").setup({
        -- Избегаем конфликтов с built-in incremental selection в Neovim 0.12+
        mappings = {
          around_next = "aa",
          inside_next = "ii",
        },
        n_lines = 500,
      })

      -- ============================================================================
      -- 2. mini.surround — добавление/удаление/замена окружений
      -- Source: kickstart.nvim
      -- ============================================================================
      require("mini.surround").setup()
      -- Примеры:
      --   saiw) — Surround Add Inner Word )Paren
      --   sd'   — Surround Delete 'quotes
      --   sr)'  — Surround Replace ) with '

      -- ============================================================================
      -- 3. mini.statusline — минимальный статуслайн
      -- Source: kickstart.nvim
      -- ============================================================================
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = vim.g.have_nerd_font })
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end

      -- ============================================================================
      -- 4. mini.pick — fuzzy finder (замена Telescope/fzf-lua)
      -- Source: mini.nvim readme
      -- ============================================================================
      require("mini.pick").setup()
      -- Keymaps:
      -- vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files, { desc = "[F]ind [F]iles" })
      -- vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "[F]ind by [G]rep" })
      -- vim.keymap.set("n", "<leader>fb", MiniPick.builtin.buffers, { desc = "[F]ind [B]uffers" })
      -- vim.keymap.set("n", "<leader>fh", MiniPick.builtin.help, { desc = "[F]ind [H]elp" })

      -- ============================================================================
      -- 5. mini.files — файловый менеджер (Miller columns)
      -- Source: mini.nvim readme
      -- ============================================================================
      require("mini.files").setup()
      -- vim.keymap.set("n", "<leader>e", MiniFiles.open, { desc = "Open [E]xplorer" })

      -- ============================================================================
      -- 6. mini.git — git интеграция
      -- Source: mini.nvim readme
      -- ============================================================================
      require("mini.git").setup()

      -- ============================================================================
      -- 7. mini.diff — визуализация diff-хунков (замена gitsigns)
      -- Source: mini.nvim readme
      -- ============================================================================
      require("mini.diff").setup({
        view = {
          style = "sign",
          signs = { add = "+", change = "~", delete = "_" },
        },
      })

      -- ============================================================================
      -- 8. mini.icons — иконки (замена nvim-web-devicons)
      -- Source: mini.nvim readme
      -- ============================================================================
      -- require("mini.icons").setup()
      -- MiniIcons.mock_nvim_web_devicons()

      -- ============================================================================
      -- 9. mini.hipatterns — подсветка hex-цветов, etc.
      -- Source: tjdevries/config.nvim
      -- ============================================================================
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      -- ============================================================================
      -- 10. mini.pairs — автопары
      -- Source: сообщество (в kickstart есть kickstart.plugins.autopairs)
      -- ============================================================================
      -- require("mini.pairs").setup()

      -- ============================================================================
      -- 11. mini.comment — комментирование
      -- Source: сообщество
      -- ============================================================================
      -- require("mini.comment").setup()

      -- ============================================================================
      -- 12. mini.move — перемещение выделенного текста
      -- Source: сообщество
      -- ============================================================================
      -- require("mini.move").setup()
    end,
  },
}
