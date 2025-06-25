-- this file installs the plugins
-- you can also write seperate files in plugins/plugins for each plugin

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
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
  require 'harsha.plugins.utility',
  -- lsp related basic plugins
  require 'harsha.plugins.autocomplete',
  -- other plugins
  { import = "harsha.plugins.plugins" },
  -- ui related plugins
  require 'harsha.plugins.ui',
  -- unnecessary fancy stuff
  require 'harsha.plugins.fancy'
}, {})
