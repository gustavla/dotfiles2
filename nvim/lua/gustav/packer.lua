vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = ':TSUpdate'
  }

  use 'nvie/vim-flake8'
  use 'nvim-treesitter/playground'
  --use 'theprimeagen/harpoon'
  use 'mbbill/undotree'
  use 'tpope/vim-fugitive'
  use 'jremmen/vim-ripgrep'
  use 'projekt0n/github-nvim-theme'
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use 'yorickpeterse/nvim-window'
  --use {
  --    'EthanJWright/vs-tasks.nvim',
  --    requires = {
  --        'nvim-lua/popup.nvim',
  --        'nvim-lua/plenary.nvim',
  --        'nvim-telescope/telescope.nvim'
  --    }
  --}
  use {
      'stevearc/overseer.nvim',
      config = function() require('overseer').setup() end
  }
  use 'rcarriga/nvim-notify'
  --use {
  --    'skanehira/denops-gh.vim',
  --    requires = { 'vim-denops/denops.vim' }
  --}

  -- LSP
  use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      requires = {
          --- Uncomment these if you want to manage LSP servers from neovim
          {'williamboman/mason.nvim'},
          {'williamboman/mason-lspconfig.nvim'},

          -- LSP Support
          {'neovim/nvim-lspconfig'},
          -- Autocompletion
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'L3MON4D3/LuaSnip'},
      }
}
end)
