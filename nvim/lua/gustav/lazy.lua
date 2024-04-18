require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        --event = "VeryLazy",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function(_, opts)
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
        end,
    },
    {
	    'nvim-telescope/telescope-fzf-native.nvim',
        event = "VeryLazy",
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
    {
        'nvim-treesitter/nvim-treesitter',
        --event = "VeryLazy",
        build = ':TSUpdate',
        config = function(_, opts)
            require'nvim-treesitter.configs'.setup {
                -- A list of parser names, or "all" (the five listed parsers should always be installed)
                ensure_installed = { "c", "javascript", "typescript", "lua", "vim", "vimdoc", "rust", "python", "query" },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                highlight = {
                    enable = true,

                    additional_vim_regex_highlighting = false,
                },
            }
        end,
    },
    {
        'nvie/vim-flake8',
        lazy = true,
        keys = {
            {
                "<F7>", ":call flake8#Flake8()<CR>", desc = "Flake8",
            },
        },
    },
    {
        'tpope/vim-fugitive',
        event = "VeryLazy",
    },
    {
        'jremmen/vim-ripgrep',
        event = "VeryLazy",
    },
    {
        'projekt0n/github-nvim-theme',
        lazy = false,
        priority = 1000,
        config = function(_, opts)
            require("github-theme").setup({
                -- -- Overwrite the highlight groups
                -- overrides = function(c)
                    --   return {
                        --     DiffChange = {fg = c.bright_blue, bg = c.bg_visual_selection},
                        --     DiffAdd    = {fg = c.diff.add_fg, bg = c.diff.add},
                        --     DiffText   = {fg = c.orange, bg = c.bg_visual_selection}
                        --   }
                        -- end
                    })
                    -- check kitty theme
                    vim.cmd("colorscheme github_dark_dimmed")

                    function Light_theme()
                        vim.cmd("colorscheme github_light")
                    end

                    function Dark_theme()
                        vim.cmd("colorscheme github_dark_dimmed")
                    end

                end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
        branch = 'v3.x',
        dependencies = {
            --- Uncomment these if you want to manage LSP servers from neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- LSP Support
            'neovim/nvim-lspconfig',
            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            "onsails/lspkind.nvim",
        },
        config = function(_, opts)
            local lsp_zero = require('lsp-zero')
            require("mason").setup()
            local util = require('lspconfig/util')

            vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
            vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

            local border = {
                {"🭽", "FloatBorder"},
                {"▔", "FloatBorder"},
                {"🭾", "FloatBorder"},
                {"▕", "FloatBorder"},
                {"🭿", "FloatBorder"},
                {"▁", "FloatBorder"},
                {"🭼", "FloatBorder"},
                {"▏", "FloatBorder"},
            }

            -- LSP settings (for overriding per client)
            local handlers =  {
                ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
                ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
            }

            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or border
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end

            require('lspconfig.ui.windows').default_options.border = 'single'


            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            -- LUA
            require'lspconfig'.lua_ls.setup {
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
                        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                            Lua = {
                                runtime = {
                                    -- Tell the language server which version of Lua you're using
                                    -- (most likely LuaJIT in the case of Neovim)
                                    version = 'LuaJIT'
                                },
                                -- Make the server aware of Neovim runtime files
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        vim.env.VIMRUNTIME
                                        -- "${3rd}/luv/library"
                                        -- "${3rd}/busted/library",
                                    }
                                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                                    -- library = vim.api.nvim_get_runtime_file("", true)
                                }
                            }
                        })

                        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                    end
                    return true
                end
            }

            --require'lspconfig'.pyright.setup {
            --    root_dir = function(fname)
            --        local root_files = {
            --            'pyrightconfig.json',
            --            'pyproject.toml',
            --        }
            --        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
            --    end,
            --    settings = {
            --        python = {
            --            analysis = {
            --                reportMissingModuleSource = "none",
            --                autoSearchPaths = true,
            --                diagnosticMode = "openFilesOnly",
            --                useLibraryCodeForTypes = true
            --            }
            --        }
            --    }
            --}

            require'lspconfig'.pylyzer.setup {
                autostart = false,
                python = {
                    checkOnType = false,
                    diagnostics = true,
                    inlayHints = true,
                    smartCompletion = true
                }
            }

            require'lspconfig'.clangd.setup{
                root_dir = function(fname)
                    local root_files = {
                        'pyrightconfig.json',
                        'pyproject.toml',
                    }
                    return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
                end
            }

            -- Frontend
            require'lspconfig'.biome.setup{}

            --OCaml
            require'lspconfig'.ocamllsp.setup{}


            cfg = {}
            require "lsp_signature".setup(cfg)

        end
    },
    {
        'yorickpeterse/nvim-window',
        event = "VeryLazy",
        config = function(_, opts)
            local window = require('nvim-window')
            window.setup({
                -- The characters available for hinting windows.
                chars = {
                    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
                    'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
                },

                -- A group to use for overwriting the Normal highlight group in the floating
                -- window. This can be used to change the background color.
                normal_hl = 'Normal',

                -- The highlight group to apply to the line that contains the hint characters.
                -- This is used to make them stand out more.
                hint_hl = 'Bold',

                -- The border style to use for the floating window.
                border = 'single'
            })

            vim.keymap.set("n", "<leader>w", window.pick)
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts) require'lsp_signature'.setup(opts) end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        config = function(_, opts)
            require'treesitter-context'.setup{
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 8, -- Maximum number of lines to show for a single context
                trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20, -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            }
        end
    },
    {
        "onsails/lspkind.nvim",
    },
    {
        'hrsh7th/nvim-cmp',
        config = function(_, opts)
            local lspkind = require('lspkind')
            require'cmp'.setup{
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text', -- show only symbol annotations
                        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        -- can also be a function to dynamically calculate max width such as 
                        -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        show_labelDetails = true, -- show labelDetails in menu. Disabled by default

                        -- The function below will be called before any actual modifications from lspkind
                        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                        before = function (entry, vim_item)
                            return vim_item
                        end
                    })
                }
            }
        end
    },
}, {})
