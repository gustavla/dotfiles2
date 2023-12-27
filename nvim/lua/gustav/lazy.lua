

require("lazy").setup({
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  { 'nvie/vim-flake8' },
  { 'tpope/vim-fugitive' },
  { 'jremmen/vim-ripgrep' },
  { 'projekt0n/github-nvim-theme' },
  {
    'VonHeikemen/lsp-zero.nvim',
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
    }
  },
  { 'yorickpeterse/nvim-window' },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require'lsp_signature'.setup(opts) end
  }
}, {})
