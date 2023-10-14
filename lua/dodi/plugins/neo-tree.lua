return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Neotree" },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle reveal<cr>", silent = true, desc = "Open file explorer at current buffer" },
      { "<leader>E", "<cmd>Neotree toggle<cr>", silent = true, desc = "Open file explorer in root dir" },
    },
    opts = {
      enable_git_status = false,
      enable_diagnostics = false,
      enable_normal_mode_for_inputs = true,
      window = {
        position = "current",
      },
    },
  },
}
