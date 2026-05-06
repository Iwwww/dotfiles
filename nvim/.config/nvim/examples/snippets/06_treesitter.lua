-- =============================================================================
-- Snippet: Treesitter Setup
-- Source: kickstart.nvim (init.lua, строки ~850-920)
-- Scope: Настройка nvim-treesitter с автоматической установкой парсеров
-- Note: Neovim 0.11+ использует branch='main' и require('nvim-treesitter').install()
-- =============================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
      -- Базовые парсеры
      local parsers = {
        "bash", "c", "diff", "html", "lua", "luadoc",
        "markdown", "markdown_inline", "query", "vim", "vimdoc",
      }
      require("nvim-treesitter").install(parsers)

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        if not vim.treesitter.language.add(language) then
          return
        end
        vim.treesitter.start(buf, language)

        -- Folds (опционально)
        -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        -- vim.wo.foldmethod = "expr"

        -- Indentation
        local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil
        if has_indent_query then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      local available_parsers = require("nvim-treesitter").get_available()

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf, filetype = args.buf, args.match
          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          local installed_parsers = require("nvim-treesitter").get_installed("parsers")

          if vim.tbl_contains(installed_parsers, language) then
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            require("nvim-treesitter").install(language):await(function()
              treesitter_try_attach(buf, language)
            end)
          else
            treesitter_try_attach(buf, language)
          end
        end,
      })
    end,
  },

  -- Альтернатива: классический подход с ensure_installed (для стабильной ветки)
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   build = ":TSUpdate",
  --   opts = {
  --     ensure_installed = { "lua", "vim", "vimdoc", "markdown" },
  --     auto_install = true,
  --     highlight = { enable = true },
  --     indent = { enable = true },
  --   },
  --   config = function(_, opts)
  --     require("nvim-treesitter.configs").setup(opts)
  --   end,
  -- },
}
