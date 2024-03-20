require('gitsigns').setup {
  signs = {
    add = {
      hl = "GitSignsAdd",
      text = "│",
      numhl = "GitSignsAddNr",
      linehl = "GitSignsAddLn"
    },
    change = {
      hl = "GitSignsChange",
      text = "│",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn"
    },
    delete = {
      hl = "GitSignsDelete",
      text = "-",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn"
    },
    topdelete = {
      hl = "GitSignsDelete",
      text = "‾",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn"
    },
    changedelete = {
      hl = "GitSignsChange",
      text = "~",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn"
    },
  },
  signcolumn = true,
  numhl = true,
  linehl = false,
  word_diff = false,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Navigation
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { buffer = bufnr, expr = true, desc = "next hunk" })

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { buffer = bufnr, expr = true, desc = "prev hunk" })

    -- Actions
    vim.keymap.set({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', { buffer = bufnr, desc = "[H]unk [S]tage" })
    vim.keymap.set({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', { buffer = bufnr, desc = "[H]unk [R]eset" })
    vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { buffer = bufnr, desc = "[H]unk [S]tage buffer" })
    vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { desc = "[H]unk [U]ndo" })
    vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { buffer = bufnr, desc = "[H]unk [R]eset buffer" })
    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = "[H]unk [P]review" })
    -- vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end,
    --   { buffer = bufnr, desc = "[H]unk [B]lame line" })
    vim.keymap.set('n', '<leader>hb', gs.toggle_current_line_blame, { buffer = bufnr, desc = "[H]unk [B]lame line" })
    vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = bufnr, desc = "[H]unk [D]iff" })
    vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end, { buffer = bufnr, desc = "[H]unk [D]iff ~" })
    vim.keymap.set('n', '<leader>ht', gs.toggle_deleted, { buffer = bufnr, desc = "[T]oggle hunk [D]elete " })

    -- Text object
    vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = bufnr, desc = "select hunk" })
  end,
  watch_gitdir = {
    interval = 2000,
    follow_files = true,
  },
  attach_to_untracked = false,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 1000,
  },
  current_line_blame_formatter_opts = {
    relative_time = true,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  preview_config = {
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
}
