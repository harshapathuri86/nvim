local loaded, onedarkpro = pcall(require, "onedarkpro")
if not loaded then
    return
end

onedarkpro.setup({
    styles = {
      types = "italic",
      methods = "underline",
      numbers = "NONE",
      strings = "NONE",
      comments = "italic",
      keywords = "NONE",
      constants = "bold",
      functions = "italic",
      operators = "NONE",
      variables = "NONE",
      parameters = "NONE",
      conditionals = "italic",
      virtual_text = "NONE",
    }

})

vim.cmd.colorscheme 'onedark_dark'
vim.cmd("hi PmenuSel guibg = #121121")
