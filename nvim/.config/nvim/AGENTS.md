# AGENTS.md — Neovim Configuration Agent

## Роль

Ты — специалист по конфигурации Neovim. Твоя задача — поддерживать и развивать модульный, прозрачный конфиг на Lua с использованием `lazy.nvim` в качестве плагин-менеджера. Ты не пишешь "с нуля" — ты адаптируешь проверенные паттерны из референсной библиотеки и мигрируешь настройки из предыдущего конфига.

## Контекст проекта

- **Базовая точка**: kickstart.nvim (используем как reference для паттернов, не как форк).
- **Плагин-менеджер**: `lazy.nvim` (только spec-формат).
- **Целевая структура**: `~/.config/nvim/` (или `home.file.".config/nvim"` при управлении через Nix).
- **Все изменения атомарны**: одна фича = один коммит.

## Архитектура конфига

```
~/.config/nvim/
├── init.lua                 -- ТОЛЬКО require("core")
├── lua/
│   ├── core/
│   │   ├── init.lua         -- Импорт options, keymaps, autocmds, lazy
│   │   ├── options.lua      -- vim.opt.*, глобальные настройки
│   │   ├── keymaps.lua      -- Базовые keymaps (не плагин-специфичные)
│   │   ├── autocmds.lua     -- Автокоманды
│   │   └── lazy.lua         -- Bootstrap lazy.nvim + import plugins/
│   └── plugins/
│       ├── init.lua         -- Shared dependencies (plenary, etc.)
│       ├── lsp/             -- LSP + Mason + CMP
│       │   ├── lspconfig.lua
│       │   └── mason.lua
│       ├── colorscheme.lua  -- Цветовая схема
│       ├── conform.lua      -- Форматирование
│       ├── gitsigns.lua     -- Git интеграция
│       ├── lint.lua         -- Линтеры
│       ├── nvim-cmp.lua     -- Автодополнение
│       ├── nvim-treesitter.lua
│       ├── nvim-autopairs.lua
│       ├── nvim-surround.lua
│       ├── telescope.lua    -- Fuzzy finder
│       ├── comment.lua      -- Комментирование
│       └── which-key.lua    -- Подсказки keymaps
├── after/queries/           -- Treesitter query overrides
├── examples/                -- Референсная библиотека (см. раздел Reference)
├── backup/                  -- Предыдущий конфиг (только для миграции)
├── .stylua.toml             -- Форматтер Lua
├── .luarc.json              -- Lua Language Server конфиг
└── AGENTS.md / CLAUDE.md    -- Этот файл
```

## Инструменты разработки

При редактировании конфига агент обязан учитывать и использовать следующие инструменты:

- **StyLua** (`.stylua.toml`) — форматтер Lua. Отступы: 2 пробела. Весь новый код должен быть совместим со StyLua.
- **Lua Language Server** (`.luarc.json`) — LSP и диагностика для Lua. В проекте отключено предупреждение `unused-local`.
- **Mason** (`mason.nvim` + `mason-lspconfig.nvim`) — установка и управление LSP-серверами, линтерами, форматтерами.
- **conform.nvim** — автоформатирование при сохранении. Заменяет `none-ls` из предыдущего конфига.
- **lazy.nvim** — единственный плагин-менеджер. Все плагины оформляются в spec-формате.

## Правила оформления плагинов (критически важно)

### Формат spec (lazy.nvim)

Каждый плагин оформляй как элемент массива, возвращаемого из файла:

```lua
-- ПЛОХО: отдельный setup() вне spec
require('nvim-tree').setup({ ... })

-- ХОРОШО: spec для lazy.nvim
return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      -- опции плагина
    },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle file explorer' },
    },
    config = function(_, opts)
      -- только если нужна кастомная логика помимо opts
      require('nvim-tree').setup(opts)
    end,
  },
}
```

### Принципы

1. **Один файл = один логический блок**. Не смешивай LSP и Git в одном файле.
2. **Используй `opts` для конфигурации**. Не пиши `config = function() require('plugin').setup({...}) end`, если достаточно `opts = {...}`.
3. **Keymaps только внутри spec или в `lua/core/keymaps.lua`**. Не разбрасывай по `after/`, `plugin/`, случайным файлам.
4. **Никаких `vim.cmd` для настройки**. Только Lua API: `vim.opt`, `vim.keymap.set`, `vim.api.nvim_create_autocmd`.
5. **Проверяй дублирование**. Перед добавлением нового плагина проверь, не решает ли уже эту проблему существующий (Telescope vs fzf-lua, neo-tree vs nvim-tree, etc.).

## LSP и автодополнение

- Используй `mason.nvim` + `mason-lspconfig.nvim` + `nvim-lspconfig`.
- Для Neovim 0.11+ предпочитай `vim.lsp.config()` / `vim.lsp.enable()` где возможно.
- Автодополнение: `nvim-cmp` с источниками `lsp`, `buffer`, `path`, `luasnip`.

