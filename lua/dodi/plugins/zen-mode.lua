return {
  {
    "folke/zen-mode.nvim",
    lazy = true,
    opts = {
      window = {
        width = 150,
      },
      plugins = {
        options = {
          last_status = 3,
        },
      },
    },
    keys = {
      { "<leader>m", "<cmd>ZenMode<cr>", desc = "Toggle zen mode" },
    },
  },
}
