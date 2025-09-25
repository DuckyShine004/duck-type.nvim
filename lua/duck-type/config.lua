--- @class Config

local M = {}

M.defaults = {
	delay = 50, -- in ms
	loop = false, -- looping over the same buffer
}

M.options = vim.deepcopy(M.defaults)

function M.setup(options)
	options = options or {}

	M.options = vim.tbl_deep_extend("force", M.options, options)

	return M.options
end

function M.get_options()
	return M.options
end

return M
