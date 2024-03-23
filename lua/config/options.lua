-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.guicursor = ""
-- vim.opt.guifont = "JetBrains Mono"

vim.opt.nu = true
vim.opt.relativenumber = false

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.opt.laststatus = 2

vim.opt.cursorline = true

vim.opt.hidden = true

vim.opt.confirm = true

vim.opt.timeoutlen = 1000

-- show tabs (0: not shown)
vim.opt.showtabline = 0

-- set transparency density
-- vim.opt.pumblend = 1
