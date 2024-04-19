return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    keys = {
      { "<leader>oo", "<cmd>ObsidianToday<cr>", desc = "Open today's daily note" },
      { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Open yesterday's daily note" },
      { "<leader>ot", "<cmd>ObsidianTomorrow<cr>", desc = "Open tomorrow's daily note" },
      { "<leader>oc", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Cycle through checkbox options" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      templates = {
        subdir = "_templates",
      },
      daily_notes = {
        folder = "daily",
        template = "daily.md",
      },
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
      },
    },
  },
}
