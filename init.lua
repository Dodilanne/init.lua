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
  vim.o.scrolloff = 4
  vim.o.confirm = true
  vim.o.showmode = false

  vim.opt.tabstop = 4
  vim.opt.softtabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.expandtab = true

  vim.keymap.set("n", "<leader>tn", "<cmd>tabnext<cr>", { desc = "Next tab" })
  vim.keymap.set("n", "<leader>tp", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
  vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab" })

  vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
  vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

  vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Write file" })
  vim.keymap.set("n", "<leader>z", "<cmd>wa<cr><cmd>q<cr>", { desc = "Write all then quit" })

  vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

  vim.keymap.set({ "n", "v", "i" }, "<C-b>", "<C-a>", { desc = "Increment number" })

  vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })
  vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
  vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

  vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines keeping cursor position" })
  vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
  vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
  vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result centered" })
  vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result centered" })

  vim.keymap.set("n", "<leader>q", function()
    for _, win in pairs(vim.fn.getwininfo()) do
      if win["quickfix"] == 1 then
        vim.cmd("cclose")
        return
      end
    end
    if vim.tbl_isempty(vim.fn.getqflist()) then
      print("quickfix list is empty")
    else
      vim.cmd("copen")
    end
  end, { desc = "Toggle quickfix list" })

  vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },
    virtual_text = true,
  })

  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("dodi-highlight-yank", { clear = true }),
    callback = function()
      vim.hl.on_yank()
    end,
  })
end

local function gh(repo)
  return "https://github.com/" .. repo
end

do -- tuis
  local function open_tui(cmd)
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = vim.o.columns - 2,
      height = vim.o.lines - 2,
      row = 1,
      col = 1,
      style = "minimal",
      border = "rounded",
    })
    vim.fn.jobstart(cmd, {
      term = true,
      on_exit = function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
        if vim.api.nvim_buf_is_valid(buf) then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end,
    })

    vim.cmd("startinsert")
  end

  vim.keymap.set("n", "<leader>gu", function()
    open_tui("lazygit")
  end, { desc = "Open lazygit" })
end

