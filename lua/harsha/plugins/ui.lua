return {

  { 'lewis6991/gitsigns.nvim' },

  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
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

  { 'romgrk/barbar.nvim',     dependencies = 'nvim-tree/nvim-web-devicons' },

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
