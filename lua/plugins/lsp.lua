return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {}, -- enable C/C++
      },
    },
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
    end,
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup()
    end,
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- auto update parser เวลาลงใหม่
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true }, -- เปิด highlight
        indent = { enable = true }, -- auto indent
        ensure_installed = {
          "lua",
          "go",
          "c",
          "cpp",
          "python",
        }, -- เลือกภาษา
      })
    end,
  },

  -- LSPSaga (UI for LSP)
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        ui = {
          border = "rounded",
          title = true,
          winblend = 10,
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- saga ใช้ treesitter
      "nvim-tree/nvim-web-devicons", -- optional icons
    },
  },

  -- Symbols Outline (sidebar outline)
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
    config = function()
      require("symbols-outline").setup()
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30, side = "left" },
        renderer = { icons = { show = { git = true, folder = true, file = true } } },
      })
    end,
  },

  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },

  -- vim-bbye (close buffer without messing layout)
  {
    "moll/vim-bbye",
  },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP source
      "hrsh7th/cmp-buffer", -- buffer source
      "hrsh7th/cmp-path", -- path source
      "hrsh7th/cmp-cmdline", -- command-line completion
      "saadparwaiz1/cmp_luasnip", -- snippet completion
      "L3MON4D3/LuaSnip", -- snippet engine
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
        }),
      })
    end,
  },
}
