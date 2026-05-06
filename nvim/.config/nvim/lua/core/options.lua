local options = {
  -- Encoding
  encoding = "utf-8",
  fileencoding = "utf-8",

  -- Numbers
  relativenumber = true,
  number = true,

  -- UI
  cursorline = true,
  title = true,
  showcmd = true,
  laststatus = 3,
  cmdheight = 1,
  scrolloff = 10,
  signcolumn = "yes",
  termguicolors = true,
  background = "dark",

  -- Tabs & indentation
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  autoindent = true,
  smartindent = true,
  smarttab = true,
  breakindent = true,

  -- Line wrapping
  wrap = true,

  -- Search
  ignorecase = true,
  smartcase = true,
  hlsearch = true,

  -- Splits
  splitright = true,
  splitbelow = true,

  -- Backspace
  backspace = "indent,eol,start",

  -- Clipboard (requires wl-clipboard on Wayland or xclip/xsel on X11)
  clipboard = "unnamedplus",

  -- Undo
  undofile = true,

  -- Disable swap/backup
  swapfile = false,
  backup = false,
  writebackup = false,

  -- Performance
  updatetime = 250,
  timeoutlen = 300,

  -- Completion
  completeopt = "menu,menuone,noselect",

  -- Command line
  wildmenu = true,
  inccommand = "split",

  -- Shell
  shell = "zsh",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Globals
vim.g.have_nerd_font = true

-- Fix .NET LSPs (marksman, etc.) on NixOS — missing libicu
vim.env.DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = "1"
