local status, color_picker = pcall(require, 'color-picker')
if (not status) then return end

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<A-c>", "<cmd>PickColor<cr>", opts)
vim.keymap.set("i", "<A-c>", "<cmd>PickColorInsert<cr>", opts)

vim.keymap.set("n", "<leader>ccr", "<cmd>ConvertHEXandRGB<cr>", opts)
vim.keymap.set("n", "<leader>cch", "<cmd>ConvertHEXandHSL<cr>", opts)

color_picker.setup({ -- for changing icons & mappings
	["icons"] = { "ﱢ", "" },
	-- ["icons"] = { "ﮊ", "" },
	-- ["icons"] = { "", "ﰕ" },
	-- ["icons"] = { "", "" },
	-- ["icons"] = { "", "" },
	-- ["icons"] = { "ﱢ", "" },
	["border"] = "rounded", -- none | single | double | rounded | solid | shadow
	["keymap"] = { -- mapping example:
		["U"] = "<Plug>ColorPickerSlider5Decrease",
		["u"] = "<Plug>ColorPickerSlider5Increase",
	},
	["background_highlight_group"] = "Normal", -- default
	["border_highlight_group"] = "FloatBorder", -- default
  ["text_highlight_group"] = "Normal", --default
})

vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
