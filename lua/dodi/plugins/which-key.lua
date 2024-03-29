return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      wk.setup()
      wk.register({
        ["<leader>"] = {
          h = { name = "+Harpoon" },
          g = { name = "+Git" },
        },
      })
    end,
  },
}
