return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    opts = {
      terminal = {
        snacks_win_opts = {
          position = "right",
          width = 0.4,
          height = 1.0,
          border = "rounded",
          keys = {
            claude_hide = {
              "<C-h>",
              function(self)
                self:hide()
              end,
              mode = "t",
              desc = "Hide",
            },
          },
        },
      },
    },
    keys = {
      { "<leader>i", nil, desc = "AI/Claude Code" },
      { "<leader>ic", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>if", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ir", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>iC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>im", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ib", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>is", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>is",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
      },
      -- Diff management
      { "<leader>ia", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>id", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
