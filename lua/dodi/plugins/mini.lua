return {
  {
    "echasnovski/mini.pairs",
    version = false,
    event = "InsertEnter",
    config = true,
  },
  {
    "echasnovski/mini.surround",
    version = false,
    event = { "BufNewFile", "BufReadPost" },
    config = true,
  },
  {
    "echasnovski/mini.comment",
    version = false,
    event = { "BufNewFile", "BufReadPost" },
    opts = {
      options = {
        ignore_blank_line = true,
      },
      mappings = {
        comment = "m",
        comment_line = "mm",
        textobject = "m",
      },
    },
  },
}
