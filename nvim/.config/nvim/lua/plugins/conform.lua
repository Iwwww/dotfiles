return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    local formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
    }

    -- NixOS: ставь через nix (pkgs.stylua)
    if vim.fn.executable("stylua") == 1 then
      formatters_by_ft.lua = { "stylua" }
    end

    -- NixOS: ставь через nix (pkgs.black, pkgs.isort)
    if vim.fn.executable("black") == 1 and vim.fn.executable("isort") == 1 then
      formatters_by_ft.python = { "isort", "black" }
    elseif vim.fn.executable("black") == 1 then
      formatters_by_ft.python = { "black" }
    end

    conform.setup({
      formatters_by_ft = formatters_by_ft,
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "[C]ode [F]ormat file or range" })
  end,
}
