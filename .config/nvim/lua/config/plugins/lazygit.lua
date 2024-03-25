return {
    "kdheepak/lazygit.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        -- require("lazygit").setup({})

        vim.api.nvim_set_keymap("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit" })
    end,
}
