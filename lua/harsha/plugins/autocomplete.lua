return {


  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim',
        tag = "legacy",
      },
      'folke/neodev.nvim',
    },
  },


  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'onsails/lspkind.nvim'
    },
  },

  "ray-x/lsp_signature.nvim",

   "zbirenbaum/copilot.lua" ,

  { "simrat39/rust-tools.nvim",
    ft = {"rust", "toml"},
  },

  {'mfussenegger/nvim-jdtls'},

  {'mfussenegger/nvim-dap'},

  {'rcarriga/nvim-dap-ui'}
}
