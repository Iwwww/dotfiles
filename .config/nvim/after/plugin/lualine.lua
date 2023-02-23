local status, lualine = pcall(require, 'lualine')
if (not status) then return end

local progress = {'progress'}
local branch = {'branch'}
local diff = {'diff'}
local diagnostic = {'diagnostic'}
if TRANSPARENT then
    mode = {'mode', color={bg='none'}}
    progress = {'progress', color={bg='none'}}
    branch = {'branch', color={bg='none'}}
    diff = {'diff', color={bg='none'}}
    diagnostic = {'diagnostic', color={bg='none'}}
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {branch, diff, diagnostic},
    lualine_c = {'filename'},
    lualine_x = {'encoding'},
    lualine_y = {progress},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
