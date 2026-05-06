-- =============================================================================
-- TJ DeVries Reference Snippets
-- Source: https://github.com/tjdevries/config.nvim
-- Scope: Ключевые паттерны из реальной production-конфигурации
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. Bootstrap lazy.nvim с импортом папки плагинов
-- Source: init.lua
-- -----------------------------------------------------------------------------
do
  vim.g.mapleader = ","

  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({ import = "custom/plugins" }, {
    change_detection = {
      notify = false,
    },
  })
end

-- -----------------------------------------------------------------------------
-- 2. Современный LSP setup (Neovim 0.11+) через vim.lsp.config / vim.lsp.enable
-- Source: lua/custom/plugins/lsp.lua
-- -----------------------------------------------------------------------------
do
  local spec = {
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        { "folke/lazydev.nvim", ft = "lua", opts = {} },
        { "Bilal2453/luvit-meta", lazy = true },
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "j-hui/fidget.nvim", opts = {} },
        "stevearc/conform.nvim",
      },
      config = function()
        local capabilities = nil
        if pcall(require, "cmp_nvim_lsp") then
          capabilities = require("cmp_nvim_lsp").default_capabilities()
        end

        local servers = {
          bashls = true,
          gopls = {
            manual_install = true,
            settings = {
              gopls = {
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                },
              },
            },
          },
          lua_ls = {
            cmd = { "lua-language-server" },
          },
          rust_analyzer = true,
          pyright = true,
          jsonls = {
            server_capabilities = {
              documentFormattingProvider = false,
            },
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          },
        }

        -- Фильтруем серверы для автоматической установки через Mason
        local servers_to_install = vim.tbl_filter(function(key)
          local t = servers[key]
          if type(t) == "table" then
            return not t.manual_install
          else
            return t
          end
        end, vim.tbl_keys(servers))

        require("mason").setup()
        local ensure_installed = { "stylua", "lua_ls" }
        vim.list_extend(ensure_installed, servers_to_install)
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        -- Глобальные capabilities для всех серверов
        vim.lsp.config("*", {
          capabilities = capabilities,
        })

        -- Конфигурируем и включаем каждый LSP сервер
        for name, config in pairs(servers) do
          if config == true then
            config = {}
          end
          if next(config) ~= nil then
            local lsp_config = vim.tbl_deep_extend("force", {}, config)
            lsp_config.manual_install = nil
            vim.lsp.config(name, lsp_config)
          end
          vim.lsp.enable(name)
        end

        -- LSP Attach: keymaps и override capabilities
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local bufnr = args.buf
            local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

            vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
            vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { buffer = 0 })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
            vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
            vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
            vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
          end,
        })
      end,
    },
  }
  -- В реальном конфиге: return spec
end

-- -----------------------------------------------------------------------------
-- 3. nvim-cmp + luasnip + lspkind (детальная настройка)
-- Source: lua/custom/completion.lua
-- -----------------------------------------------------------------------------
do
  vim.opt.completeopt = { "menu", "menuone", "noselect" }
  vim.opt.shortmess:append("c")

  local cmp = require("cmp")
  local lspkind = require("lspkind")

  lspkind.init({
    symbol_map = {
      Copilot = "",
    },
  })

  cmp.setup({
    sources = {
      { name = "lazydev", group_index = 0 },
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "buffer" },
    },
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-y>"] = cmp.mapping(
        cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        { "i", "c" }
      ),
    },
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body)
      end,
    },
    formatting = {
      fields = { "abbr", "kind", "menu" },
      format = lspkind.cmp_format({
        mode = "symbol_text",
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[api]",
          path = "[path]",
          luasnip = "[snip]",
        },
      }),
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  })
end

-- -----------------------------------------------------------------------------
-- 4. conform.nvim — автоформатирование на сохранение
-- Source: lua/custom/autoformat.lua
-- -----------------------------------------------------------------------------
do
  local conform = require("conform")
  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
    },
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("custom-conform", { clear = true }),
    callback = function(args)
      require("conform").format({
        bufnr = args.buf,
        lsp_fallback = true,
        quiet = true,
      })
    end,
  })
end

-- -----------------------------------------------------------------------------
-- 5. mini.nvim — базовая инициализация нескольких модулей
-- Source: lua/custom/plugins/mini.lua
-- -----------------------------------------------------------------------------
do
  local spec = {
    {
      "echasnovski/mini.nvim",
      config = function()
        require("mini.ai").setup()
        require("mini.surround").setup()

        local hipatterns = require("mini.hipatterns")
        hipatterns.setup({
          highlighters = {
            hex_color = hipatterns.gen_highlighter.hex_color(),
          },
        })
      end,
    },
  }
  -- В реальном конфиге: return spec
end
