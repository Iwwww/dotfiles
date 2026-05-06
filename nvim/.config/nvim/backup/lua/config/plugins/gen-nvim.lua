return {
  "David-Kunz/gen.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  config = function()
    require("gen").model = "codellama"
    -- require('gen').model = 'codeup'
  end,
  vim.keymap.set({ "n", "v" }, "<leader>a", ":Gen<cr>", { desc = "AI generation" }),
}