do -- plugins
  vim.pack.add({ gh("christoomey/vim-tmux-navigator") })

  vim.pack.add({ gh("tpope/vim-abolish") })

  do -- guess-indent
    vim.pack.add({ gh("nmac427/guess-indent.nvim") })
    require("guess-indent").setup({})
  end

  do -- spectre
    vim.pack.add({
      { src = gh("nvim-lua/plenary.nvim") },
      { src = gh("nvim-pack/nvim-spectre") },
    })
    require("spectre").setup({
      replace_engine = { sed = { cmd = "sed", args = { "-i", "", "-E" } } },
    })
    vim.keymap.set("n", "<leader><s-r>", function()
      require("spectre").toggle()
    end, { desc = "Search and replace" })
  end

  do -- obsidian
    vim.pack.add({
      { src = gh("nvim-lua/plenary.nvim") },
      { src = gh("epwalsh/obsidian.nvim") },
    })

    require("obsidian").setup({
      templates = { subdir = "_templates" },
      daily_notes = { folder = "daily", template = "daily.md" },
      workspaces = { { name = "personal", path = "~/Documents/vaults/personal" } },
      open_notes_in = "hsplit",
      ui = { enable = false },
    })

    vim.keymap.set("n", "<leader>on", "<cmd>ObsidianToday<cr>", { desc = "Open today's daily note" })
    vim.keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>", { desc = "Open yesterday's daily note" })
    vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTomorrow<cr>", { desc = "Open tomorrow's daily note" })
    vim.keymap.set("n", "<leader>oc", "<cmd>ObsidianToggleCheckbox<cr>", { desc = "Cycle through checkbox options" })
  end

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
    end, { desc = "Harpoon add file" })
    vim.keymap.set("n", "<leader>he", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon menu" })
    for idx, key in pairs({ "a", "r", "s", "t", "z", "x", "c", "d", "v" }) do
      vim.keymap.set("n", "<leader>h" .. key, function()
        harpoon:list():select(idx)
      end, { desc = "Harpoon select " .. idx })
    end
  end

  do -- supermaven
    vim.pack.add({ gh("supermaven-inc/supermaven-nvim") })
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<m-n>",
        clear_suggestion = "<m-i>",
        accept_word = "<m-h>",
      },
      condition = function()
        return false
      end,
    })
  end

  do -- auto-session
    vim.pack.add({ gh("rmagatti/auto-session") })
    require("auto-session").setup()
  end

  do -- undotree
    vim.pack.add({ gh("mbbill/undotree") })
    vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Toggle undo tree" })
    vim.g.undotree_SplitWidth = 40
    vim.g.undotree_WindowLayout = 3
    vim.g.undotree_SetFocusWhenToggle = 1
  end

  do -- mini
    vim.pack.add({ gh("nvim-mini/mini.nvim") })
    require("mini.extra").setup()
    require("mini.align").setup()
    require("mini.operators").setup()
    require("mini.pairs").setup()
    require("mini.splitjoin").setup({ mappings = { toggle = "g<s-s>" } })
    require("mini.surround").setup()
    require("mini.bracketed").setup()
    require("mini.icons").setup()
    require("mini.jump").setup()
    require("mini.statusline").setup()
    require("mini.clue").setup({
      triggers = {
        { mode = "n", keys = "g" },
        { mode = "n", keys = "z" },
        { mode = "n", keys = "<leader>" },
        { mode = "n", keys = "<C-w>" },
        { mode = "i", keys = "<C-x>" },
        { mode = "c", keys = "<C-r>" },
        { mode = "n", keys = '"' },
        { mode = "i", keys = "<C-r>" },
      },
      clues = {
        { mode = "n", keys = "<leader>g", desc = "+Git" },
        { mode = "n", keys = "<leader>h", desc = "+Harpoon" },
        require("mini.clue").gen_clues.g(),
        require("mini.clue").gen_clues.builtin_completion(),
        require("mini.clue").gen_clues.marks(),
        require("mini.clue").gen_clues.square_brackets(),
        require("mini.clue").gen_clues.registers(),
        require("mini.clue").gen_clues.windows(),
        require("mini.clue").gen_clues.z(),
      },
      window = { delay = 500, config = { width = "auto" } },
    })

    do -- files
      require("mini.files").setup({
        mappings = { go_in_plus = "<enter>" },
        windows = { preview = true, width_preview = 80 },
      })
      vim.keymap.set("n", "<leader>e", function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
      end, { desc = "File explorer" })
      vim.keymap.set("n", "<leader><s-e>", function()
        require("mini.files").open(nil, false)
      end, { desc = "File explorer (cwd)" })
    end

    do -- pick
      require("mini.pick").setup({ mappings = { mark_all = "<M-a>" } })

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
      end, { desc = "Pick files (git)" })
      vim.keymap.set("n", "<leader><s-f>", function()
        local dir = require("mini.pick").registry.dir()
        if dir then
          require("mini.pick").builtin.files(nil, { source = { cwd = dir } })
        end
      end, { desc = "Pick files in directory" })
      vim.keymap.set("n", "<leader>/", function()
        require("mini.pick").builtin.grep_live()
      end, { desc = "Grep live" })
      vim.keymap.set("n", "<leader>?", function()
        local dir = require("mini.pick").registry.dir()
        if dir then
          require("mini.pick").builtin.grep_live(nil, { source = { cwd = dir } })
        end
      end, { desc = "Grep live in directory" })
      vim.keymap.set("n", "<leader>.", function()
        require("mini.pick").builtin.cli({ command = { "rg", "--files", "-g", "**/.*" } })
      end, { desc = "Pick dotfiles" })
      vim.keymap.set("n", "<leader><leader>f", function()
        require("mini.pick").builtin.cli({
          command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git", "--glob", "!**/node_modules" },
        })
      end, { desc = "Pick all files (no ignore)" })
      vim.keymap.set("n", "<leader>m", function()
        require("mini.pick").builtin.help()
      end, { desc = "Pick help tags" })
      vim.keymap.set("n", "<leader>k", function()
        require("mini.extra").pickers.keymaps()
      end, { desc = "Pick keymaps" })
      vim.keymap.del("n", "grr")
      vim.keymap.set("n", "gr", function()
        require("mini.extra").pickers.lsp({ scope = "references" })
      end, { desc = "Pick symbol references" })
      vim.keymap.set("n", "<leader>gh", function()
        require("mini.extra").pickers.git_hunks()
      end, { desc = "Pick git hunks" })
      vim.keymap.set("n", "<leader>d", function()
        require("mini.extra").pickers.diagnostic({ scope = "current" })
      end, { desc = "Pick diagnostics (buffer)" })
      vim.keymap.set("n", "<leader><s-d>", function()
        require("mini.extra").pickers.diagnostic({ scope = "all" })
      end, { desc = "Pick diagnostics (all)" })
      vim.keymap.set("n", "<leader>ts", function()
        require("mini.extra").pickers.treesitter()
      end, { desc = "Pick treesitter symbols" })
      vim.keymap.set("n", "<leader>s", function()
        require("mini.extra").pickers.lsp({ scope = "document_symbol" })
      end, { desc = "Pick document symbols" })
      vim.keymap.set("n", "<leader><s-s>", function()
        require("mini.extra").pickers.lsp({ scope = "workspace_symbol_live" })
      end, { desc = "Pick workspace symbols" })
      vim.keymap.set("n", "<leader>i", function()
        require("mini.extra").pickers.lsp({ scope = "implementation" })
      end, { desc = "Pick implementation" })
    end
  end

  do -- diff
    vim.pack.add({ gh("sindrets/diffview.nvim") })
    vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview open" })
  end

  do -- git
    vim.pack.add({ gh("lewis6991/gitsigns.nvim") })
    require("gitsigns").setup({
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]h", function()
          if vim.wo.diff then
            return "]h"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Next hunk" })

        map("n", "[h", function()
          if vim.wo.diff then
            return "[h"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Prev hunk" })

        map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
        map("v", "<leader>gs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage selection" })
        map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
        map("v", "<leader>gr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset selection" })
        map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame line" })
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    })
  end

  do -- colorscheme
    vim.pack.add({ gh("webhooked/kanso.nvim") })
    require("kanso").setup({
      transparent = true,
      minimal = true,
      foreground = { dark = "saturated", light = "saturated" },
      background = { dark = "zen", light = "pearl" },
    })
    vim.cmd("colorscheme kanso")
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

      local map = function(keys, func, mode, desc)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
      end

      if client:supports_method("textDocument/rename", event.buf) then
        map("<leader>r", vim.lsp.buf.rename, "n", "LSP rename")
      end
      if client:supports_method("textDocument/codeAction", event.buf) then
        map("<leader>a", vim.lsp.buf.code_action, { "n", "x" }, "LSP code action")
      end
      if client:supports_method("textDocument/definition", event.buf) then
        map("gd", vim.lsp.buf.definition, "n", "LSP go to definition")
      end
      if client:supports_method("textDocument/formatting", event.buf) then
        map("<leader>x", vim.lsp.buf.format, "n", "LSP format")
      end
      if client:supports_method("textDocument/rangeFormatting", event.buf) then
        map("<leader>x", vim.lsp.buf.format, "x", "LSP range format")
      end
      if client:supports_method("textDocument/inlayHint", event.buf) then
        map("<leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, "n", "Toggle inlay hints")
      end
    end,
  })

  local servers = {
    ts_ls = {},
    biome = {},
    denols = {},
    emmet_language_server = {},
    eslint = {},
    html = {},
    rust_analyzer = {},
    gopls = {},
    stylua = {},
    cssls = {},
    yamlls = {},
    templ = {},
    ols = {},
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
    sources = { default = { "lsp", "buffer", "snippets", "path" } },
    snippets = { preset = "luasnip" },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
  })
