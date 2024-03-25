return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        -- import nvim-autopairs
        local autopairs = require("nvim-autopairs")

        -- configure autopairs
        autopairs.setup({
            check_ts = true,                                 -- enable treesitter
            ts_config = {
                lua = { "string" },                          -- don't add pairs in lua string treesitter nodes
                javascript = { "template_string" },          -- don't add pairs in javscript template_string treesitter nodes
                java = false,                                -- don't check treesitter on java
            },
            enable_check_bracket_line = true,                -- Don't add pairs if it already have a close pairs in same line
            disable_filetype = { "TelescopePrompt", "vim" }, --
            enable_afterquote = false,                       -- add bracket pairs after quote
            enable_moveright = true
        })

        -- import nvim-autopairs completion functionality
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        -- import nvim-cmp plugin (completions plugin)
        local cmp = require("cmp")

        -- make autopairs and completion work together
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        -- If you want insert `(` after select function or method item
        local Rule = require('nvim-autopairs.rule')
        local npairs = require('nvim-autopairs')

        npairs.add_rules {

            -- before   insert  after
            --  (|)     ( |)	( | )
            Rule(' ', ' ')
                :with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    return vim.tbl_contains({ '()', '[]', '{}' }, pair)
                end),
            Rule('( ', ' )')
                :with_pair(function() return false end)
                :with_move(function(opts)
                    return opts.prev_char:match('.%)') ~= nil
                end)
                :use_key(')'),
            Rule('{ ', ' }')
                :with_pair(function() return false end)
                :with_move(function(opts)
                    return opts.prev_char:match('.%}') ~= nil
                end)
                :use_key('}'),
            Rule('[ ', ' ]')
                :with_pair(function() return false end)
                :with_move(function(opts)
                    return opts.prev_char:match('.%]') ~= nil
                end)
                :use_key(']'),
            --[===[
            arrow key on javascript
                Before 	Insert    After
                (item)= 	> 	    (item)=> { }
            --]===]
            Rule('%(.*%)%s*%=>$', ' {  }', { 'typescript', 'typescriptreact', 'javascript' })
                :use_regex(true)
                :set_end_pair_length(2),
        }
    end,
}
