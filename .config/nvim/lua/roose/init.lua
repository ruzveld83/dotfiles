require("roose.remap")
require("roose.lazy")

vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.ic = true

-- Make '/path/to/dir' current working directory when starting nvim with
-- 'nvim /path/to/dir'
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = function()
	local current_netrw_dir = vim.b.netrw_curdir
	if current_netrw_dir ~= nil and current_netrw_dir ~= '' then
		vim.api.nvim_set_current_dir(current_netrw_dir)
	end
end })

