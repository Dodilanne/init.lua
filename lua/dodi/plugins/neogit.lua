return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    keys = {
      {
        "<leader>gn",
        function()
          require("neogit").open()
        end,
        desc = "Open NeoGit",
      },
    },
    config = true,
  },
}
