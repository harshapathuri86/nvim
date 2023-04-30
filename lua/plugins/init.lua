-- this file installs the plugins
-- you can also write seperate files in plugins/plugins for each plugin

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- basic plugins
  require 'plugins.basic',
  -- lsp related basic plugins
  require 'plugins.lsp',
  -- other plugins
  {import = "plugins.plugins" },
  -- ui related plugins
  require 'plugins.ui'
}, {})

-- load configs for these plugins
require("plugins.configs")
