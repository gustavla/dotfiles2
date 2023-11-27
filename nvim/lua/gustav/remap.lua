vim.g.mapleader = ","
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- No-shift shortcut for :
vim.api.nvim_set_keymap('n', ';', ':', {noremap = true})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("i", "<C-l>", "<C-N>")

vim.keymap.set("n", "<leader>t", ":%s/\\s\\s*$//gc<CR>")

vim.keymap.set("n", "<leader>*", ":Rg<CR>")
vim.keymap.set("n", "<leader>r", ":Rg<CR>")

--vim.keymap.set("v", "<leader>J", "J", {noremap = true})

-- Move to previous buffer
--vim.api.nvim_set_keymap('n', '<leader>g', ':e#<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>g', ':b#<CR>', {noremap = true})
