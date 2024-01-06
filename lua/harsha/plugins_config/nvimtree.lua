require("nvim-tree").setup({

  git = {
    enable = true,
    ignore = false, -- show git ignored files
  },
  renderer = {
    -- root_folder_label = false,
    indent_markers = {
      enable = true,
    },
    group_empty = true,
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
    custom = {
      "^.git$",
    },
  },
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  update_cwd = true,
  update_focused_file = {
    enable = false,
    update_cwd = false,
  },
  view = {
    adaptive_size = true,
    side = "left",
    width = 30,
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
-- vim.keymap.set('n', '<C-S-n>', api.tree.toggle { find_file = true, focus = true }, { desc = 'Toggle Nvim Tree with focus' })
vim.keymap.set('n', '<C-S-n>', ':NvimTreeFindFileToggle<CR>', { desc = 'Toggle Nvim Tree with focus' })
