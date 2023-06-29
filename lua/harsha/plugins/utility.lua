return {
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-sleuth',
  "mbbill/undotree",

  { 'numToStr/Comment.nvim',         opts = {} },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  { 'akinsho/toggleterm.nvim', version = "*", opts = {} },

  {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
      require("which-key").setup({
      })
    end,
  },

  {
	"windwp/nvim-autopairs",
	config = function()
		require("nvim-autopairs").setup({
			enable_check_bracket_line = false,
			enable_moveright = false,
			fast_wrap = {
				map = '<C-s>',
				chars = { '{', '[', '(', '"', "'" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = 'l',
				keys = 'qwertyuiopzxcvbnmasdfghjk',
				check_comma = true,
				highlight = 'Search',
				highlight_grey = 'Comment'
			},
		})
	end
  },

  { 'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
  {
    'glacambre/firenvim',

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    build = function()
        require("lazy").load({ plugins = "firenvim", wait = true })
        vim.fn["firenvim#install"](0)
    end
}
}
