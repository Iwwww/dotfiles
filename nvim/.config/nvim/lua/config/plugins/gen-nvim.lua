return {
  "David-Kunz/gen.nvim",
  cmd = { "Gen" },
  keys = {
    { "<leader>a", mode = { "n", "v" }, desc = "AI generation" },
  },
  config = function()
    require("gen").model = "codellama"
    -- require('gen').model = 'codeup'
    vim.keymap.set({ "n", "v" }, "<leader>a", ":Gen<cr>", { desc = "AI generation" })
  end,
}
