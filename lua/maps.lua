vim.keymap.set('n', 'ZZ', ":wq <Enter>", { desc = "save and exit" })

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
vim.keymap.set('t', '<leader>h', [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set('t', '<leader>j', [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set('t', '<leader>k', [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set('t', '<leader>l', [[<Cmd>wincmd l<CR>]], opts)
vim.keymap.set('t', '<leader>w', [[<C-\><C-n><C-w>]], opts)

-- use leader y/p to copy/paste in OS clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { silent = true })

-- [[ Basic Keymaps ]]

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- change focus between panes
-- vim.keymap.set('n', '<leader>h', "<C-w>h", { desc = "window left" })
-- vim.keymap.set('n', '<leader>l', "<C-w>l", { desc = "window right" })
-- vim.keymap.set('n', '<leader>j', "<C-w>j", { desc = "window down" })
-- vim.keymap.set('n', '<leader>k', "<C-w>k", { desc = "window up" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
