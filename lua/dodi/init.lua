for _, source in ipairs({
	"dodi.options",
	"dodi.lazy",
	"dodi.autocmds",
	"dodi.mappings",
}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.api.nvim_err_writeln("Failed to load " .. source)
	end
end
