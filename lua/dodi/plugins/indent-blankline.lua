return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufNewFile", "BufReadPre" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
        },
      },
    },
    main = "ibl",
  },
}
