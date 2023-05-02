local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    file_ignore_patterns = {
      "node_modules/.*",
      "venv/.*"
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
    }
  }
})

-- Enable extensions if installed
pcall(telescope.load_extension, 'fzf')

if pcall(require, "telescope-live-grep-args.actions") then
    vim.keymap.set("n", "<Leader>fl", telescope.extensions.live_grep_args.live_grep_args, { silent = true })
end

if pcall(telescope.load_extension, 'file_browser') then

  vim.keymap.set("n", "<Leader>fb", function()
      telescope.extensions.file_browser.file_browser()
  end, { silent = true })

  vim.keymap.set("n", "<Leader>fe", function()
      telescope.extensions.file_browser.file_browser({ cwd = vim.fn.expand("%:p:h") })
  end, { silent = true })

  vim.keymap.set("n", "<Leader>fc", function()
      telescope.extensions.file_browser.file_browser({ cwd = "~/.config/" })
  end, { silent = true })

end

vim.keymap.set('n', '<leader><space>', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- See `:help telescope.builtin`

vim.keymap.set('n', '<leader>fR', telescope_builtin.resume, { desc = '[?] Resume telescope' })

vim.keymap.set('n', '<leader>?', telescope_builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>fo', telescope_builtin.oldfiles, { desc = '[?] Find recently opened files' })

vim.keymap.set('n', '<leader>/', telescope_builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>b', telescope_builtin.buffers, { desc = '[B]uffers' })
vim.keymap.set('n', '<A-b>', telescope_builtin.buffers, { desc = '[F]ind [B]uffers' })

vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp tags' })

vim.keymap.set('n', '<leader>fr', require('telescope.builtin').lsp_references, { desc = '[F]ind [R]eferences' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })

vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })

vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = '[F]ind [K]eys' })
vim.keymap.set('n', '<leader>fm', require('telescope.builtin').man_pages, { desc = '[F]ind [M]an page' })

