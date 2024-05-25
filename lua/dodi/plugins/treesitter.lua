local parsers = {
  "lua",
  "templ",
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
  "go",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      local configs = require("nvim-treesitter.configs")

      local list = require("nvim-treesitter.parsers").get_parser_configs()
      list.reason = {
        install_info = {
          url = "https://github.com/reasonml-editor/tree-sitter-reason",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "master",
        },
      }
      list.d2 = {
        install_info = {
          url = "https://github.com/pleshevskiy/tree-sitter-d2",
          revision = "main",
          files = { "src/parser.c", "src/scanner.cc" },
        },
        filetype = "d2",
      }

      configs.setup({
        ensure_installed = parsers,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })

      -- Adds reason as a filetype
      vim.filetype.add({
        extension = {
          re = "reason",
        },
      })
      vim.filetype.add({
        extension = {
          d2 = "d2",
        },
      })

      -- (Sometimes required): Tells neovim to load reason
      vim.treesitter.language.add("reason", { filetype = "reason" })
    end,
  },
  {
    "nvim-treesitter/playground",
    lazy = true,
    config = true,
    cmd = "TSPlaygroundToggle",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufNewFile", "BufReadPre" },
    enabled = true,
    opts = { mode = "cursor", max_lines = 3 },
  },
}
