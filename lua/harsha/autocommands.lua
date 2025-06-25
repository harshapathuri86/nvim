local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})


-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('ziggy', {}),
    pattern = 'ziggy',
    callback = function()
        vim.lsp.start {
            name = 'Ziggy LSP',
            cmd = { 'ziggy', 'lsp' },
            root_dir = vim.uv.cwd(),
            flags = { exit_timeout = 1000 },
        }
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('ziggy_schema', {}),
    pattern = 'ziggy_schema',
    callback = function()
        vim.lsp.start {
            name = 'Ziggy LSP',
            cmd = { 'ziggy', 'lsp', '--schema' },
            root_dir = vim.uv.cwd(),
            flags = { exit_timeout = 1000 },
        }
    end,
})



--[[ cursor_line_group = vim.api.nvim_create_augroup("cursor_line", { clear = true })
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
}) ]]

-- buf_enter_group = vim.api.nvim_create_augroup("buf_enter", { clear = true })
-- vim.api.nvim_create_autocmd("BufEnter", {
--     pattern = "*",
--     group = buf_enter_group,
--     callback = function()
--         vim.opt_local.formatoptions:remove({ "c", "r", "o" })
--     end,
-- })
