return {


  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      -- 'nvim-java/nvim-java',
      'williamboman/mason-lspconfig.nvim',
      {
        'j-hui/fidget.nvim',
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
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind.nvim'
    },
  },

  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = function(_, opts)
  --     require 'lsp_signature'.setup({
  --       toggle_key = '<C-e>',
  --       toggle_key_flip_floatwin_setting = true,
  --     })
  --   end
  -- },
  --
  -- "zbirenbaum/copilot.lua",
  -- "github/copilot.vim",

  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({})
    end
  },

  {
    "simrat39/rust-tools.nvim",
    ft = { "rust", "toml" },
  },
}
