return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      vim.keymap.set("n", "]h", function()
        gs.next_hunk()
      end, { buffer = bufnr, desc = "Next [H]unk" })
      vim.keymap.set("n", "[h", function()
        gs.prev_hunk()
      end, { buffer = bufnr, desc = "Previous [H]unk" })
      vim.keymap.set("n", "<leader>gh", gs.preview_hunk, { buffer = bufnr, desc = "[G]it preview [H]unk" })
      vim.keymap.set("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, { buffer = bufnr, desc = "[G]it [B]lame line" })
      vim.keymap.set("n", "<leader>gd", gs.diffthis, { buffer = bufnr, desc = "[G]it [D]iff this" })
    end,
  },
}
