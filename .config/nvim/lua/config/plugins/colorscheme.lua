return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
      })

      -- setup must be called before loading
      vim.cmd("colorscheme kanagawa-lotus")
    end,
  },
}
-- return {
--   {
--     "bluz71/vim-nightfly-guicolors",
--     priority = 1000,
--     config = function()
--       vim.cmd([[colorscheme tokyonight]])
--     end,
--   },
--   {
--     "folke/tokyonight.nvim",
--     priority = 1000, -- make sure to load this before all the other start plugins
--     config = function()
--       require("tokyonight").setup({
--         style = "moon",
--         light_style = "day", -- The theme is used when the background is set to light
--         transparent = false, -- Enable this to disable setting the background color
--         terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
--         styles = {
--           -- Style to be applied to different syntax groups
--           -- Value is any valid attr-list value for `:help nvim_set_hl`
--           comments = { italic = true },
--           keywords = { italic = true },
--           functions = { bold = true },
--           variables = {},
--           -- Background styles. Can be "dark", "transparent" or "normal"
--           sidebars = "dark",
--           floats = "dark",
--         },
--         sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
--         day_brightness = 0.1, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
--         hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
--         dim_inactive = false, -- dims inactive windows
--         lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
--         on_colors = function(colors)
--           colors.hint = colors.orange
--           colors.error = "#f00000"
--         end,
--       })
--     end,
--   },
-- }
