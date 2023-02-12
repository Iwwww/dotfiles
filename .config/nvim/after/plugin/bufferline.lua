local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

bufferline.setup {
  options = {
    mode = "tabs", -- set to "tabs" to only show tabpages instead
    separator_style = {'|', ''},
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = true,
    show_buffer_close_icons = false,
    show_close_icon = true,
    color_icons = true,
   },
}
