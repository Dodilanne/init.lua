return {
  {
    "github/copilot.vim",
    enabled = false,
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.cmd("Copilot disable")
      vim.keymap.set("i", "<m-n>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
      vim.keymap.set("i", "<m-i>", "<Plug>(copilot-dismisss)")
      vim.keymap.set("i", "<m-h>", "<Plug>(copilot-accept-word)")
      vim.keymap.set("i", "<m-l>", "<Plug>(copilot-accept-line)")
      vim.keymap.set("i", "<m-e>", "<Plug>(copilot-suggest)")
    end,
  },
}
