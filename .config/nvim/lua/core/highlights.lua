local highlight = {
  cursorline = true,
  termguicolors = true,
  winblend = 0,
  wildoptions = 'pum',
  pumblend = 5,
  -- background = 'dark',
}

for k, v in pairs(highlight) do
  vim.opt[k] = v
end

