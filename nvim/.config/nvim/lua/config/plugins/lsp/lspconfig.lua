return {
  "neovim/nvim-lspconfig",
  -- loaded just after the first render (VeryLazy = User event fired on
  -- vim.schedule right after UIEnter). First frame shows the file without the
  -- LSP stack; vim.lsp.enable then retro-attaches to the already-open buffer
  -- via doautoall FileType, and handles every buffer opened afterwards.
  event = { "VeryLazy" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- make mason-installed LSP binaries available regardless of when mason.nvim
    -- loads (mason prepends its bin dir to PATH on setup; we do it here too so the
    -- availability check below and LSP attach never depend on mason's load timing)
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    if vim.fn.isdirectory(mason_bin) == 1 and vim.env.PATH:find(mason_bin, 1, true) == nil then
      vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
    end

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    local opts = { noremap = true, silent = true }
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰄵 " }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- server_name -> binary that mason/system provides on PATH.
    -- Only used to decide whether to enable a server this session.
    local BIN = {
      pyright = "pyright-langserver",
      clangd = "clangd",
      ts_ls = "typescript-language-server",
      jsonls = "vscode-json-language-server",
      cssls = "vscode-css-language-server",
      html = "vscode-html-language-server",
      marksman = "marksman",
      svelte = "svelte-language-server",
      prismals = "prisma-language-server",
      graphql = "graphql-language-server",
      emmet_ls = "emmet-language-server",
      bashls = "bash-language-server",
      lua_ls = "lua-language-server",
      cmake = "cmake-language-server",
      jinja_lsp = "jinja_language_server",
      sqlls = "sql-language-server",
      arduino_language_server = "arduino-language-server",
    }

    local servers = {}

    local function cfg(name, overrides)
      -- Merge user overrides into the server's built-in config (defaults preserved).
      vim.lsp.config(name, overrides)
      table.insert(servers, name)
    end

    -- configure html server
    cfg("html", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure typescript server with plugin
    cfg("ts_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure css server
    cfg("cssls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure marksman server for markdown
    cfg("marksman", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure svelte server
    cfg("svelte", {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            if client.name == "svelte" then
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
            end
          end,
        })
      end,
    })

    -- configure prisma orm server
    cfg("prismals", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure graphql language server
    cfg("graphql", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    -- configure emmet language server
    cfg("emmet_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    -- configure python server
    cfg("pyright", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure json server
    cfg("jsonls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure bash server
    cfg("bashls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure clangd server
    cfg("clangd", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure arduino-language-server server (not in mason registry; install via pacman)
    local MY_FQBN = "arduino:avr:nano"
    cfg("arduino_language_server", {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = {
        "arduino-language-server",
        "-cli-config",
        "/home/mikhail/.arduino15/arduino-cli.yaml",
        "-fqbn",
        MY_FQBN,
      },
    })

    -- configure lua server (with special settings)
    cfg("lua_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files (replace, not merge, the default list)
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- configure cmake-language-server server
    cfg("cmake", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure jinja server
    cfg("jinja_lsp", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure SQL server
    cfg("sqlls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Enable only the servers whose binary is present in PATH this session, so
    -- we never get "Spawning language server ... failed" warnings for servers
    -- that mason has not installed yet. mason-lspconfig's automatic_enable
    -- (setup_handlers) enables each server the moment mason installs it.
    local enabled = {}
    for _, name in ipairs(servers) do
      local bin = BIN[name]
      if (not bin) or vim.fn.executable(bin) == 1 then
        table.insert(enabled, name)
      end
    end
    vim.lsp.enable(enabled)
  end,
}
