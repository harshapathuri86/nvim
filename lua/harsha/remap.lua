vim.keymap.set("n", "<space>nn", ":set nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<space>bd", ":bdelete<CR>", { silent = true })

-- Navigating through splits
vim.keymap.set("n", "<M-h>", "<C-w><C-h>", { silent = true })
vim.keymap.set("n", "<M-j>", "<C-w><C-j>", { silent = true })
vim.keymap.set("n", "<M-k>", "<C-w><C-k>", { silent = true })
vim.keymap.set("n", "<M-l>", "<C-w><C-l>", { silent = true })

-- Resizing splits
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", { silent = true })


-- Spell checking
vim.keymap.set("n", "<Leader>sc", ":set spell!<CR>", { silent = true })


-- System clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]], { silent = true })
-- vim.keymap.set({ "n", "v" }, "<Leader>p", [["+p]], { silent = true })


-- Centering stuff
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("n", "G", "Gzzzv", { silent = true })
vim.keymap.set("n", "%", "%zzzv", { silent = true })
vim.keymap.set("n", "``", "``zzzv", { silent = true })


-- Moving around in insert mode
vim.keymap.set("i", "<M-h>", "<Left>", { silent = true })
vim.keymap.set("i", "<M-j>", "<Down>", { silent = true })
vim.keymap.set("i", "<M-k>", "<Up>", { silent = true })
vim.keymap.set("i", "<M-l>", "<Right>", { silent = true })


-- Indentation
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- Don't change clipboard while pasting in Select mode
vim.keymap.set("x", "p", "pgvy", { silent = true })


-- Undo-tree
vim.keymap.set("n", "<Leader>uu", ":UndotreeToggle<CR>", { silent = true })

-- Undo on spaces and tabs
vim.keymap.set("i", "<Space>", "<Space><C-g>u", { silent = true })


-- Jump to start/end of line
vim.keymap.set("n", "H", function()
    local current_column = vim.fn.col(".")
    if current_column == 1 then
        vim.cmd.normal("_")
    else
        vim.fn.cursor(".", 1)
    end
end, { silent = true })
vim.keymap.set("n", "L", function()
    local current_column = vim.fn.col(".")
    local end_column = vim.fn.col("$") - 1
    if current_column == end_column then
        vim.cmd.normal("g_")
    else
        vim.fn.cursor(".", end_column)
    end
end, { silent = true })


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

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("n", "J", "mzJ`z", { silent = true })
vim.keymap.set("n", "C-d", "<C-d>zz")
vim.keymap.set("n", "C-u", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })

-- Quickly re-select pasted text
vim.keymap.set("n", "gp", "`[v`]", { silent = true })


vim.keymap.set("v", "//", "y/\\V<C-R>=escape(@\",'/\')<CR><CR>", { silent = true })
