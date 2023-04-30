require("nvim-tree").setup({
  git = {
    enable = true,
    ignore = false, -- show git ignored files
  },
  renderer = {
    -- root_folder_label = false,
    highlight_git = false,
    icons = {
      show = {
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
    exclude = {},
  },
  disable_netrw = true,
  hijack_netrw = true,
  -- open_on_setup = false,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  view = {
    adaptive_size = true,
    side = "left",
    width = 25,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
})

local api = require("nvim-tree.api")
vim.keymap.set('n', '<C-n>', api.tree.toggle, { desc = 'Toggle Nvim Tree' })

