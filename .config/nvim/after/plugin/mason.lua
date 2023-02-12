local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

lspconfig.setup {
    ensure_installed = {"clangd"}
}

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["rust_analyzer"] = function ()
        require("rust-tools").setup {}
    end
}

local MY_FQBN = "arduino:avr:nano"
require'lspconfig'.arduino_language_server.setup {
    cmd = {
        "arduino-language-server",
        "-cli-config", "/path/to/arduino-cli.yaml",
        "-fqbn",
        MY_FQBN
    }
}

require'lspconfig'.pyright.setup{
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
            }
        }
    },
    single_file_support = true
}

require'lspconfig'.jedi_language_server.setup{
    cmd = { "jedi-language-server" },
    filetypes = { "python" },
    single_file_support = true
}

-- require'lspconfig'.shfmt.setup{}

-- local default_config = {"shfmt"}
-- for k, v in pairs(default_config) do
--     require(v).setup({})
-- end
