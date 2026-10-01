return {
  -- plenary.nvim is declared as a dependency by the plugins that need it
  -- (telescope, lazygit); an eager top-level spec would just preload it
  "inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)
  event = "VeryLazy",
}
