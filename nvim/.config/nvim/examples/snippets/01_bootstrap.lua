-- =============================================================================
-- Snippet: Bootstrap lazy.nvim
-- Source: kickstart.nvim (init.lua, строки ~225-235)
-- Scope: Инициализация менеджера плагинов lazy.nvim
-- Note: Используем vim.uv.fs_stat (Neovim 0.10+) вместо vim.loop
-- =============================================================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "--branch=stable", lazyrepo, lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Загрузка плагинов
-- Вариант A: из списка (inline)
require("lazy").setup({
  -- плагины здесь
})

-- Вариант B: из папки lua/plugins/ (как в tjdevries/config.nvim)
-- require("lazy").setup("plugins", {
--   change_detection = { notify = false },
-- })

-- Вариант C: импорт модуля с плагинами
-- require("lazy").setup({ import = "custom/plugins" }, {
--   change_detection = { notify = false },
-- })
