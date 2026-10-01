return {
  "kdheepak/lazygit.nvim",
  cmd = { "LazyGit", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile", "LazyGitLog" },
  keys = {
    { "<leader>gg", desc = "LazyGit" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    vim.g.lazygit_floating_window_scaling_factor = 1.0 -- scaling factor for floating window
  end,
}
