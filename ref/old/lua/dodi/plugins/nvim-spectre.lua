return {
  {
    "nvim-pack/nvim-spectre",
    keys = {
      { "<leader>R", "<cmd>lua require('spectre').toggle()<cr>", desc = "Search and replace" },
    },
    opts = {
      replace_engine = {
        sed = {
          cmd = "sed",
          args = {
            "-i",
            "",
            "-E",
          },
        },
      },
    },
  },
}
