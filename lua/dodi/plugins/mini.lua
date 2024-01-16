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
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
        ignore_blank_line = true,
      },
      mappings = {
        comment = "m",
        comment_line = "mm",
        comment_visual = "m",
        textobject = "m",
      },
    },
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = { enable_autocmd = false },
      },
    },
  },
}
