do -- foundation
  vim.loader.enable()

  vim.g.mapleader = " "
  vim.g.maplocalleader = ","

  vim.g.have_nerd_font = false

  vim.o.number = true
  vim.o.relativenumber = true
  vim.o.mouse = "a"
  vim.o.breakindent = true
  vim.o.undofile = true
  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.signcolumn = "yes"
  vim.o.updatetime = 250
  vim.o.timeoutlen = 750
  vim.o.splitright = true
  vim.o.splitbelow = true
  vim.o.list = true
  vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
  vim.o.inccommand = "split"
  vim.o.cursorline = true
  vim.o.scrolloff = 0
  vim.o.confirm = true

  vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

  vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },
    virtual_text = true,
  })

  vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("dodi-highlight-yank", { clear = true }),
    callback = function()
      vim.hl.on_yank()
    end,
  })
end

local function gh(repo)
  return "https://github.com/" .. repo
end

do -- plugins
  do -- harpoon
    vim.pack.add({
      { src = gh("nvim-lua/plenary.nvim") },
      { src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },
    })

    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_ui_close = true,
        save_on_toggle = true,
      },
    })

    local harpoon_extensions = require("harpoon.extensions")
    harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

    vim.keymap.set("n", "<leader>hg", function()
      harpoon:list():add()
    end, { desc = "Add mark" })
    vim.keymap.set("n", "<leader>he", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Open quick menu" })
    for idx, key in pairs({ "a", "r", "s", "t", "z", "x", "c", "d", "v" }) do
      vim.keymap.set("n", "<leader>h" .. key, function()
        harpoon:list():select(idx)
      end, { desc = "Navigate to " .. idx })
    end
  end

  vim.pack.add({ gh("rmagatti/auto-session") })
  require("auto-session").setup()

  do -- mini
    vim.pack.add({ gh("nvim-mini/mini.nvim") })
    require("mini.extra").setup()
    require("mini.align").setup()
    require("mini.move").setup()
    require("mini.operators").setup()
    require("mini.pairs").setup()
    require("mini.splitjoin").setup({ mappings = { toggle = "g<s-s>" } })
    require("mini.surround").setup()
    require("mini.bracketed").setup()
    require("mini.icons").setup()
    do -- files
      require("mini.files").setup({
        mappings = { go_in_plus = "<enter>" },
        windows = { preview = true, width_preview = 80 },
      })
      vim.keymap.set("n", "<leader>e", function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
      end, { desc = "Open file explorer" })
      vim.keymap.set("n", "<leader><s-e>", function()
        require("mini.files").open(nil, false)
      end, { desc = "Open file explorer in root" })
    end
    do -- pick
      require("mini.pick").setup()

      require("mini.pick").registry.dir = function()
        return require("mini.pick").start({
          source = {
            name = "Choose a directory",
            items = function()
              return vim.fn.systemlist({ "fd", "--type", "d" })
            end,
            choose = function() end,
          },
        })
      end

      vim.keymap.set("n", "<leader>f", function()
        require("mini.pick").builtin.files({ tool = "git" })
      end)
      vim.keymap.set("n", "<leader><s-f>", function()
        local dir = require("mini.pick").registry.dir()
        if dir then
          require("mini.pick").builtin.files(nil, { source = { cwd = dir } })
        end
      end)
      vim.keymap.set("n", "<leader>/", function()
        require("mini.pick").builtin.grep_live()
      end)
      vim.keymap.set("n", "<leader>?", function()
        local dir = require("mini.pick").registry.dir()
        if dir then
          require("mini.pick").builtin.grep_live(nil, { source = { cwd = dir } })
        end
      end)
      vim.keymap.set("n", "<leader>.", function()
        require("mini.pick").builtin.cli({ command = { "rg", "--files", "-g", "**/.*" } })
      end)
      vim.keymap.set("n", "<leader><leader>f", function()
        require("mini.pick").builtin.cli({
          command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git", "--glob", "!**/node_modules" },
        })
      end)
      vim.keymap.set("n", "<leader>k", function()
        require("mini.extra").pickers.keymaps()
      end)
      vim.keymap.set("n", "<leader>gs", function()
        require("mini.extra").pickers.git_hunks()
      end)
      vim.keymap.set("n", "<leader>d", function()
        require("mini.extra").pickers.diagnostic({ scope = "current" })
      end)
      vim.keymap.set("n", "<leader><s-d>", function()
        require("mini.extra").pickers.diagnostic({ scope = "all" })
      end)
      vim.keymap.set("n", "<leader>s", function()
        require("mini.extra").pickers.treesitter()
      end)
    end
  end
end

do -- lsp
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("dodi-lsp-attach", { clear = true }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client then
        return
      end

      local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end

      if client:supports_method("textDocument/rename", event.buf) then
        map("<leader>r", vim.lsp.buf.rename, "Rename")
      end
      if client:supports_method("textDocument/codeAction", event.buf) then
        map("<leader>a", vim.lsp.buf.code_action, "Code actions", { "n", "x" })
      end
      if client:supports_method("textDocument/declaration", event.buf) then
        map("gd", vim.lsp.buf.declaration, "Goto declaration")
      end
      if client:supports_method("textDocument/formatting", event.buf) then
        map("<leader>x", vim.lsp.buf.format, "Format buffer")
      end
      if client:supports_method("textDocument/rangeFormatting", event.buf) then
        map("<leader>x", vim.lsp.buf.format, "Format selection", "x")
      end
      if client:supports_method("textDocument/inlayHint", event.buf) then
        map("<leader>t", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, "Toggle inlay hints")
      end
    end,
  })

  local servers = {
    gopls = {},
    ts_ls = {},
    stylua = {},
    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath("config") and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            version = "LuaJIT",
            path = { "lua/?.lua", "lua/?/init.lua" },
          },
          workspace = {
            checkThirdParty = false,
            library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
              "${3rd}/luv/library",
              "${3rd}/busted/library",
            }),
          },
        })
      end,
      ---@type lspconfig.settings.lua_ls
      settings = {
        Lua = {
          format = { enable = false },
        },
      },
    },
  }

  vim.pack.add({
    gh("neovim/nvim-lspconfig"),
    gh("mason-org/mason.nvim"),
    gh("mason-org/mason-lspconfig.nvim"),
    gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
  })

  require("mason").setup()
  require("mason-tool-installer").setup({ ensure_installed = vim.tbl_keys(servers) })

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

