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
    "echasnovski/mini.clue",
    version = false,
    event = "VeryLazy",
    config = function()
      local miniclue = require("mini.clue")
      miniclue.setup({
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },

        window = {
          delay = 200,
          config = {
            width = "auto",
          },
        },

        clues = {
          { mode = "n", keys = "<leader>h", desc = "+Harpoon" },
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      })
    end,
  },
}
