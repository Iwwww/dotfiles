local builtin = require('telescope.builtin')
local previewers = require("telescope.previewers")

local is_image = function(filepath)
    print(filepath)
    local image_extensions = { 'png', 'jpg' } -- Supported image formats
    local split_path = vim.split(filepath:lower(), '.', { plain = true })
    local extension = split_path[#split_path]
    return vim.tbl_contains(image_extensions, extension)
end

-- Ignore files bigger than a threshold
local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then return end
        if stat.size > 100000 and not is_image(filepath) then
            return
        else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
    end)
end

require("telescope").setup {
    defaults = {
        -- Use terminal image viewer to preview images
        -- require catimg
        preview = {
            buffer_previewer_maker = new_maker,
            mime_hook = function(filepath, bufnr, opts)
                if is_image(filepath) then
                    local term = vim.api.nvim_open_term(bufnr, {})
                    local function send_output(_, data, _)
                        for _, d in ipairs(data) do
                            vim.api.nvim_chan_send(term, d .. '\r\n')
                        end
                    end
                    vim.fn.jobstart(
                        {
                            'catimg', filepath -- Terminal image viewer command
                        },
                        { on_stdout = send_output, stdout_buffered = true, pty = true })
                else
                    require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid,
                        "Binary cannot be previewed")
                end
            end
        },
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>) actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                -- ["<C-h>"] = "which_key"
            }
        }
    },
    pickers = {
        find_files = {
            theme = 'dropdown'
        }
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
                ["i"] = {
                    -- your custom insert mode mappings
                },
                ["n"] = {
                    -- your custom normal mode mappings
                },
            },
        },
    },
}

require("telescope").load_extension "file_browser"
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', 'gR', builtin.lsp_references, {})
vim.keymap.set('n', 'gD', builtin.lsp_definitions, {})
vim.api.nvim_set_keymap(
    "n",
    "<space>fb",
    ":Telescope file_browser<CR>",
    { noremap = true }
)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
