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
    },
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = { enable_autocmd = false },
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufNewFile", "BufReadPost" },
    opts = {
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        animation = function()
          return 0
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
