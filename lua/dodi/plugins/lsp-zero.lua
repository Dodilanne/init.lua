local lsps = {
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
  "rust_analyzer",
  "svelte",
  "tailwindcss",
  "tsserver",
  "vimls",
  "yamlls",
}

local linters_and_formatters = {
  -- Linters
  "markdownlint",
  "phpcs",
  "proselint",
  "yamllint",

  -- Formatters
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

      -- Setup default lsp behavior
      lsp_zero.on_attach(function(_, bufnr)
        lsp_zero.default_keymaps({
          buffer = bufnr,
          preserve_mappings = false,
          exclude = { "<F2>", "<F3>", "<F4>", "gl", "[d", "]d" },
        })
        lsp_zero.buffer_autoformat()

        -- Add lsp related keymaps
        vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Perform code action", buffer = bufnr })
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = bufnr })
        vim.keymap.set("n", "<leader>x", vim.lsp.buf.format, { desc = "Format the file", buffer = bufnr })
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic", buffer = bufnr })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic", buffer = bufnr })
      end)

      -- Setup completions
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        preselect = "item",
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        sources = {
          { name = "buffer" },
        },
      })

      -- Setup lsps
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = lsps,
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls({
              on_init = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentFormattingRangeProvider = false
              end,
            })
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
          eslint = function()
            require("lspconfig").eslint.setup({
              on_init = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentFormattingRangeProvider = false
              end,
              on_attach = function(_, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = bufnr,
                  command = "EslintFixAll",
                })
              end,
            })
          end,
        },
      })

      -- Setup linters and formatters
      local null_ls = require("null-ls")
      require("mason-null-ls").setup({
        ensure_installed = linters_and_formatters,
        automatic_installation = false,
        handlers = {},
      })
      null_ls.setup()
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
      "nvimtools/none-ls.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
    },
  },
}
