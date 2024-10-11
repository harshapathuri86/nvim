return {
  'ellisonleao/carbon-now.nvim',
  'wakatime/vim-wakatime',

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },

  -- Lua
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim",
    }
  },

  {
    "nacro90/numb.nvim",
    opts = {}
  }
}
