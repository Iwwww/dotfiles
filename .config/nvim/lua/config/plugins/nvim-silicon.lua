return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  config = function()
    require("silicon").setup({
      -- the font settings with size and fallback font
      font = "JetBrainsMonoNL NFP",
      -- the theme to use, depends on themes available to silicon
      theme = "gruvbox-dark",
      -- the background color outside the rendered os window
      background = "#076678",
      -- a path to a background image
      background_image = nil,
      -- the paddings to either side
      pad_horiz = 50,
      pad_vert = 40,
      -- whether to have the os window rendered with rounded corners
      no_round_corner = false,
      -- whether to put the close, minimize, maximise traffic light controls on the border
      no_window_controls = true,
      -- whether to turn off the line numbers
      no_line_number = false,
      -- with which number the line numbering shall start, the default is 1, but here a
      -- function is used to return the actual source code line number
      line_offset = function(args)
        return args.line1
      end,
      -- the distance between lines of code
      line_pad = 0,
      -- the rendering of tab characters as so many space characters
      tab_width = 4,
      -- with which language the syntax highlighting shall be done, should be a function
      -- that returns either a language name or an extension like ".js"
      language = function()
        return vim.bo.filetype
      end,
      -- if the shadow below the os window should have be blurred
      shadow_blur_radius = 16,
      -- the offset of the shadow in x and y directions
      shadow_offset_x = 8,
      shadow_offset_y = 8,
      -- the color of the shadow
      shadow_color = "#100808",
      -- whether to strip of superfluous leading whitespace
      gobble = true,
      -- a string or function that defines the path to the output image
      output = function()
        print("/home/mikhail/Pictures/screenshots/" .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code" .. ".png")
        return "~/Pictures/screenshots/" .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code" .. ".png"
      end,
      to_clipboard = true,
      command = "silicon",
      window_title = function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
      end,
    })
  end,
}
