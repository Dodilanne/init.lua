return {
  {
    "ggandor/flit.nvim",
    event = { "BufNewFile", "BufReadPost" },
    opts = {
      labeled_modes = "n",
      opts = { max_phase_one_targets = true },
    },
    dependencies = {
      "tpope/vim-repeat",
      "ggandor/leap.nvim",
    },
  },
}
