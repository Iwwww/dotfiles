if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h11"

  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  local alpha = function()
    return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
  end

  vim.g.neovide_transparency = 0.7
  vim.g.transparency = 0.3
  vim.g.neovide_background_color = "#011627" .. alpha()

  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_confirm_quit = false
end
