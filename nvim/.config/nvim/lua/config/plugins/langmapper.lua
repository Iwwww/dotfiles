return {
  "Wansmer/langmapper.nvim",
  -- only relevant while typing; autoremap() is not in use, so no eager load needed
  event = "InsertEnter",
  config = function()
    require("langmapper").setup({--[[ your config ]]
    })
  end,
}
