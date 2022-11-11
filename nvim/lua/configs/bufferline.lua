local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

bufferline.setup {
  options = {
    mode = "tabs", -- set to "tabs" to only show tabpages instead
    separator_style = 'slant',
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,

   -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or ""
      -- disable display warnings
      if level:match("warning") then
        return ''
      end

      return " " .. icon .. count
    end
   },
}
