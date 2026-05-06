vim.g.mapleader = " "

local keymap = vim.keymap

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Tabs
keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "[T]ab [N]ew", silent = true })
keymap.set("n", "<S-h>", ":tabprevious<CR>", { desc = "Previous tab", silent = true })
keymap.set("n", "<S-l>", ":tabnext<CR>", { desc = "Next tab", silent = true })
keymap.set("n", "<C-Left>", ":-tabmove<CR>", { desc = "Move tab left", silent = true })
keymap.set("n", "<C-Right>", ":+tabmove<CR>", { desc = "Move tab right", silent = true })

-- Splits
keymap.set("n", "<leader>sh", ":split<CR><C-w>w", { desc = "[S]plit [H]orizontal", silent = true })
keymap.set("n", "<leader>sv", ":vsplit<CR><C-w>w", { desc = "[S]plit [V]ertical", silent = true })

-- Resize window
keymap.set("n", "<C-A-h>", "5<C-w><", { desc = "Decrease window width" })
keymap.set("n", "<C-A-j>", "5<C-w>-", { desc = "Decrease window height" })
keymap.set("n", "<C-A-k>", "5<C-w>+", { desc = "Increase window height" })
keymap.set("n", "<C-A-l>", "5<C-w>>", { desc = "Increase window width" })

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "[N]o [H]ighlight", silent = true })

-- Delete without yank
keymap.set("n", "x", '"_x', { desc = "Delete character (no yank)" })

-- Save / quit
keymap.set("n", "<leader>w", ":w<CR>", { desc = "[W]rite file", silent = true })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "[Q]uit", silent = true })
keymap.set("n", "<leader>Q", ":qa<CR>", { desc = "[Q]uit all", silent = true })

-- Make
keymap.set("n", "<leader>mb", ":!make<CR>", { desc = "[M]ake [B]uild", silent = true })
keymap.set("n", "<leader>mx", ":!chmod +x %<CR>", { desc = "[M]ake e[X]ecutable", silent = true })

-- Format with conform or LSP fallback
keymap.set("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "[F]ormat buffer" })

-- Copy / paste with wl-copy / wl-paste (Wayland)
keymap.set("n", "<leader>y", ":%w !wl-copy<CR><CR>", { desc = "[Y]ank file to clipboard", silent = true })
keymap.set("n", "<leader>p", ":r !wl-paste<CR><CR>", { desc = "[P]aste from clipboard", silent = true })

-- Insert mode navigation
keymap.set("i", "<C-f>", "<Right>", { desc = "Move cursor right" })
keymap.set("i", "<C-b>", "<Left>", { desc = "Move cursor left" })
keymap.set("i", "<C-e>", "<End>", { desc = "Move cursor to end" })
keymap.set("i", "<C-a>", "<Home>", { desc = "Move cursor to home" })
