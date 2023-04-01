local keymap = vim.keymap

vim.g.mapleader = " "

-- Do not yank with x
--keymap.set('n', 'x', '_x')

-- Tabs and split
keymap.set('n', 'te', ':tabedit<CR>', { silent = true })
keymap.set('n', 'ss', ':split<CR><C-w>w', { silent = true })
keymap.set('n', 'sv', ':vsplit<CR><C-w>w', { silent = true })

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

-- Insert mode Movement
-- go forward
vim.api.nvim_set_keymap('i', '<C-f>', '<C-o>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-A-f>', '<ESC>Ea', { noremap = true, silent = true })
-- go backward
vim.api.nvim_set_keymap('i', '<C-b>', '<C-o>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-A-b>', '<C-o>B', { noremap = true, silent = true })

-- Resize window
keymap.set('n', '<C-A-h>', '5<C-w><')
keymap.set('n', '<C-A-j>', '5<C-w>-')
keymap.set('n', '<C-A-k>', '5<C-w>+')
keymap.set('n', '<C-A-l>', '5<C-w>>')

vim.api.nvim_set_keymap('n', '<C-c>', ':noh<CR>:echomsg ""<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<ESC>:w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-q>', ':q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':NeoTreeShowToggle<CR>', { noremap = true, silent = true })

-- make executable
vim.api.nvim_set_keymap('n', '<leader>mx', ":!chmod +x %<CR>", { silent = true })
-- compile with Make
vim.api.nvim_set_keymap('n', '<leader>mb', ":!make<CR>", { silent = true })
-- run with Make
vim.api.nvim_set_keymap('n', '<leader>mr', "<C-c>:split<CR>:te make run<CR>:t<CR>", { silent = true })
-- run executable
vim.api.nvim_set_keymap('n', '<leader>me', "<C-c>:split<CR>:te ./%:t<CR>i", { silent = true })

vim.api.nvim_set_keymap('n', '<A-f>', ':lua vim.lsp.buf.format{ async = true }<CR>', { noremap = true, silent = true })

-- add new line upper current line
vim.api.nvim_set_keymap('n', '<A-CR>', 'O<ESC>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-CR>', '<ESC>O', { noremap = true, silent = true })
