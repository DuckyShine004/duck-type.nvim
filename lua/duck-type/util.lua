--- @class Util

local M = {}

function M.buffer_to_lines(buffer)
	buffer = buffer or 0

	local number_of_lines = vim.api.nvim_buf_line_count(buffer)

	local content = vim.api.nvim_buf_get_lines(buffer, 0, number_of_lines, false)

	return content
end

-- Debugging purposes
function M.print_table(table, indent)
	indent = indent or ""

	for key, value in pairs(table) do
		local key_string = tostring(key)

		if type(key) == "string" then
			key_string = string.format('"%s"', key_string)
		end

		if type(value) == "table" then
			print(indent .. key_string .. " = {")

			M.print_table(value, indent .. "  ")

			print(indent .. "}")
		else
			print(indent .. key_string .. " = " .. tostring(value))
		end
	end
end

return M
