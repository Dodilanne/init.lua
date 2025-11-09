return {
  {
    "supermaven-inc/supermaven-nvim",
    enabled = true,
    opts = {
      keymaps = {
        accept_suggestion = "<m-n>",
        clear_suggestion = "<m-i>",
        accept_word = "<m-h>",
      },
      condition = function()
        return false
      end,
    },
  },
}
