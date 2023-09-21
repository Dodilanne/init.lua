local function augroup(name)
	return vim.api.nvim_create_augroup("dodi_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	group = augroup("checktime"),
	command = "checktime",
})
