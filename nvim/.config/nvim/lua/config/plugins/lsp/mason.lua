return {
    "williamboman/mason.nvim",
    -- lazy-load after the session is idle; auto-installation still runs in-session and
    -- LSP attach (vim.lsp.enable) does not depend on mason
    event = { "VeryLazy" },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- servers for mason to install; automatic_enable then enables each
            -- one (mason-lspconfig setup_handlers equivalent) the moment it lands
            -- in PATH, so lspconfig.lua never warns about a missing binary
            ensure_installed = {
                "pyright",
                "clangd",
                "lua_ls",
                "ts_ls",
                "jsonls",
                "cssls",
                "html",
                "bashls",
                "jinja_lsp",
                "sqlls",
                "emmet_ls",
                "marksman",
                -- cmake-language-server: install via pypi fails in this env
                -- (triggers a startup error + "Press ENTER"); install manually
            },
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as ensure_installed
        })

        mason_tool_installer.setup({
            ensure_installed = {
                -- "prettier", -- prettier formatter
                -- "stylua",   -- lua formatter
                -- "isort",    -- python formatter
                -- "black",    -- python formatter
                -- "pylint",   -- python linter
                -- "eslint_d", -- js linter
            },
        })


        -- mason_lspconfig.setup_handlers {
        --     -- The first entry (without a key) will be the default handler
        --     -- and will be called for each installed server that doesn't have
        --     -- a dedicated handler.
        --     function(server_name) -- default handler (optional)
        --         require("lspconfig")[server_name].setup {}
        --     end,
        -- }
    end,
}
