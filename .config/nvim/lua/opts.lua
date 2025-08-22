vim.o.number = true
vim.o.relativenumber = true
vim.o.title = true
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.showmode = false
vim.o.signcolumn = "yes"

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true

vim.o.wrap = true
vim.o.linebreak = true
vim.o.showbreak = "↪"
vim.o.sidescroll = 1

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.updatetime = 300
vim.o.timeout = true
vim.o.timeoutlen = 500

vim.o.swapfile = false
vim.o.backup = false

local undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.fn.mkdir(undodir, "p")
vim.o.undodir = undodir
vim.o.undofile = true

vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.scrolloff = 8
vim.o.winborder = "rounded"

vim.g.have_nerd_font = true

vim.scriptencoding = "utf-8"
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
