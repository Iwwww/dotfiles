return {
  "NvChad/nvim-colorizer.lua",
  -- loaded just after the first render; setup() registers FileType autocmds
  -- for later buffers, the open one is highlighted retroactively
  event = { "VeryLazy" },
  config = function()
    local colorizer = require("colorizer")
    colorizer.setup({
      filetypes = { "css", "scss", "sass", "less", "html", "htmldjango", "markdown", "lua" },
    })

    local buf = vim.api.nvim_get_current_buf()
    colorizer.attach_to_buffer(buf)
  end,
}
