--- @class Util

local M = {}

function M.buffer_to_lines(buffer)
	buffer = buffer or 0

	local number_of_lines = vim.api.nvim_buf_line_count(buffer)

	local content = vim.api.nvim_buf_get_lines(buffer, 0, number_of_lines, false)

	return content
end

return M
