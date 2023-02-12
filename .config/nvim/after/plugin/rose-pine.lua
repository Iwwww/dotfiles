local status, rose = pcall(require, "rose-pine")
if (not status) then return end

rose.setup({
  --- @usage 'main' | 'moon'
  dark_variant = 'moon',
  bold_vert_split = false,
  dim_nc_background = false,
  disable_background = TRANSPARENT,
  -- disable_float_background = TRANSPARENT,
  disable_italics = false,

  --- @usage string hex value or named color from rosepinetheme.com/palette
  groups = {
    background = 'base',
    panel = 'surface',
    border = 'highlight_med',
    comment = 'muted',
    link = 'iris',
    punctuation = 'subtle',

    error = 'love',
    hint = 'iris',
    info = 'foam',
    warn = 'gold',

    headings = {
      h1 = 'iris',
      h2 = 'foam',
      h3 = 'rose',
      h4 = 'gold',
      h5 = 'pine',
      h6 = 'foam',
    },
    -- or set all headings at once
    -- headings = 'subtle'
  },

  -- Change specific vim highlight groups
	highlight_groups = {
		ColorColumn = { bg = 'rose' }
	}
})

vim.cmd('colorscheme rose-pine')

-- TRANSPARENT
if TRANSPARENT then
  vim.cmd('highlight Normal guifg=none guibg=none')
  vim.cmd('highlight TabLine guifg=none guibg=none')
  vim.cmd('highlight TabLineFill guifg=none guibg=none')
  vim.cmd('highlight BufferVisible guifg=none guibg=none')
  vim.cmd('highlight lualine_c_normal guibg=none')
  vim.cmd('highlight lualine_c_inactive guibg=none')
  vim.cmd('highlight lualine_c_insert guibg=none')
  vim.cmd('highlight lualine_c_normal guibg=none')
  vim.cmd('highlight lualine_c_replace guibg=none')
  vim.cmd('highlight lualine_c_visual guibg=none')
  vim.cmd('highlight Folded guibg=none')
end
