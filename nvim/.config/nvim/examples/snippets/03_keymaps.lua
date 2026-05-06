-- =============================================================================
-- Snippet: Keymaps + Which-Key
-- Source: kickstart.nvim (init.lua, строки ~105-165)
-- Scope: Современный способ назначения keymaps с описанием и интеграцией which-key
-- Note: Всегда используем vim.keymap.set, НЕ vim.api.nvim_set_keymap
-- =============================================================================

-- Сброс подсветки поиска по Esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Диагностика
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Терминал: выход из terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Навигация по окнам
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Which-Key spec для группировки keymaps
-- Source: kickstart.nvim
return {
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { "<leader>s", group = "[S]earch", mode = { "n", "v" } },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
        { "gr", group = "LSP Actions", mode = { "n" } },
      },
    },
  },
}
