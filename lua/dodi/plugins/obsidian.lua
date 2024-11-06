return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    keys = {
      { "<leader>on", "<cmd>ObsidianToday<cr>", desc = "Open today's daily note" },
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
          path = "~/Documents/vaults/personal",
        },
      },
      open_notes_in = "hsplit",
      ui = {
        checkboxes = {
          [" "] = { order = 1001, char = "󰄱", hl_group = "ObsidianTodo" },
          ["/"] = { order = 1002, char = "⧗", hl_group = "ObsidianProgress" },
          ["x"] = { order = 1003, char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        },
        hl_groups = {
          ObsidianTodo = { bold = true, fg = "#f78c6c" },
          ObsidianDone = { bold = true, fg = "#89ddff" },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5370" },
          ObsidianBullet = { bold = true, fg = "#89ddff" },
          ObsidianRefText = { underline = true, fg = "#c792ea" },
          ObsidianProgress = { bold = true, fg = "#c792ea" },
          ObsidianExtLinkIcon = { fg = "#c792ea" },
          ObsidianTag = { italic = true, fg = "#89ddff" },
          ObsidianBlockID = { italic = true, fg = "#89ddff" },
          ObsidianHighlightText = { bg = "#75662e" },
        },
      },
    },
  },
}
