-- =============================================================================
-- Snippet: Vim Options
-- Source: kickstart.nvim (init.lua, строки ~45-105) + lua-guide
-- Scope: Базовые опции редактора: номера строк, clipboard, отступы и т.д.
-- Note: vim.o для скаляров, vim.opt для таблиц/списков
-- =============================================================================

-- Leader keys (должны быть установлены ДО загрузки плагинов)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true -- или false, если нет Nerd Font

-- Нумерация строк
vim.o.number = true
-- vim.o.relativenumber = true -- опционально

-- Мышь (полезно для ресайза сплитов)
vim.o.mouse = "a"

-- Не показывать режим (есть в статуслайне)
vim.o.showmode = false

-- Синхронизация с системным буфером обмена
-- Откладываем после UiEnter для ускорения старта
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- Отступы при переносе строк
vim.o.breakindent = true

-- Сохранять undo историю между сессиями
vim.o.undofile = true

-- Поиск
vim.o.ignorecase = true
vim.o.smartcase = true

-- Знак-колонка всегда видна (чтобы текст не прыгал)
vim.o.signcolumn = "yes"

-- Тайминги
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Сплиты
vim.o.splitright = true
vim.o.splitbelow = true

-- Отображение пробелов
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Предпросмотр замен
vim.o.inccommand = "split"

-- Подсветка текущей строки
vim.o.cursorline = true

-- Отступы от края экрана
vim.o.scrolloff = 10

-- Диалог подтверждения при выходе с несохранёнными изменениями
vim.o.confirm = true

-- Дополнительные globals
-- vim.g.loaded_netrw = 1        -- отключить netrw
-- vim.g.loaded_netrwPlugin = 1
