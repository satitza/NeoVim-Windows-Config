-- bootstrap lazy.nvim, LazyVim and your plugins
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("plugins.lsp")

require("lazy").setup("plugins")

vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.shell = "powershell.exe"

vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

vim.g.python3_host_prog = "C:\\Users\\st_sa\\.pyenv\\pyenv-win\\versions\\3.13.5\\python.exe"
