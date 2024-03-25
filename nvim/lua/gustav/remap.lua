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

vim.keymap.set("n", "<C-j>", ":cn<CR>")
vim.keymap.set("n", "<C-k>", ":cp<CR>")

vim.keymap.set("n", "<leader>1", ":w<CR>:source %<CR>")

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.api.nvim_create_user_command("EditRC", function()
    vim.api.nvim_command(":e ~/.config/nvim/lua/gustav/init.lua")
end, {})

local popup= require('plenary.popup')

function ShowInfoMenu(opts, cb)
    local diag = vim.lsp.diagnostic.get_line_diagnostics()
    if #diag == 0 then
        return
    end
    local lines = {}

    local curbufid = vim.api.nvim_get_current_buf()
    local curline = vim.api.nvim_get_current_line()

    for i = 1,#diag do
        local diagi = diag[i]
        local ilines = vim.fn.split(vim.inspect(diag[i]), '\n')
    
        --ilines = { diagi.message }
        local start = diagi.range["start"]
        local end_ = diagi.range["end"]

        local source = vim.api.nvim_buf_get_lines(curbufid, start.line, start.line + 1, true)
        lines[#lines+1] = source[1]
        -- highlight the range
        local uline_str = ""
        for i = 1,start.character do
            uline_str = uline_str .. " "
        end
        for j = start.character,(end_.character-1) do
            uline_str = uline_str .. "~"
        end
        lines[#lines+1] = uline_str

        lines[#lines+1] = ""
        local messagelines = vim.fn.split(diagi.message, '\n')
        for i = 1,#messagelines do
            lines[#lines+1] = messagelines[i]
        end

        --for j = 1,#ilines do
            --lines[#lines+1] = ilines[j]
        --end
    end

    --local message = diag[1]["message"]:gsub('\n', ' ')
    --local lines = { message }

    local width = vim.o.columns - 12
    local height = 10

    Win_id = popup.create(opts, {
        title = "Lsp Line Info",
        highlight = "MyLspInfoWin",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor(((vim.o.columns - width) / 2)),
        minwidth = width,
        minheight = height,
        borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        callback = cb,
    })
    local bufnr = vim.api.nvim_win_get_buf(Win_id)
    vim.api.nvim_buf_set_option(bufnr, "readonly", false)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseInfoMenu()<CR>", { silent = false})
    vim.api.nvim_buf_set_option(bufnr, "readonly", true)
    vim.api.nvim_buf_set_option(bufnr, "modified", false)
    --vim.api.nvim_buf_set_option(bufnr, "wrap", true)
end

function CloseInfoMenu()
    vim.api.nvim_win_close(Win_id, true)
end

function DoInfoMenu()
    local opts = {}
    local cb = function(_, sel)
        print("it works")
    end
    ShowInfoMenu(opts, cb)
end

vim.keymap.set("n", "<leader>i", DoInfoMenu)

-- Move to previous buffer
vim.api.nvim_set_keymap('n', '<leader>g', ':b#<CR>', {noremap = true})
