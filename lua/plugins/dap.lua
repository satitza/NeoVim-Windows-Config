return {

  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "nvim-neotest/nvim-nio",

  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Adapter, configurations, UI, keymap
    dap.adapters.python = { type = "executable", command = "python", args = { "-m", "debugpy.adapter" } }
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          return "python"
        end,
      },
    }

    dap.adapters.cppdbg = {
      type = "executable",
      command = "C:\\Users\\st_sa\\.vscode\\extensions\\ms-vscode.cpptools-1.27.2-win32-x64\\debugAdapters\\bin\\OpenDebugAD7.exe",
      name = "OpenDebugAD7",
    }
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
      },
    }

    dapui.setup()

    dap.configurations.c = dap.configurations.cpp
  end,
}
