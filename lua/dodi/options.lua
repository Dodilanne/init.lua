vim.opt.background = os.getenv("NEOVIM_BACKGROUND") or "dark"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.guicursor = ""

vim.opt.smartindent = true
vim.opt.smartcase = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.matchpairs:append("<:>")

vim.filetype.add({
	extension = {
		mdx = "mdx",
	},
})

-- Todo: Find a way to activate this only for norg files
-- vim.opt.conceallevel = 2
-- vim.opt.concealcursor = "n"
