return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  -- loaded just after the first render; render-markdown retro-attaches the
  -- current buffer on init (it checks the buffer filetype, so it stays off
  -- for non-markdown) and hooks FileType for buffers opened later
  event = { "VeryLazy" },
  config = function()
    require("render-markdown").setup({
      latex = { enabled = false },
      -- use the built-in in-process LSP for completions instead of the cmp
      -- integration, which would pull the whole nvim-cmp stack in
      completions = { lsp = { enabled = true } },
    })
  end,
}
