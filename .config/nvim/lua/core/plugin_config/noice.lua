local noice = require('noice')

noice.setup({
    -- lsp = {
    --     -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    --     override = {
    --         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --         ["vim.lsp.util.stylize_markdown"] = true,
    --         ["cmp.entry.get_documentation"] = true,
    --     },
    -- },
    -- -- you can enable a preset for easier configuration
    -- presets = {
    --     bottom_search = true,     -- use a classic bottom cmdline for search
    --     command_palette = true,   -- position the cmdline and popupmenu together
    --     long_message_to_split = true, -- long messages will be sent to a split
    --     inc_rename = false,        -- enables an input dialog for inc-rename.nvim
    --     lsp_doc_border = true,   -- add a border to hover docs and signature help
    -- },
    views = {
      cmdline_popup = {
        position = {
          row = "99.9%",
          col = "0%",
        },
        size = {
          width = "50%",
          height = "auto",
        },
        border = {
          style = "none",
          padding = { 0, 0 },
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = 8,
          col = "50%",
        },
        size = {
          width = 88,
          height = 10,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
      },
    },
})
