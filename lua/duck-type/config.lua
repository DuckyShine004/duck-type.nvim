--- @class Config

local M = {}

M.defaults = {
	delay = 50, -- in ms
	loop = true, -- looping over the same buffer
	cursor = "🦆", -- custom cursor,
}

M.options = vim.deepcopy(M.defaults)

function M.setup(options)
	options = options or {}

	M.options = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), options)

	return M.options
end

function M.get_options()
	return M.options
end

return M
