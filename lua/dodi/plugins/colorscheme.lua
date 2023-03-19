return {
  -- {
  --   "f-person/auto-dark-mode.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   dependencies = {
  --     "shaunsingh/nord.nvim",
  --   },
  --   config = function()
  --     local auto_dark_mode = require('auto-dark-mode')
  --
  --     auto_dark_mode.setup({
  --       update_interval = 1000,
  --       set_dark_mode = function()
  --         vim.api.nvim_set_option('background', 'dark')
  --         vim.cmd('colorscheme ayu-dark')
  --       end,
  --       set_light_mode = function()
  --         vim.api.nvim_set_option('background', 'light')
  --         vim.cmd('colorscheme ayu-light')
  --       end,
  --     })
  --
  --     auto_dark_mode.init()
  --   end,
  -- },

  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme nord")
    end,
  },

  {"EdenEast/nightfox.nvim"},

  { "Shatur/neovim-ayu" },
}
