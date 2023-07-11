vim.keymap.set("n", "<A-d>", "Vyp")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<CR>")

vim.keymap.set("v", "af", "<esc>ggVG")

-- Match escape key behaviour when exiting visual block mode
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set(
	"n",
	"<leader>cc",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace under cursor" }
)
vim.keymap.set(
	"v",
	"<leader>cc",
	[["hy:%s/<C-r>h//gI<Left><Left><Left>]],
	{ desc = "Replace all occurences of selected text" }
)

vim.keymap.set(
	"n",
	"<leader>l",
	[["nyiwoconsole.log("<C-r>n", <C-r>n);<Esc>]],
	{ desc = "Add console log statement for symbol under the cursor" }
)

vim.keymap.set(
	"v",
	"<leader>l",
	[["nyoconsole.log("<C-r>n", <C-r>n);<Esc>]],
	{ desc = "Add console log statement for selected text" }
)

vim.keymap.set("n", "<leader>gu", ":Gitui<CR>", { noremap = true, silent = true, desc = "Open Gitui" })

vim.keymap.set({ "n", "v", "i" }, "<C-s>", "<esc>:w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
