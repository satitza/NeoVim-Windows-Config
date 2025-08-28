
return {
  -- "mfussenegger/nvim-dap",
  -- "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
   "nvim-neotest/nvim-nio",
   "williamboman/mason.nvim",
  
  
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()
  end,
}
