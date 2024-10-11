return {

	{
		"vhyrro/luarocks.nvim",
		priority = 1001, -- this plugin needs to run before anything else
		opts = {
			rocks = { "magick" },
		},
	},

	'tpope/vim-fugitive',
	'tpope/vim-surround',
	'tpope/vim-sleuth',
	"mbbill/undotree",

	{ 'numToStr/Comment.nvim',   opts = {} },

	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	version = "*",
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- },


	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},

	{ 'akinsho/toggleterm.nvim', version = "*", opts = {} },

	-- {
	-- 	'folke/which-key.nvim',
	-- 	config = function()
	-- 		vim.o.timeout = true
	-- 		vim.o.timeoutlen = 1000
	-- 		require("which-key").setup({
	-- 		})
	-- 	end,
	-- },

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
			"nvim-telescope/telescope-project.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
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

	--  {
	-- 	'goolord/alpha-nvim',
	-- 	dependencies = { 'nvim-tree/nvim-web-devicons' },
	-- 	config = function()
	-- 		local alpha = require("alpha")
	-- 		local dashboard = require("alpha.themes.dashboard")
	--
	-- 		dashboard.section.header.val = {
	-- 			[[                                                                       ]],
	-- 			[[                                                                       ]],
	-- 			[[                                                                       ]],
	-- 			[[                                                                     ]],
	-- 			[[       ████ ██████           █████      ██                     ]],
	-- 			[[      ███████████             █████                             ]],
	-- 			[[      █████████ ███████████████████ ███   ███████████   ]],
	-- 			[[     █████████  ███    █████████████ █████ ██████████████   ]],
	-- 			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
	-- 			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
	-- 			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
	-- 			[[                                                                       ]],
	-- 			[[                                                                       ]],
	-- 		}
	--
	-- 		_Gopts = {
	-- 			position = "center",
	-- 			hl = "Type",
	-- 			-- wrap = "overflow";
	-- 		}
	--
	-- 		local function footer()
	-- 			return "Haskell can suck mo' nads"
	-- 		end
	--
	-- 		dashboard.section.footer.val = footer()
	--
	-- 		dashboard.button = {
	-- 			type = "button",
	-- 			val = "",
	-- 		}
	--
	-- 		dashboard.opts.opts.noautocmd = true
	-- 		alpha.setup(dashboard.opts)
	-- 	end
	-- } ,

	{ 'simrat39/symbols-outline.nvim' },

	{ "folke/trouble.nvim" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
	},


	-- {
	-- 	"folke/flash.nvim",
	-- 	event = "VeryLazy",
	-- 	---@type Flash.Config
	-- 	opts = {},
	-- 	-- stylua: ignore
	-- 	keys = {
	-- 		{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
	-- 		{
	-- 			"S",
	-- 			mode = { "n", "x", "o" },
	-- 			function() require("flash").treesitter() end,
	-- 			desc =
	-- 			"Flash Treesitter"
	-- 		},
	-- 		{
	-- 			"r",
	-- 			mode = "o",
	-- 			function() require("flash").remote() end,
	-- 			desc =
	-- 			"Remote Flash"
	-- 		},
	-- 		{
	-- 			"R",
	-- 			mode = { "o", "x" },
	-- 			function() require("flash").treesitter_search() end,
	-- 			desc =
	-- 			"Treesitter Search"
	-- 		},
	-- 		{
	-- 			"<c-s>",
	-- 			mode = { "c" },
	-- 			function() require("flash").toggle() end,
	-- 			desc =
	-- 			"Toggle Flash Search"
	-- 		},
	-- 	},
	-- },

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
		}
	},

	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
		}
	},

	{
		'stevearc/oil.nvim',
		opts = {
			columns = { "" },
			keymaps = {
				["<C-v>"] = "actions.select_vsplit",
				["<C-s>"] = "actions.select_split",
				["<Esc>"] = "actions.close",
			},
			view_options = {
				show_hidden = true,
			},
			float = {
				padding = 5,
			},
		},
		keys = {
			{ "<Leader>o", ":lua require('oil').open_float()<CR>" },
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	--[[ {
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			enable = false,
		}
	}, ]]

	{
		'kawre/leetcode.nvim',
		build = ":TSUpdate html",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- required by telescope
			"MunifTanjim/nui.nvim",
			"nvim-treesitter/nvim-treesitter",
			"rcarriga/nvim-notify",
			"nvim-tree/nvim-web-devicons",
			"3rd/image.nvim",
		},
		opts = {
			-- configuration goes here
			arg = "leet",
			lang = "python3",
			image_support = true,
		},
	},

	{
		'glepnir/dbsession.nvim',
		cmd = { 'SessionSave', 'SessionDelete', 'SessionLoad' },
		opts = {
			auto_save_on_exit = true,
		},
		keys = {
			{ "<leader>ss", "<cmd>SessionSave<CR>", { noremap = true, silent = true } },
			{ "<leader>sl", "<cmd>SessionLoad<CR>", { noremap = true, silent = true } },
		},
	},
}
