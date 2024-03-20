vim.keymap.set({ 'n', 't' }, '<leader>ff', "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floatting terminal" })
vim.keymap.set({ 'n', 't' }, '<leader>fh', "<cmd>ToggleTerm direction=horizontal size=12<cr>",
    { desc = "Toggle horizantal terminal" })
vim.keymap.set({ 'n', 't' }, '<leader>fv', "<cmd>ToggleTerm direction=vertical size=50<cr>",
    { desc = "Toggle horizantal terminal" })
vim.keymap.set({ 'n', 't' }, '<leader>ft', "<cmd>ToggleTerm direction=tab<cr>", { desc = "Toggle terminal in new tab" })
