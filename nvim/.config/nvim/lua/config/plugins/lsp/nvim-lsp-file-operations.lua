return {
  "antosha417/nvim-lsp-file-operations",
  -- loaded after the session is idle so it (and its nvim-tree dependency)
  -- does not block startup; rename/move via tree stays lazy-triggered
  event = { "VeryLazy" },
  dependencies = { "nvim-tree/nvim-tree.lua" },
  config = true,
}
