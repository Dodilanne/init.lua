return {
  "tpope/vim-fugitive",
  cmd = { "G", "Git" },
  keys = {
    { "<leader>ge", ":Git ", desc = "Enter a git command" },
    { "<leader>ga", ":Git add .<cr>", desc = "Stage all changes" },
    { "<leader>gc", ':Git commit -m""<Left>', desc = "Quick commit" },
    { "<leader>gp", ":Git push<cr>", desc = "Push" },
  },
}
