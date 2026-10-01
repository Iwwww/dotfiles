return {
  "mfussenegger/nvim-dap",
  -- lazy-load only when debugging (commands or F-keys)
  cmd = {
    "DapContinue",
    "DapStepInto",
    "DapStepOver",
    "DapStepOut",
    "DapToggleBreakpoint",
    "DapClearBreakpoints",
    "DapToggleRepl",
    "DapPause",
    "DapTerminate",
    "DapDisconnect",
    "DapShowLog",
    "DapSetLogLevel",
  },
  keys = {
    { "<F1>", desc = "Debug: Exit" },
    { "<F2>", desc = "Debug: Start/Continue" },
    { "<F3>", desc = "Debug: Step Into" },
    { "<F4>", desc = "Debug: Step Over" },
    { "<F5>", desc = "Debug: Step Out" },
    { "<F7>", desc = "Debug: Last session result" },
    { "<leader>b", desc = "Debug: Toggle Breakpoint" },
    { "<leader>B", desc = "Debug: Set Breakpoint" },
  },
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    -- debug adapters
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("nvim-dap-virtual-text").setup()

    require("mason-nvim-dap").setup({
      automatic_setup = true,
      handlers = {},
      ensure_installed = {
        "delve",
      },
    })

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set("n", "<F2>", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F3>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F4>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F5>", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>B", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Debug: Set Breakpoint" })

    -- Dap UI setup
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          pause = "⏸",
          play = "▶️",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶️▶️",
          terminate = "⏹",
          disconnect = "⏏️",
        },
      },
    })

    vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })
    vim.keymap.set("n", "<F1>", dapui.close, { desc = "Exit debug mode" })

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- golang specific config
    require("dap-go").setup()
  end,
}
