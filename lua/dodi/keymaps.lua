-- Move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep the cursor in the center of the screen when moving
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- System clipboard interactions
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking existing selection" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Remap increment to prevent clashing with tmux prefix command
vim.keymap.set({ "n", "v", "i" }, "<C-b>", "<C-a>", { desc = "Increment", silent = true })

-- Match escape key behaviour when exiting visual block mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- I'm a compulsive saver
vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "Write file" })

-- I'm a compulsive quitter
vim.keymap.set("n", "<leader>z", ":wa<cr>:q<cr>", { desc = "Write all then quit" })

-- console.log debugging whoohoo!

local debug_log = function(yank_motion)
  if vim.bo.filetype == "lua" then
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('"ny' .. yank_motion .. 'oprint("<C-r>n " .. <C-r>n)<Esc>', true, false, true))
  elseif vim.bo.filetype == "go" then
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('"ny' .. yank_motion .. 'oprintln("<C-r>n", <C-r>n)<Esc>', true, false, true))
  else
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('"ny' .. yank_motion .. 'oconsole.log("<C-r>n", <C-r>n);<Esc>', true, false, true))
  end
end

vim.keymap.set("n", "<leader>l", function()
  debug_log("iw")
end, { desc = "Add console log on next line" })
vim.keymap.set("v", "<leader>l", function()
  debug_log("")
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

vim.keymap.set("n", "<leader>t", function()
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes('"nyiwOconsole.time("<C-r>n");<Esc>joconsole.timeEnd("<C-r>n");<Esc>', true, false, true))
end, { desc = "Add console log on next line" })

vim.keymap.set("n", "<leader>q", function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd("cclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd("copen")
  end
end, { desc = "Toggle quickfix list" })

vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "cnext" })
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "cprev" })
