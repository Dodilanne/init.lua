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
  "comment",
  "dockerfile",
  "gitignore",
  "http",
  "jq",
  "json5",
  "jsonc",
  "prisma",
  "hlsl",
  "php",
  "phpdoc",
  "python",
  "regex",
  "scss",
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
      configs.setup({ ensure_installed = parsers })
    end,
  },
}
