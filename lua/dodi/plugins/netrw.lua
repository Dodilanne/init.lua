local function toggle_netrw(opts)
  if vim.bo.filetype == "netrw" then
    vim.cmd("Rex")
  elseif opts and opts.root then
    vim.cmd("Ex " .. vim.loop.cwd())
  else
    vim.cmd("Ex")
  end
end

vim.keymap.set({ "n", "v" }, "<leader>e", toggle_netrw, { desc = "Open explorer in curr dir", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>E", function()
  toggle_netrw({ root = true })
end, { desc = "Open explorer in root dir", silent = true })

return {}
