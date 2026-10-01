return {
  "hat0uma/csvview.nvim",
  -- loaded just after the first render; the open buffer is attached
  -- retroactively, a FileType autocmd covers buffers opened later
  event = { "VeryLazy" },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle", "CsvViewInfo" },
  opts = {
    parser = {
      comments = { "#", "--" },
    },
    view = {
      display_mode = "border",
      sticky_header = {
        enabled = true,
        separator = "─",
      },
    },
    keymaps = {
      -- text objects for selecting fields
      textobject_field_inner = { "if", mode = { "o", "x" } },
      textobject_field_outer = { "af", mode = { "o", "x" } },
      -- excel-like navigation
      jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
      jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
      jump_next_row = { "<Enter>", mode = { "n", "v" } },
      jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
    },
  },
  config = function(_, opts)
    local csvview = require("csvview")
    csvview.setup(opts)

    -- retro-attach the buffer that was already open before the first render
    if vim.bo.filetype == "csv" or vim.bo.filetype == "tsv" then
      csvview.enable(vim.api.nvim_get_current_buf())
    end

    -- buffers opened after VeryLazy
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "csv", "tsv" },
      callback = function(ev)
        csvview.enable(ev.buf)
      end,
    })
  end,
}
