local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local actions = require "telescope.actions"

local select_one_or_multi = function(prompt_bufnr)
  local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require('telescope.actions').close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        vim.cmd(string.format("%s %s", "edit", j.path))
      end
    end
  else
    require('telescope.actions').select_default(prompt_bufnr)
  end
end


telescope.setup({
  defaults = {
    path_display = { 'truncate' },
    mappings = {
      i = {
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,
        ["<CR>"] = select_one_or_multi,
        ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-S-d>"] = actions.delete_buffer,
      },
    },
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
      hijack_netrw = false,
    }
  }
})

-- Enable extensions if installed
telescope.load_extension('fzf')
telescope.load_extension('live_grep_args')
telescope.load_extension('noice')


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
vim.keymap.set('n', '<leader>oo', telescope_builtin.oldfiles, { desc = '[?] Find recently opened files' })
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
vim.keymap.set('n', '<leader>sc', '<cmd>lua require("telescope.builtin").live_grep({ glob_pattern = "!{spec,test}"})<CR>',
  { desc = "Live Grep Code" })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eys' })
vim.keymap.set('n', '<leader>sm', require('telescope.builtin').man_pages, { desc = '[S]earch [M]an page' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sR', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').lsp_references, { desc = '[F]ind [R]eferences' })

vim.keymap.set("n", "<leader>t", ":Telescope <CR>")
