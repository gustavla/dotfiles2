
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('gustav.lazy')
require('gustav.remap')
require('gustav.options')
local indent = require('gustav.indent')

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp,cc,javascript,ocaml",
    callback = indent.setup_indent,
})
