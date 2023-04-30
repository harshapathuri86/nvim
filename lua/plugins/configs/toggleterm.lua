vim.keymap.set({ 'n', 't' }, '<A-i>', "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floatting terminal" })
vim.keymap.set({ 'n', 't' }, '<A-j>', "<cmd>ToggleTerm direction=horizontal size=12<cr>", { desc = "Toggle horizantal terminal" })
vim.keymap.set({ 'n', 't' }, '<A-l>', "<cmd>ToggleTerm direction=vertical size=50<cr>", { desc = "Toggle horizantal terminal" })
vim.keymap.set({ 'n', 't' }, '<A-t>', "<cmd>ToggleTerm direction=tab<cr>", { desc = "Toggle terminal in new tab" })
