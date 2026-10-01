local languages = {
  "json",
  "javascript",
  "typescript",
  "tsx",
  "yaml",
  "html",
  "css",
  "prisma",
  "markdown",
  "markdown_inline",
  "svelte",
  "graphql",
  "bash",
  "lua",
  "vim",
  "dockerfile",
  "gitignore",
  "query",
  "c",
  "cpp",
  "python",
}

local filetypes = {
  "lua",
  "markdown",
  "html",
  "javascript",
  "typescript",
  "typescriptreact",
  "javascriptreact",
  "css",
  "scss",
  "svelte",
  "json",
  "jsonc",
  "bash",
  "sh",
  "python",
  "c",
  "cpp",
  "yaml",
  "graphql",
  "prisma",
  "dockerfile",
  "gitignore",
  "vim",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(languages)

      -- Defer parser start until the UI is up so syntax highlighting does not
      -- block first render. We wrap vim.treesitter.start (rather than only
      -- hooking our own FileType autocmd) because the *system* ftplugin
      -- (e.g. ftplugin/markdown.lua) also calls vim.treesitter.start() on
      -- FileType, which would otherwise parse synchronously.
      -- While deferring we still set b:ts_highlight so that nvim's classic
      -- syntax loader (syntax.vim guards on `exists('b:ts_highlight')`) skips
      -- the redundant css/html/markdown syntax files for these buffers.
      local ui_entered = false
      local pending = {}
      local real_start = vim.treesitter.start
      local ft_set = {}
      for _, ft in ipairs(filetypes) do
        ft_set[ft] = true
      end

      local function filetype_of(buf)
        local ok, ft = pcall(function()
          return vim.bo[buf].filetype
        end)
        return ok and ft or ""
      end

      vim.treesitter.start = function(bufnr, lang, opts)
        local buf = (type(bufnr) == "number" and bufnr ~= 0) and bufnr or vim.api.nvim_get_current_buf()
        if not ui_entered and ft_set[filetype_of(buf)] then
          pending[buf] = true
          pcall(function()
            vim.b[buf].ts_highlight = lang or filetype_of(buf)
          end)
          return
        end
        return real_start(bufnr, lang, opts)
      end

      vim.api.nvim_create_autocmd("UIEnter", {
        once = true,
        callback = function()
          ui_entered = true
          for b in pairs(pending) do
            if vim.api.nvim_buf_is_valid(b) then
              real_start(b)
            end
          end
          pending = {}
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          if ui_entered then
            real_start(buf)
          else
            pending[buf] = true
            pcall(function()
              vim.b[buf].ts_highlight = filetype_of(buf)
            end)
          end
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    -- only matters while typing tags
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup({})
    end,
  },
}
