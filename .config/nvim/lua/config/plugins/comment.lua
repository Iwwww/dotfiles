return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        -- import comment plugin safely
        local comment = require("Comment")

        local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

        -- enable comment
        comment.setup({
            ---Add a space b/w comment and the line
            padding = true,
            ---Whether the cursor should stay at its position
            sticky = true,
            ---Lines to be ignored while (un)comment
            ignore = nil,
            ---LHS of toggle mappings in NORMAL mode
            toggler = {
                ---Line-comment toggle keymap
                line = '<leader>/',
                ---Block-comment toggle keymap
                block = 'gc',
            },
            ---LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                ---Line-comment keymap
                line = '<leader>/',
                ---Block-comment keymap
                -- block = 'gc',
            },
            ---LHS of extra mappings
            extra = {
                ---Add comment on the line above
                above = 'gcO',
                ---Add comment on the line below
                below = 'gco',
                ---Add comment at the end of line
                eol = '<leader>?',
            },
            ---Enable keybindings
            ---NOTE: If given `false` then the plugin won't create any mappings
            mappings = {
                ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                basic = true,
                ---Extra mapping; `gco`, `gcO`, `gcA`
                extra = true,
            },
            -- for commenting tsx and jsx files
            pre_hook = ts_context_commentstring.create_pre_hook(),
            ---Function to call after (un)comment
            post_hook = nil,
        })
    end,
}