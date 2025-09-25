--- @class Util

local M = {}

function M.buffer_to_string()
	local number_of_lines = vim.api.nvim_buf_line_count(0)

	local content = vim.api.nvim_buf_get_lines(0, 0, number_of_lines, false)

	return table.concat(content, "\n")
end

return M
