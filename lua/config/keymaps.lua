-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- LSPSaga
vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", { silent = true })
vim.keymap.set("n", "<F2>", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Symbols Outline
vim.keymap.set("n", "<leader>o", "<cmd>SymbolsOutline<CR>", { silent = true })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>bd", "<cmd>Bdelete<CR>", { silent = true })

local dap = require("dap")
local dapui = require("dapui")

-- continue / run
vim.keymap.set("n", "<F5>", function()
  require("dap").continue()
end)
vim.keymap.set("n", "<F10>", function()
  require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
  require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
  require("dap").step_out()
end)
vim.keymap.set("n", "<F4>", function()
  require("dap").toggle_breakpoint()
end)
