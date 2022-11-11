vim.scriptencoding = 'utf-8'

local options = {
  encoding = 'utf-8',
  fileencoding = 'utf-8',   -- File-content encoding for the current buffer

  number = true,            -- show line numbers
  relativenumber = true,    -- Show the line number relative to the line with the cursor in front of each line
  cursorline = true,        -- highlight the current line
  title = true,
  autoindent = true,
  showcmd = true,
  laststatus = 2,
  backup = false,           -- disabled the creation of backups
  scrolloff = 10,
--    cmdheight = 1,          -- Number of screen lines to use for the command-line

  -- Search
  hlsearch = true,          -- When there is a previous search pattern, highlight all its matches
  ignorecase = true,
  showmatch = true,         -- When a bracket is inserted, briefly jump to the matching one

--    tabstop = 4,            -- Number of spaces that a <Tab> in the file counts for
  shiftwidth = 4,           -- Number of spaces to use for each step of (auto)indent
  ai = true,                 -- Auto indent
  si = true,                 -- Smart indent
  expandtab = true,         -- Use the appropriate number of spaces to insert a <Tab>
  backspace = 'start,eol,indent',
  -- wrap = false,		-- No wrap lines

  smarttab = true,
  syntax = 'on',
  shell = 'fish', inccommand = 'split',
  breakindent = true,

}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.mapleader = " "

vim.cmd('colorscheme base16-circus') -- require base16 plugin

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})

-- Add asterisks
-- vim.opt.formatoptions:append { 'r' }
