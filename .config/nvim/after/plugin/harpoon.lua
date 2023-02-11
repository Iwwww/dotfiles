local status, harpoon = pcall(require, 'harpoon')
if (not status) then return end

harpoon.setup({
  global_settings = {
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = false,

    -- saves the harpoon file upon every change. disabling is unrecommended.
    save_on_change = true,

    -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    enter_on_sendcmd = false,

    -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
    tmux_autoclose_windows = false,

    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = { "harpoon" },

    -- set marks specific to each git branch inside git repository
    mark_branch = false,
  }
})

local keymap = vim.keymap

keymap.set('n', '<leader>ha', ':lua require("harpoon.mark").add_file()<CR>', { silent =true })
-- keymap.set('n', '<leader>hm', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { silent =true })
keymap.set('n', '<leader>hm', ':Telescope harpoon marks<CR>', { silent =true })

-- navigates to files [1-9]
-- using <A-[1-9]>
local function harpoon_swich_mapping()
  for i = 1, 9 do
    keymap.set('n', string.format('<A-%s>', i), string.format(':lua require("harpoon.ui").nav_file(%s)<CR>', i), { silent =true })
  end
end

harpoon_swich_mapping()

-- navigates to next mark
keymap.set('n', '<A-l>', ':lua require("harpoon.ui").nav_next()<CR>', { silent =true })
-- navigates to previous mark
keymap.set('n', '<A-h>', ':lua require("harpoon.ui").nav_prev()<CR>', { silent =true })
