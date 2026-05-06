return {
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    -- NOTE: Mason checkhealth warnings про Go, cargo, ruby, php, java, julia, pip —
    -- это норма для NixOS. Mason не может ставить пакеты для языков,
    -- чей runtime отсутствует в PATH. Если нужен LSP для этих языков —
    -- ставь runtime и/или LSP через nix (home.packages).
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        -- NOTE: На NixOS некоторые LSP лучше ставить через nix (home.packages)
        -- вместо Mason, т.к. Mason-бинарники часто падают (libc/nix-ld issues).
        -- Проблемные: marksman, clangd (иногда), arduino-language-server,
        -- cmake-language-server (требует pip, которого нет в NixOS по умолчанию).
        "pyright",
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "bashls",
        "jsonls",
        "cmake",
        "sqlls",
      },
      automatic_installation = true,
    })
  end,
}
