return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- LSP Attach autocmd for keymaps and features
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gr", "<cmd>Telescope lsp_references<CR>", "Show [R]eferences")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("gd", "<cmd>Telescope lsp_definitions<CR>", "[G]oto [d]efinition")
        map("gi", "<cmd>Telescope lsp_implementations<CR>", "[G]oto [I]mplementation")
        map("gt", "<cmd>Telescope lsp_type_definitions<CR>", "[G]oto [T]ype Definition")
        map("<leader>ca", vim.lsp.buf.code_action, "Code [A]ction", { "n", "x" })
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show Buffer [D]iagnostics")
        map("<leader>d", vim.diagnostic.open_float, "Show Line [D]iagnostic")
        map("[d", function()
          vim.diagnostic.jump({ count = -1, float = true })
        end, "Previous [D]iagnostic")
        map("]d", function()
          vim.diagnostic.jump({ count = 1, float = true })
        end, "Next [D]iagnostic")
        map("K", function()
          vim.lsp.buf.hover({ max_width = 80, border = "rounded" })
        end, "Hover Documentation")
        map("<leader>rs", ":LspRestart<CR>", "[R]e[start] LSP")

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Document highlight
        if client and client:supports_method("textDocument/documentHighlight", event.buf) then
          local hl_group = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = hl_group,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = hl_group,
            callback = vim.lsp.buf.clear_references,
          })
        end

        -- Inlay hints toggle
        if client and client:supports_method("textDocument/inlayHint", event.buf) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })

    -- Diagnostic signs and config
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      virtual_text = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "if_many",
      },
    })

    -- Capabilities from nvim-cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    vim.lsp.config("*", { capabilities = capabilities })

    -- Server configurations
    ---@type table<string, vim.lsp.Config>
    local servers = {
      pyright = {},
      ts_ls = {},
      html = {},
      cssls = {},
      tailwindcss = {},
      marksman = {},
      jsonls = {},
      bashls = {},
      clangd = {},
      cmake = {},
      sqlls = {},
      lua_ls = {
        on_init = function(client)
          client.server_capabilities.documentFormattingProvider = false
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
              path ~= vim.fn.stdpath("config")
              and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
            then
              return
            end
          end
          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
            workspace = {
              checkThirdParty = false,
              library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
                "${3rd}/luv/library",
                "${3rd}/busted/library",
              }),
            },
          })
        end,
        settings = { Lua = { format = { enable = false } } },
      },
    }

    -- marksman: ставь через nix (pkgs.marksman), Mason-бинарник падает на NixOS
    if vim.fn.executable("marksman") == 1 then
      servers["marksman"] = {}
    end

    -- cmake-language-server: на NixOS лучше через nix (pkgs.cmake-language-server)
    if vim.fn.executable("cmake-language-server") == 1 then
      servers["cmake"] = {}
    else
      servers["cmake"] = nil
    end

    -- Jinja LSP (если установлен в системе)
    if vim.fn.executable("jinja-lsp") == 1 then
      servers["jinja_lsp"] = {}
    end

    -- Apply configs and enable servers
    for name, config in pairs(servers) do
      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    end
  end,
}
