require('gustav.packer')
require('gustav.remap')
local indent = require('gustav.indent')

vim.opt.colorcolumn = "79"

vim.opt.nu = true

vim.wo.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

--vim.cmd [[au BufRead, python call matchadd('ColorColumn', '\\%80v.', 100)]]


--au BufRead,BufNewFile,BufEnter /path/to/dir/* setlocal ts=2 sts=2 sw=2
--autocmd BufRead,BufNewFile,BufEnter "/Users/larsson/work/tetracode/src/www/onnx-**/*" lua require'gustav.indent'.setup_indent()
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp,cc,javascript,ocaml",
    callback = indent.setup_indent,
})


vim.opt.smartindent = true
vim.opt.wrap = false

vim.wo.cursorline = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true



