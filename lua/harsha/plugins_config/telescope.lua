local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    defaults = {
      layout_strategy = 'center',
      layout_config = { height = 0.95 },
    },
    file_ignore_patterns = {
      "node_modules/.*",
      "venv/.*",
      ".git/.*"
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
  vim.keymap.set("n", "<Leader>sl", telescope.extensions.live_grep_args.live_grep_args, { silent = true })
end

if pcall(telescope.load_extension, 'file_browser') then
  -- vim.keymap.set("n", "<Leader>fb", function()
  --     telescope.extensions.fi.file_browser()
  -- end, { silent = true })
  --
  -- vim.keymap.set("n", "<Leader>fe", function()
  --     telescope.extensions.file_browser.file_browser({ cwd = vim.fn.expand("%:p:h") })
  -- end, { silent = true })
  --
  -- vim.keymap.set("n", "<Leader>fc", function()
  --     telescope.extensions.file_browser.file_browser({ cwd = "~/.config/" })
  -- end, { silent = true })
end

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>b', telescope_builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', telescope_builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eys' })
vim.keymap.set('n', '<leader>sm', require('telescope.builtin').man_pages, { desc = '[S]earch [M]an page' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sR', require('telescope.builtin').lsp_references, { desc = '[F]ind [R]eferences' })

vim.keymap.set("n", "<leader>t", ":Telescope <CR>")
