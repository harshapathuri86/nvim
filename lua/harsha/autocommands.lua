highlight_yank_group = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    group = highlight_yank_group,
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
    end,
})

cursor_line_group = vim.api.nvim_create_augroup("cursor_line", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    group = cursor_line_group,
    callback = function()
        vim.opt_local.cursorline = true
    end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    group = cursor_line_group,
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

buf_enter_group = vim.api.nvim_create_augroup("buf_enter", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    group = buf_enter_group,
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})
