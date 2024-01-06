return {
	'tpope/vim-fugitive',
	'tpope/vim-surround',
	'tpope/vim-sleuth',
	"mbbill/undotree",

	{ 'numToStr/Comment.nvim',   opts = {} },

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

	{
		'nvim-telescope/telescope.nvim',
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
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},

	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		config = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
		end,
	},

	-- {'joechrisellis/lsp-format-modifications.nvim'}, -- requires plenary

	-- {
	-- 	'ggandor/leap.nvim',
	-- 	config = function()
	-- 		require('leap').add_default_mappings()
	-- 	end
	--   },

	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup {
			}
		end
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
	},

	--[[ {
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = vim.opt.sessionoptions:get() },
		-- stylua: ignore
		keys = {
			{ "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
			{ "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
			{
				"<leader>qd",
				function() require("persistence").stop() end,
				desc =
				"Don't Save Current Session"
			},
		},
	}, ]]

	{
		'goolord/alpha-nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                     ]],
				[[       ████ ██████           █████      ██                     ]],
				[[      ███████████             █████                             ]],
				[[      █████████ ███████████████████ ███   ███████████   ]],
				[[     █████████  ███    █████████████ █████ ██████████████   ]],
				[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
				[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
				[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
			}

			_Gopts = {
				position = "center",
				hl = "Type",
				-- wrap = "overflow";
			}

			local function footer()
				return "Haskell can suck mo' nads"
			end

			dashboard.section.footer.val = footer()

			dashboard.opts.opts.noautocmd = true
			alpha.setup(dashboard.opts)
		end
	},
	{ 'simrat39/symbols-outline.nvim' },

	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
