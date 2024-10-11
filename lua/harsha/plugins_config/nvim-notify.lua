local notify = require("notify")

notify.setup({
    timeout = 20,
    max_height = function()
        return math.floor(vim.o.lines * 0.75)
    end,
    max_height = function()
        return math.floor(vim.o.columns * 0.75)
    end
})


local dismiss_notifications = function()
    require("notify").dismiss({ silient = true, pending = true })
end

vim.keymap.set("n", "<leader>dm",
    dismiss_notifications,
    { desc = "Dismiss Notifications" }
)
