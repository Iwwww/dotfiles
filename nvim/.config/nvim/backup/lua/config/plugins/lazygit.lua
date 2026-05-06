return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    vim.g.lazygit_floating_window_scaling_factor = 1.0 -- scaling factor for floating window

    vim.api.nvim_set_keymap("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit" })
  end,
}
