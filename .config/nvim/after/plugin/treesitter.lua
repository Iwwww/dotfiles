local status, ts = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    'lua',
    'json',
    'css',
    'python',
    'c',
    'cpp',
    'arduino',
  },
  autotag = {
    enable = true,
  }
}

