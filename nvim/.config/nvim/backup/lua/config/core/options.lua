vim.scriptencoding = "utf-8"

-- clipboard
-- vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

local options = {
  encoding = "utf-8",
  fileencoding = "utf-8", -- File-content encoding for the current buffer

  relativenumber = true,
  number = true,

  cursorline = true,
  title = true,
  showcmd = true,
  laststatus = 2,
  backup = false,
  scrolloff = 10,
  cmdheight = 0,

  -- tabs & indentation
  tabstop = 2, -- 4 spaces for tabs (prettier default)
  shiftwidth = 2, -- 4 spaces for indent width
  expandtab = true, -- expand tab to spaces
  autoindent = true, -- copy indent from current line when starting new one
  smartindent = true,

  -- line wrapping
  wrap = true, -- enable line wrapping

  -- search
  ignorecase = true, -- ignore case when searching
  smartcase = true, -- if you include mixed case in your search, assumes you want case-sensitive
  hlsearch = true,
  showmatch = true,

  -- appearance

  -- turn on termguicolors for nightfly colorscheme to work
  -- (have to use iterm2 or any other true color terminal)
  termguicolors = true,
  background = "dark", -- colorschemes that can be light or dark will be made dark
  signcolumn = "yes", -- show sign column so that text doesn't shift

  -- backspace
  backspace = "indent,eol,start", -- allow backspace on indent, end of line or insert mode start position

  -- split windows
  splitright = false, -- split vertical window to the right
  splitbelow = true, -- split horizontal window to the bottom

  -- turn off swapfile
  swapfile = false,

  smarttab = true,
  syntax = "on",
  shell = "zsh",
  inccommand = "split",
  breakindent = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- vim.g.nightflyTransparent = true
