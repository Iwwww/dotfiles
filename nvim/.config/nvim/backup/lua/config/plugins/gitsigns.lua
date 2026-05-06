return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
        delay = 50,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%d-%m-%Y> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    })

    vim.keymap.set("n", "<leader>gl", "<cmd>Gitsigns toggle_linehl<cr>", { desc = "Git toggle lines diff highlight" })
    vim.keymap.set(
      "n",
      "<leader>gw",
      "<cmd>Gitsigns toggle_word_diff<cr>",
      { desc = "Git toggle world diff highlight" }
    )
    vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "Git toggle deleted" })
    vim.keymap.set("n", "<leader>gD", "<cmd>Gitsigns diffthis<cr>", { desc = "Git toggle deleted" })
    vim.keymap.set(
      "n",
      "<leader>gb",
      "<cmd>Gitsigns toggle_current_line_blame<cr>",
      { desc = "Git toggle current line blame" }
    )
    vim.keymap.set({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Git stage hunk" })
    vim.keymap.set({ "n", "v" }, "<leader>gS", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Git undo stage hunk" })
    vim.keymap.set("n", "<leader>g]", "<cmd>Gitsigns next_hunk<cr>", { desc = "Git next hunk" })
    vim.keymap.set("n", "<leader>g[", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Git previous hunk" })
    vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Git preview hunk" })
    vim.keymap.set({ "n", "v" }, "<leader>gR", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Git reset hunk" })
  end,
}
