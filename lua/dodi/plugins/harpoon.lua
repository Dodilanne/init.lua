return {
  {
    "ThePrimeagen/harpoon",
    opts = {
      tabline = false,
      menu = { width = math.ceil(vim.api.nvim_win_get_width(0) * 0.8) },
    },
    config = function(_, opts)
      require("harpoon").setup(opts)
      require("telescope").load_extension("harpoon")
    end,
    keys = {
      { "<leader>hg", function() require("harpoon.mark").add_file() end,        desc = "Add mark", },
      { "<leader>he", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Open quick menu", },
      { "<leader>hf", ":Telescope harpoon marks<cr>",                           desc = "Open mark picker", },
      { "<leader>ha", function() require("harpoon.ui").nav_file(1) end,         desc = "Navigate 1", },
      { "<leader>hr", function() require("harpoon.ui").nav_file(2) end,         desc = "Navigate 2", },
      { "<leader>hs", function() require("harpoon.ui").nav_file(3) end,         desc = "Navigate 3", },
      { "<leader>ht", function() require("harpoon.ui").nav_file(4) end,         desc = "Navigate 4", },
      { "<leader>hz", function() require("harpoon.ui").nav_file(5) end,         desc = "Navigate 5", },
      { "<leader>hx", function() require("harpoon.ui").nav_file(6) end,         desc = "Navigate 6", },
      { "<leader>hc", function() require("harpoon.ui").nav_file(7) end,         desc = "Navigate 7", },
      { "<leader>hd", function() require("harpoon.ui").nav_file(8) end,         desc = "Navigate 8", },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  }
}
