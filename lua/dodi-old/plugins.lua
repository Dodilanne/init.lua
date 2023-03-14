-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use "christoomey/vim-tmux-navigator"

  use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
    end
  }

  use {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd("colorscheme nightfox")
    end
  }

  use "tpope/vim-surround"

  use "f-person/auto-dark-mode.nvim"

  use "lukas-reineke/indent-blankline.nvim"

  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup()
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup()
    end
  }

  use {
    "terrortylor/nvim-comment",
    config = function()
      require('nvim_comment').setup()
    end
  }

  use {
    "aspeddro/gitui.nvim",
    config = function()
      require("gitui").setup()
    end
  }

  use "akinsho/toggleterm.nvim"

  use "github/copilot.vim"

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    "windwp/nvim-ts-autotag",
    config = function() require("nvim-ts-autotag").setup() end
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }


  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

  use "theprimeagen/harpoon"

  use "mbbill/undotree"

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },         -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' },     -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  }
end)