end

do -- debug logging
  local debug_log = function(yank_motion, mode)
    if vim.bo.filetype == "lua" then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('"ny' .. yank_motion .. 'oprint("<C-r>n " .. <C-r>n)<Esc>', true, false, true))
    elseif vim.bo.filetype == "go" then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('"ny' .. yank_motion .. 'oprintln("<C-r>n", <C-r>n)<Esc>', true, false, true))
    elseif vim.bo.filetype == "dart" then
      if mode == "v" then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('"ny' .. yank_motion .. "oprint('<C-r>n: ${<C-r>n}');<Esc>", true, false, true))
      else
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('"ny' .. yank_motion .. "oprint('<C-r>n: $<C-r>n');<Esc>", true, false, true))
      end
    else
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('"ny' .. yank_motion .. 'oconsole.log("<C-r>n", <C-r>n);<Esc>', true, false, true))
    end
  end

  vim.keymap.set("n", "<leader>l", function()
    debug_log("iw", "n")
  end, { desc = "Add console log on next line" })
  vim.keymap.set("v", "<leader>l", function()
    debug_log("", "v")
  end, { desc = "Add console log on next line" })
  vim.keymap.set(
    "n",
    "<leader>L",
    [["nyiwoconsole.log("<C-r>n", JSON.stringify(<C-r>n, null, 2));<Esc>]],
    { desc = "Add stringified console log on next line" }
  )
  vim.keymap.set(
    "v",
    "<leader>L",
    [["nyoconsole.log("<C-r>n", JSON.stringify(<C-r>n, null, 2));<Esc>]],
    { desc = "Add stringified console log on next line" }
  )
end

do -- treesitter
  vim.pack.add({
    { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
    { src = gh("nvim-treesitter/nvim-treesitter-context") },
  })

  require("treesitter-context").setup({
    max_lines = 5,
    mode = "cursor",
    multiline_threshold = 1,
  })

  local parsers = {
    "nu",
    "templ",
    "javascript",
    "jsdoc",
    "typescript",
    "tsx",
    "markdown",
    "markdown_inline",
    "json",
    "svelte",
    "css",
    "awk",
    "gitignore",
    "jq",
    "regex",
    "ron",
    "rust",
    "toml",
    "sql",
    "xml",
    "go",
    "python",
    "bash",
    "c",
    "diff",
    "html",
    "lua",
    "luadoc",
    "query",
    "vim",
    "vimdoc",
  }
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
