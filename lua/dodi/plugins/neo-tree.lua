return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    event = "CmdlineEnter",
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle reveal reveal_force_cwd<cr>", silent = true, desc = "Open file explorer at current buffer" },
      { "<leader>E", "<cmd>Neotree toggle reveal_force_cwd<cr>", silent = true, desc = "Open file explorer in root dir" },
    },
    opts = {
      enable_git_status = false,
      enable_diagnostics = false,
      window = {
        position = "current",
      },
      event_handlers = {
        {
          event = "neo_tree_popup_input_ready",
          ---@param args { bufnr: integer, winid: integer }
          handler = function(args)
            vim.cmd("stopinsert")
            vim.keymap.set("i", "<esc>", vim.cmd.stopinsert, { noremap = true, buffer = args.bufnr })
          end,
        },
      },
    },
  },
}
