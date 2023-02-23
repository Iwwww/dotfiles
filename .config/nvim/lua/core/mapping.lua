local keymap = vim.keymap

-- Do not yank with x
--keymap.set('n', 'x', '_x')

-- Tabs and split
keymap.set('n', 'te', ':tabedit<CR>', { silent =true })
keymap.set('n', 'ss', ':split<CR><C-w>w', { silent =true })
keymap.set('n', 'sv', ':vsplit<CR><C-w>w', { silent =true })

-- Movement
keymap.set('n', '<C-Tab>', '<C-w>w')
keymap.set('n', '<C-h>', '<C-w>h')
keymap.set('n', '<C-j>', '<C-w>j')
keymap.set('n', '<C-k>', '<C-w>k')
keymap.set('n', '<C-l>', '<C-w>l')

keymap.set('n', '<S-h>', ':tabprevious<CR>', { silent = true })
keymap.set('n', '<S-l>', ':tabnext<CR>', { silent = true })
keymap.set('n', '<C-Right>', ':+tabmove<CR>', { silent = true })
keymap.set('n', '<C-Left>', ':-tabmove<CR>', { silent = true })

-- Resize window
keymap.set('n', '<C-A-h>', '5<C-w><')
keymap.set('n', '<C-A-j>', '5<C-w>-')
keymap.set('n', '<C-A-k>', '5<C-w>+')
keymap.set('n', '<C-A-l>', '5<C-w>>')

vim.api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-c>', ':noh<CR>:echomsg ""<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<ESC>:w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-q>', ':q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':NeoTreeShowToggle<CR>', { noremap = true, silent = true })

-- make executable
vim.api.nvim_set_keymap('n', '<leader>mx', ":!chmod +x %<CR>", { silent = true })
-- run executable
vim.api.nvim_set_keymap('n', '<leader>me', "<C-c>:split<CR>:te ./%:t<CR>i", { silent = true })

vim.api.nvim_set_keymap('n', '<A-f>', ':lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })
