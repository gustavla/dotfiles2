vim.opt.colorcolumn = "79"

vim.opt.nu = true

vim.wo.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.o.scrolloff = 8

--vim.cmd [[au BufRead, python call matchadd('ColorColumn', '\\%80v.', 100)]]

vim.opt.smartindent = true
vim.opt.wrap = false

vim.wo.cursorline = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
