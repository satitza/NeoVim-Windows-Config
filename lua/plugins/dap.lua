return {
  {
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- set log level ก่อนใช้งาน
      dap.set_log_level("TRACE")
      print("dap log file:", vim.fn.stdpath("cache") .. "/dap.log")

      -- 🔹 Python debug adapter
      dap.adapters.python = {
        type = "executable",
        command = "C:\\Users\\st_sa\\.pyenv\\pyenv-win\\versions\\3.13.5\\python.exe", -- ชี้ไปที่ python ที่มี debugpy
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return "C:\\Users\\st_sa\\.pyenv\\pyenv-win\\versions\\3.13.5\\python.exe"
          end,
        },
      }

      -- 🔹 C / C++ debug adapter (ผ่าน cpptools)
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = "C:\\Users\\st_sa\\.vscode\\extensions\\ms-vscode.cpptools-1.27.2-win32-x64\\debugAdapters\\bin\\OpenDebugAD7.exe", -- มาจาก cpptools
      }
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            -- compile ก่อน ถ้าอยาก auto compile
            vim.fn.system("gcc -g main.c -o main.exe -lws2_32")
            return vim.fn.getcwd() .. "\\main.exe" -- หรือ main.exe บน Windows
            -- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = false,
          args = function()
            local input = vim.fn.input("Program arguments: ")
            -- ลบ null chars (^@) ออก
            input = input:gsub("%z", "")
            local t = {}
            for arg in string.gmatch(input, "%S+") do
              table.insert(t, arg)
            end
            return t
          end,
          -- console = "externalTerminal",
          console = "integratedTerminal",
        },
      }
      dap.configurations.c = dap.configurations.cpp

      -- 🔹 JavaScript / TypeScript (ผ่าน node2 adapter)
      dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
      }
      dap.configurations.javascript = {
        {
          name = "Launch file",
          type = "node2",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
        },
      }

      -- 🔹 C# / .NET (OmniSharp)
      dap.adapters.coreclr = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
        args = { "--interpreter=vscode" },
      }
      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Launch - netcoredbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
        },
      }

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb", -- ต้องติดตั้งผ่าน Mason
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.rust = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = function()
            local input = vim.fn.input("Program arguments: ")
            local t = {}
            for arg in string.gmatch(input, "%S+") do
              table.insert(t, arg)
            end
            return t
          end,
        },
      }

      dap.adapters.java = function(callback, config)
        callback({
          type = "server",
          host = "127.0.0.1",
          port = config.port,
        })
      end

      dap.configurations.java = {
        {
          type = "java",
          request = "launch",
          name = "Launch Java",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          program = function()
            return vim.fn.input("Path to class/main: ", vim.fn.getcwd() .. "/out/production/", "file")
          end,
          args = function()
            local input = vim.fn.input("Program arguments: ")
            local t = {}
            for arg in string.gmatch(input, "%S+") do
              table.insert(t, arg)
            end
            return t
          end,
        },
      }
    end,
  },

  -- 🔹 Go debug
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup()
    end,
  },
}
