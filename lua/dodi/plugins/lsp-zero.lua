local lsps = {
  -- LSP
  "awk_ls",
  "bashls",
  "cssls",
  "cssmodules_ls",
  "dockerls",
  "emmet_language_server",
  "eslint",
  "html",
  "intelephense",
  "jqls",
  "jsonls",
  "lua_ls",
  "marksman",
  "prismals",
  "pylsp",
  "rust_analyzer",
  "svelte",
  "tailwindcss",
  "tsserver",
  "vimls",
  "yamlls",

  -- Linter
  "eslint_d",
  "luacheck",
  "markdownlint",
  "phpcs",
  "proselint",
  "yamllint",

  -- Formatter
  "black",
  "beautysh",
  "jq",
  "php-cs-fixer",
  "prettierd",
  "sqlfmt",
  "stylua",
  "yamlfix",
}

return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      local lsp_zero = require("lsp-zero")

      lsp_zero.on_attach(function(_, bufnr)
        lsp_zero.default_keymaps({
          buffer = bufnr,
          preserve_mappings = false,
          exclude = { "<F2>", "<F3>", "<F4>", "gl", "[d", "]d" },
        })
        lsp_zero.buffer_autoformat()

        vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Perform code action", buffer = bufnr })
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = bufnr })
        vim.keymap.set("n", "<leader>x", vim.lsp.buf.format, { desc = "Format the file", buffer = bufnr })
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic", buffer = bufnr })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic", buffer = bufnr })
      end)

      local lua_opts = lsp_zero.nvim_lua_ls()
      require("lspconfig").lua_ls.setup(lua_opts)

      local cmp = require('cmp')


      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),
        preselect = 'item',
        completion = {
          completeopt = 'menu,menuone,noinsert'
        },
      })

      require("mason").setup({})
      require("mason-tool-installer").setup({ ensure_installed = lsps })
      require("mason-lspconfig").setup({
        handlers = {
          lsp_zero.default_setup,
          eslint = function()
            require("lspconfig").eslint.setup({
              on_attach = function(_, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                  command = "EslintFixAll",
                  buffer = bufnr,
                })
              end,
            })
          end
        }
      })
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
    }
  },
}
