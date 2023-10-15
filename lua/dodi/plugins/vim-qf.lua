return {
  {
    "romainl/vim-qf",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "]q", "<Plug>(qf_qf_next)", { silent = true, desc = "Next quickfix item" })
      vim.keymap.set("n", "[q", "<Plug>(qf_qf_prev)", { silent = true, desc = "Prev quickfix item" })
      vim.keymap.set("n", "<leader>q", "<Plug>(qf_qf_toggle_stay)", { silent = true, desc = "Toggle quickfix window" })
    end,
  },
}
