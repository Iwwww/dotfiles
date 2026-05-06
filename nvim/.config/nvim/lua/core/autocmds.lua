local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("trim_whitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[ %s/\s\+$//e ]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Check if file changed on disk when gaining focus
autocmd({ "FocusGained", "BufEnter" }, {
  group = augroup("checktime", { clear = true }),
  command = "checktime",
})

-- Resize splits when window is resized
autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  command = "wincmd =",
})
