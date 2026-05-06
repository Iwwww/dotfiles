-- =============================================================================
-- Snippet: Autocommands
-- Source: kickstart.nvim (init.lua, строки ~165-200) + lua-guide
-- Scope: Паттерны создания автокоманд в Neovim
-- Note: Всегда используем vim.api.nvim_create_autocmd + nvim_create_augroup
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. Подсветка при копировании (yank)
-- Source: kickstart.nvim
-- -----------------------------------------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- -----------------------------------------------------------------------------
-- 2. Автоформатирование на сохранение (через conform.nvim)
-- Source: tjdevries/config.nvim (lua/custom/autoformat.lua)
-- -----------------------------------------------------------------------------
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

-- -----------------------------------------------------------------------------
-- 3. Настройки для конкретных типов файлов
-- Source: tjdevries/config.nvim (after/ftplugin/*.lua)
-- -----------------------------------------------------------------------------
-- Пример: lua/after/ftplugin/lua.lua
-- vim.opt_local.shiftwidth = 2
-- vim.opt_local.expandtab = true

-- Или через autocmd:
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("kickstart-filetype", { clear = true }),
  pattern = "lua",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- -----------------------------------------------------------------------------
-- 4. LspAttach: buffer-local keymaps и capabilities override
-- Source: kickstart.nvim (строки ~400-500)
-- -----------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local buf = event.buf

    -- Пример: отключить semantic tokens для определённого языка
    -- if vim.bo[buf].filetype == "lua" then
    --   client.server_capabilities.semanticTokensProvider = nil
    -- end

    -- Пример: override server capabilities из конфигурации
    -- if settings.server_capabilities then
    --   for k, v in pairs(settings.server_capabilities) do
    --     if v == vim.NIL then v = nil end
    --     client.server_capabilities[k] = v
    --   end
    -- end
  end,
})

-- -----------------------------------------------------------------------------
-- 5. User event: реакция на события плагинов
-- Source: mini.nvim (mini.diff пример для statusline)
-- -----------------------------------------------------------------------------
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "MiniDiffUpdated",
--   callback = function(data)
--     local summary = vim.b[data.buf].minidiff_summary
--     -- обновить statusline или что-то ещё
--   end,
-- })
