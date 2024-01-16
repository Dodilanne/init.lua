local parsers = {
  "lua",
  "vim",
  "vimdoc",
  "javascript",
  "jsdoc",
  "typescript",
  "tsx",
  "html",
  "markdown",
  "markdown_inline",
  "json",
  "svelte",
  "css",
  "bash",
  "awk",
  "gitignore",
  "jq",
  "prisma",
  "php",
  "phpdoc",
  "regex",
  "ron",
  "rust",
  "toml",
  "sql",
  "xml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = parsers,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        autotag = {
          enable = true,
        },
      })
    end,
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufNewFile", "BufReadPre" },
    enabled = true,
    opts = { mode = "cursor", max_lines = 3 },
  },
}
