require("dapui").setup()

vim.keymap.set("n", "<leader>do", require("dapui").open)
vim.keymap.set("n", "<leader>dc", require("dapui").close)
vim.keymap.set("n", "<leader>dt", require("dapui").toggle)
