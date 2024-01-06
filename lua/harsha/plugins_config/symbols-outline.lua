require("symbols-outline").setup({
    opts = {
        wrap = true,
    }
}
)

vim.keymap.set("n", "<leader>so", "<cmd>SymbolsOutline<CR>", { silent = true })
