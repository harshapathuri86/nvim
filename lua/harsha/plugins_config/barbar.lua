if not pcall(require, "bufferline") then
    return
end

require("bufferline").setup({
    animation = false,
    auto_hide = false,
    tabpages = true,
    closable = true,
    clickable = true,
})

-- Navigation
vim.keymap.set("n", "<Tab>", "<Cmd>BufferNext<CR>")
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>")
vim.keymap.set("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { silent = true })
vim.keymap.set("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { silent = true })
vim.keymap.set("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { silent = true })
vim.keymap.set("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { silent = true })
vim.keymap.set("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { silent = true })
vim.keymap.set("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { silent = true })
vim.keymap.set("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { silent = true })
vim.keymap.set("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { silent = true })
vim.keymap.set("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { silent = true })
vim.keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", { silent = true })

-- Utils
vim.keymap.set("n", "<A-w>", "<Cmd>BufferClose<CR>", { silent = true })
vim.keymap.set("n", "<A-p>", "<Cmd>BufferPin<CR>", { silent = true })


vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>', { silent = true })
vim.keymap.set('n', '<C-c>', '<Cmd>BufferClose<CR>', { silent = true })
