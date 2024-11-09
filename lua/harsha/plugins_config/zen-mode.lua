if pcall(require, "zen-mode") then
    require("zen-mode").setup({
        plugins = {
            kitty = {
                enabled = true,
            },
            alacritty = {
                enabled = true,
            }
        }
    })

    vim.keymap.set("n", "<leader>zz", ":ZenMode<CR>", { noremap = true, silent = true })
end