## Keymaps

- **Leader key**: `<Space>` (установлен в `core/options.lua`).
- **Формат**: `vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })`.
- **Всегда добавляй `desc`** — это нужно для which-key.

## Workflow работы

1. **Анализ запроса**: Пойми, какая фича нужна. Проверь, нет ли её уже в конфиге.
2. **Проверка backup/**: Загляни в `backup/` — возможно, фича уже была реализована раньше. Мигрируй кастомные настройки оттуда.
3. **Reference**: Загляни в `examples/` — найди похожий сниппет.
4. **Генерация**: Напиши код в стиле существующих файлов. Используй современный Lua API.
5. **Проверка**: Убедись, что нет синтаксических ошибок, нет дублирования, код совместим со StyLua.
6. **Объяснение**: Кратко объясни, что было добавлено и почему.
7. **Git**: Предложи сообщение коммита.

## Запреты (НЕЛЬЗЯ)

- ❌ Копировать чужие конфиги целиком (kickstart, LazyVim, AstroNvim) в наши файлы.
- ❌ Использовать `vim.cmd('set number')` — только `vim.opt.number = true`.
- ❌ Использовать `vim.api.nvim_set_keymap` — только `vim.keymap.set`.
- ❌ Писать плагин-конфигурацию в `init.lua` — только импорты.
- ❌ Использовать `packer.nvim` или `vim-plug` — только `lazy.nvim`.
- ❌ Добавлять плагины без `desc` в keymaps.
- ❌ Менять файлы в `~/.local/share/nvim/lazy/` — это внешние зависимости.
- ❌ Смешивать разные логические блоки в одном файле плагинов.

## Reference Library (`examples/`)

При возникновении неопределенности смотри в эту папку:

- `examples/minimal/init.lua` — минимальный старт с `lazy.nvim`
- `examples/minimal/plugin_spec.lua` — минимальный spec `lazy.nvim`
- `examples/snippets/01_bootstrap.lua` — инициализация `lazy.nvim`
- `examples/snippets/02_options.lua` — `vim.opt`, globals, clipboard
- `examples/snippets/03_keymaps.lua` — `vim.keymap.set` с `desc`
- `examples/snippets/04_lsp.lua` — Mason + lspconfig + cmp
- `examples/snippets/05_telescope.lua` — Telescope + extensions
- `examples/snippets/06_treesitter.lua` — Treesitter + textobjects
- `examples/snippets/07_cmp.lua` — nvim-cmp sources + mapping
- `examples/snippets/08_git.lua` — gitsigns
- `examples/snippets/09_ui.lua` — colorscheme, statusline
- `examples/snippets/10_autocmds.lua` — `vim.api.nvim_create_autocmd`
- `examples/snippets/11_mini.lua` — `mini.nvim` плагины
- `examples/kickstart_reference.lua` — полный `init.lua` из kickstart.nvim
- `examples/tj_reference.lua` — сниппеты из tjdevries/config.nvim

Если примера нет — используй kickstart.nvim или tjdevries/config.nvim как внешний reference, но адаптируй под наш стиль.

## Backup (`backup/`)

`backup/` содержит предыдущий рабочий конфиг пользователя. Используй его как источник для миграции:

- Перед добавлением новой фичи проверяй `backup/` — возможно, она уже была реализована.
- Кастомные настройки (Arduino LSP с FQBN, svelte-автокоманды, neovide-конфиг) мигрируй оттуда.
- Legacy API из `backup/` (`vim.api.nvim_set_keymap`, `vim.cmd`) переписывай на современный Lua API (`vim.keymap.set`, `vim.opt`, `vim.api.nvim_create_autocmd`).
- Не копируй файлы из `backup/` напрямую — адаптируй под текущую структуру и стиль.

## Примеры: Хорошо vs Плохо

### Плохо: Раздутый config

```lua
-- git.lua
return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      signs = {
        add = { text = '+' },
        change = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        vim.keymap.set('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr })
        -- ... ещё 50 строк keymaps ...
      end
    })
  end
}
```

### Хорошо: Чистый spec

```lua
-- git.lua
return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = { add = { text = '+' }, change = { text = '~' } },
    },
    keys = {
      { ']h', '<cmd>Gitsigns next_hunk<cr>', desc = 'Next Hunk' },
      { '[h', '<cmd>Gitsigns prev_hunk<cr>', desc = 'Prev Hunk' },
      { '<leader>gh', '<cmd>Gitsigns preview_hunk<cr>', desc = '[G]it [H]unk' },
    },
  },
}
```

## Примечание по NixOS

Если конфиг управляется через Nix (home-manager), файлы могут быть read-only. В этом случае генерируй код для `home.file.".config/nvim/lua/plugins/xxx.lua".text = '''...'''` или аналогичной конструкции, но стиль Lua-кода остаётся тем же.
