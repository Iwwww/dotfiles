require("neodev").setup({})

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls" },
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function ()
    --     require("rust-tools").setup {}
    -- end
})

-- local api = vim.api

-- -- Define a function to open the definition in a new tab if it's in another file
-- function lsp_definition()
--   local definition = vim.lsp.buf.definition()
--   if definition and definition.uri ~= vim.uri_from_bufnr(0) then
--     vim.api.nvim_command("tabnew")
--     vim.lsp.util.jump_to_location(definition)
--   else
--     vim.lsp.buf.definition()
--   end
-- end

-- Map the function to a key binding
vim.api.nvim_set_keymap("n", "<Leader>gd", "<cmd>lua lsp_definition()<CR>", { noremap = true, silent = true })

-- Map the function to a key binding
vim.api.nvim_set_keymap("n", "<Leader>gd", "<cmd>lua lsp_definition()<CR>",
    { noremap = true, silent = true, desc = "LSP definition" })

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
        { noremap = true, silent = true, buffer = bufnr, desc = "Go to definition" })

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
        { noremap = true, silent = true, buffer = bufnr, desc = "Go to implementation" })

    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --   vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
    vim.keymap.set("n", "<leader>rn", ":IncRename ",
        { noremap = true, silent = true, buffer = bufnr, desc = "Rename" })

    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
        { noremap = true, silent = true, buffer = bufnr, desc = "Code action" })

    vim.keymap.set('n', 'gr', ':lua require"telescope.builtin".lsp_references()<CR>',
        { noremap = true, silent = true, buffer = bufnr, desc = "Go to references" })

    vim.keymap.set('n', '<space>cf', function() vim.lsp.buf.format { async = true } end,
        { noremap = true, silent = true, buffer = bufnr, desc = "Format" })

    -- gd = 'lua require"telescope.builtin".lsp_definitions()',
    -- gi = 'lua require"telescope.builtin".lsp_implementations()',
    -- gr = 'lua require"telescope.builtin".lsp_references()',
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["rust_analyzer"] = function()
        require("rust-tools").setup {}
    end
}

-- require('lspconfig').lua_ls.setup {
--     settings = {
--         Lua = {
--             runtime = {
--                 -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--                 version = 'LuaJIT',
--             },
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = { 'vim' },
--             },
--             workspace = {
--                 -- Make the server aware of Neovim runtime files
--                 library = vim.api.nvim_get_runtime_file("", true),
--             },
--             -- Do not send telemetry data containing a randomized but unique identifier
--             telemetry = {
--                 enable = false,
--             },
--         },
--     },
-- }
--
-- require("lspconfig").clangd.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
--     -- cmd = { "clangd" },
--     cmd = { 'clangd', '--background-index', '--inlay-hints' },
--     log_file = '/tmp/clangd.log',
--     log_level = 5,
-- }
--
--
-- require('lspconfig').pylsp.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     settings = {
--         pylsp = {
--             plugins = {
--                 pycodestyle = {
--                     ignore = { 'W391' },
--                     maxLineLength = 100
--                 }
--             }
--         }
--     }
-- }
--
-- require('lspconfig').pyright.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }
--
-- require 'lspconfig'.bashls.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }
--
-- require'lspconfig'.phpactor.setup{
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }
