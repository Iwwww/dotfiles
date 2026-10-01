return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-file-browser.nvim",
    },
    lazy = true,
    keys = {
        "<leader>ff",
        "<leader>fr",
        "<leader>fg",
        "<leader>fc",
        "<leader>fh",
        "<leader>fb"
    },
    cmd = {
        "Telescope find_files",
        "Telescope oldfiles",
        "Telescope live_grep",
        "Telescope grep_string",
        "Telescope help_tags",
        "Telescope file_browser",
    },

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = { "truncate " },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next,     -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
            extensions = {
                file_browser = {
                    theme = "ivy",
                    -- disables netrw and use telescope-file-browser in its place
                    hijack_netrw = true,
                    mappings = {
                        ["i"] = {
                            -- your custom insert mode mappings
                        },
                        ["n"] = {
                            -- your custom normal mode mappings
                        },
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        telescope.load_extension("file_browser")

        -- local builtin = require('telescope.builtin')
        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
        keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep string in cwd" })
        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
        keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {})
        keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", {})

        -- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        -- vim.keymap.set('n', '<leader>ft', builtin.buffers, {})
        -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        -- vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
        -- vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
        -- vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
        -- vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, {})
        -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        -- vim.keymap.set('n', 'gr', builtin.lsp_references,
        --     { noremap = true, silent = true })
        -- vim.keymap.set('n', 'gd', builtin.lsp_definitions,
        --     { noremap = true, silent = true })
        -- vim.api.nvim_set_keymap(
        --     "n",
        --     "<leader>fb",
        --     ":Telescope file_browser<CR>",
        --     { noremap = true }
        -- )
    end,
}
