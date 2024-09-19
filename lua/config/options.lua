local is_win = vim.fn.has("win32") == 1

vim.o.guicursor = "n-v-i:block"

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.wrap = false
vim.opt.colorcolumn = "80"

vim.opt.scrolloff = 12
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.o.clipboard = "unnamedplus"

vim.o.breakindent = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = "yes"

vim.o.completeopt = "menuone,noselect"
vim.o.termguicolors = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.cindent = true
vim.opt.cinoptions = "N-s"

vim.opt.cursorline = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.nvim-undodir"
