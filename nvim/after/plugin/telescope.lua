local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

vim.keymap.set('n', '<C-g>', builtin.git_files, {})
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

vim.keymap.set('n', '<C-f>', ':Telescope<CR>', opts)

vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
--vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})

vim.keymap.set('n', '<C-b>', function() builtin.buffers(themes.get_dropdown({
--vim.keymap.set('n', '<leader>y', function() builtin.buffers(themes.get_dropdown({
        previewer = false,
        sort_lastused = true, ignore_current_buffer = true
    }))
end, opts)

vim.keymap.set('n', '<leader>f', builtin.autocommands, {})
-- vim.keymap.set('n', '<leader>c', builtin.vim_options, {})
vim.keymap.set('n', '<leader>c', function() builtin.commands(themes.get_dropdown()) end, {})

vim.keymap.set('n', '<space>/', function()
	builtin.current_buffer_fuzzy_find(themes.get_dropdown {
		winblend = 10,
		previewer = false
	})
end, { desc = '[/] Fuzzily search in current buffer' })

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')


--require('telescope').load_extension('vstask')




--require("vstask").setup({
--  cache_json_conf = true, -- don't read the json conf every time a task is ran
--  cache_strategy = "last", -- can be "most" or "last" (most used / last used)
--  config_dir = ".vscode", -- directory to look for tasks.json and launch.json
--  use_harpoon = true, -- use harpoon to auto cache terminals
--  telescope_keys = { -- change the telescope bindings used to launch tasks
--      vertical = '<C-v>',
--      split = '<C-p>',
--      tab = '<C-t>',
--      current = '<CR>',
--  },
--  autodetect = { -- auto load scripts
--    npm = "on"
--  },
--  terminal = 'toggleterm',
--  term_opts = {
--    vertical = {
--      direction = "vertical",
--      size = "80"
--    },
--    horizontal = {
--      direction = "horizontal",
--      size = "10"
--    },
--    current = {
--      direction = "float",
--    },
--    tab = {
--      direction = 'tab',
--    }
--  },
--  json_parser = 'vim.fn.json_decode'
--})
--
--vim.keymap.set("n", "<leader>ta", require("telescope").extensions.vstask.tasks, {})
--nnoremap <Leader>ta :lua require("telescope").extensions.vstask.tasks()<CR>
--nnoremap <Leader>ti :lua require("telescope").extensions.vstask.inputs()<CR>
--nnoremap <Leader>th :lua require("telescope").extensions.vstask.history()<CR>
--nnoremap <Leader>tl :lua require('telescope').extensions.vstask.launch()<CR>
