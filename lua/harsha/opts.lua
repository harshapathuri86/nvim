-- vkm.g.copilot_proxy_strict_ssl = false

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.mouse = "a"
vim.opt.wrap = false

vim.opt.smoothscroll = true

vim.opt.linebreak = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.completeopt = { "menuone", "noselect" }
-- vim.opt.foldmarker = { "<<<", ">>>" }
-- vim.opt.foldmethod = "marker"
vim.opt.title = true
vim.opt.showmode = false
vim.opt.virtualedit = "block"
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.laststatus = 3
vim.opt.cursorline = true

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
vim.opt.winbar = "%=%m %f"

vim.opt_global.termguicolors = true
vim.opt.list = true
vim.opt.fillchars = { eob = " " }
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- vim.opt.lazyredraw = true
vim.opt.undofile = true
vim.opt.hlsearch = true
-- show 5 lines above and below coursor always
vim.opt.scrolloff = 5
vim.opt.sidescroll = 5
-- set popup menu height to 20 lines
vim.opt.pumheight = 20
-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 500

vim.g.mapleader = " "
vim.g.maplocalleader = ' '

vim.g.hidden = true
