return {

  { 'lewis6991/gitsigns.nvim' },

  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
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
      -- vim.api.nvim_set_hl(0, 'Comment', { italic = true })
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        -- icons_enabled = false,
        theme = 'horizon',
        -- section_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
      },
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      show_end_of_line = true,
      show_current_context = true,
      -- show_current_context_start = true,
      show_trailing_blankline_indent = false,
      space_char_blankline = " ",
    },
  },

}
