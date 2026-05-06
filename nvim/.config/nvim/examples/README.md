# Neovim Reference Library

Сборник разобранных паттернов и минимальных примеров из авторитетных репозиториев Neovim-конфигураций. Используется для few-shot prompting при настройке Neovim.

## Структура

| Путь | Описание |
|------|----------|
| `kickstart_reference.lua` | Полный `init.lua` из [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) (для контекста) |
| `tj_reference.lua` | Ключевые сниппеты из [tjdevries/config.nvim](https://github.com/tjdevries/config.nvim) |
| `minimal/init.lua` | 40-строчный минимальный старт с `lazy.nvim` |
| `minimal/lsp_only.lua` | Минимальная конфигурация только для LSP |
| `minimal/plugin_spec.lua` | Минимальный рабочий пример spec `lazy.nvim` |
| `snippets/01_bootstrap.lua` | Инициализация `lazy.nvim` |
| `snippets/02_options.lua` | `vim.opt`, globals, clipboard, undofile |
| `snippets/03_keymaps.lua` | `vim.keymap.set` с `desc`, which-key integration |
| `snippets/04_lsp.lua` | Mason + lspconfig + cmp (полный блок) |
| `snippets/05_telescope.lua` | Telescope + extensions + keymaps |
| `snippets/06_treesitter.lua` | Treesitter + ensure_installed + textobjects |
| `snippets/07_cmp.lua` | nvim-cmp sources + mapping + luasnip |
| `snippets/08_git.lua` | gitsigns или mini.git |
| `snippets/09_ui.lua` | Цветовая схема, статуслайн, tabline |
| `snippets/10_autocmds.lua` | `vim.api.nvim_create_autocmd` |
| `snippets/11_mini.lua` | Примеры `mini.nvim` плагинов |

## Источники

### 1. kickstart.nvim
- **Репозиторий**: https://github.com/nvim-lua/kickstart.nvim
- **Файл**: `init.lua`
- **Коммит**: `master` (на момент сбора)
- **Что извлечено**:
  - Bootstrap `lazy.nvim`
  - Формат spec плагина (`opts`, `keys`, `dependencies`, `config`)
  - Mason + `nvim-lspconfig` setup (Neovim 0.11+ с `vim.lsp.config` и `vim.lsp.enable`)
  - `blink.cmp` (современная замена nvim-cmp)
  - Telescope + extensions
  - Treesitter с автоматической установкой парсеров
  - Which-key / встроенные keymaps
  - `conform.nvim` для автоформатирования

### 2. tjdevries/config.nvim
- **Репозиторий**: https://github.com/tjdevries/config.nvim
- **Файлы**:
  - `init.lua` — bootstrap lazy.nvim с `import = "custom/plugins"`
  - `lua/custom/plugins/lsp.lua` — полная LSP настройка через `vim.lsp.enable()` (Neovim 0.11+)
  - `lua/custom/plugins/mini.lua` — примеры mini.ai, mini.surround, mini.hipatterns
  - `lua/custom/plugins/completion.lua` — spec для nvim-cmp
  - `lua/custom/completion.lua` — детальная настройка nvim-cmp + luasnip
  - `lua/custom/autoformat.lua` — conform.nvim с автоформатом на сохранение
  - `lua/custom/plugins/treesitter.lua` — spec для nvim-treesitter
- **Что извлечено**:
  - Структура директорий (`lua/custom/`, `plugin/`, `after/`)
  - Примеры кастомных плагинов из `lua/custom/plugins/`
  - Современный LSP setup через `vim.lsp.config()` и `vim.lsp.enable()`
  - Гибкая настройка Mason с фильтрацией `manual_install`
  - nvim-cmp с lspkind, tailwindcss-colorizer-cmp, supermaven

### 3. mini.nvim
- **Репозиторий**: https://github.com/nvim-mini/mini.nvim
- **Файлы**:
  - `readmes/mini-pick.md`
  - `readmes/mini-files.md`
  - `readmes/mini-git.md`
  - `readmes/mini-statusline.md`
  - `readmes/mini-diff.md`
  - `readmes/mini-icons.md`
- **Что извлечено**:
  - Минимальные примеры замены популярных плагинов (`mini.pick`, `mini.files`, `mini.git`, `mini.statusline`, `mini.diff`)
  - Паттерн инициализации mini-плагинов через `require('mini.xxx').setup(opts)`
  - Использование `mini.icons` вместо `nvim-web-devicons`

### 4. lazy.nvim
- **Репозиторий**: https://github.com/folke/lazy.nvim
- **Документация**: `:help lazy.nvim-🔌-plugin-spec`
- **Что извлечено**:
  - Спецификация формата spec (`name`, `dir`, `url`, `dependencies`, `opts`, `config`, `build`, `event`, `ft`, `keys`, `priority`, `enabled`, `cond`, `import`)

### 5. Официальная документация Neovim
- **Lua Guide**: https://neovim.io/doc/user/lua-guide.html (`:help lua-guide`)
- **Что извлечено**:
  - Базовые паттерны Lua в Neovim (`vim.opt`, `vim.o`, `vim.g`, `vim.keymap.set`, `vim.api.nvim_create_autocmd`)
  - Современные подходы к настройке опций

## Правила использования

> При настройке нового плагина смотри в `snippets/XX_*.lua`, найди похожий паттерн, скопируй и адаптируй.

1. **Не копируй конфиги целиком**. Каждый сниппет в `snippets/` — изолированный, самодостаточный паттерн.
2. **Каждый сниппет — рабочий код**. Если это spec — он возвращает таблицу. Если это options — чистый `vim.opt`.
3. **Актуальность**: Используется только современный API Neovim 0.10+.