do -- snippets & completions
  vim.pack.add({ { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2.*") } })
  require("luasnip").setup({})

  vim.pack.add({ gh("rafamadriz/friendly-snippets") })
  require("luasnip.loaders.from_vscode").lazy_load()

  vim.pack.add({ { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") } })
  require("blink.cmp").setup({
    keymap = { preset = "default" },
    appearance = { nerd_font_variant = "mono" },
    completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
    sources = { default = { "lsp", "path", "snippets" } },
    snippets = { preset = "luasnip" },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
  })
end

do -- treesitter
  vim.pack.add({ { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" } })

  local parsers = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc" }
  require("nvim-treesitter").install(parsers)

  local available_parsers = require("nvim-treesitter").get_available()
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local buf, filetype = args.buf, args.match
      local language = vim.treesitter.language.get_lang(filetype)
      if not language then
        return
      end
      local installed_parsers = require("nvim-treesitter").get_installed("parsers")

      local function try_attach()
        if not vim.treesitter.language.add(language) then
          return
        end
        vim.treesitter.start(buf, language)
        local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil
        if has_indent_query then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      if vim.tbl_contains(installed_parsers, language) then
        try_attach()
      elseif vim.tbl_contains(available_parsers, language) then
        require("nvim-treesitter").install(language):await(try_attach)
      else
        try_attach()
      end
    end,
  })
end

do -- tmp
  vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
  vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
  vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
  vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

  vim.opt.tabstop = 2 -- Visual width of a tab
  vim.opt.softtabstop = 2 -- The number of spaces inserted when hitting Tab
  vim.opt.shiftwidth = 2 -- The size of an "indent"
  vim.opt.expandtab = true -- Use spaces instead of tabs
end
