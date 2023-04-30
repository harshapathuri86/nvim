return {
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-sleuth',

  {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
      require("which-key").setup({

      })
    end,
  },

  { 'numToStr/Comment.nvim',         opts = {} },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  { 'akinsho/toggleterm.nvim', version = "*", opts = {} },

}
