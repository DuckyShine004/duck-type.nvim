--- @class Type

local Util = require("duck-type.util")

local Overlay = require("duck-type.overlay")

local M = {}

function M.type(delay)
	local buffer_lines = Util.buffer_to_lines(0)

	local text = table.concat(buffer_lines, "\n")

	local window, buffer = Overlay.create_overlay()

	vim.api.nvim_set_option_value("modifiable", true, { buf = buffer })

	vim.api.nvim_buf_set_lines(buffer, 0, -1, false, { "" })

	local position = 0

	local timer = vim.loop.new_timer()

	if timer == nil then
		vim.notify("duck-type.nvim Error: timer could not be initialised", vim.log.levels.ERROR)

		Overlay.close_overlay(window, buffer)

		return
	end

	local function set_buffer_and_cursor_position(chunk)
		local lines = vim.split(chunk, "\n", { plain = true, trimempty = true })

		if #lines == 0 then
			lines = { "" }
		end

		vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)

		local last = lines[#lines] or ""

		local row = #lines
		local column = #last

		pcall(vim.api.nvim_win_set_cursor, window, { row, column })
	end

	timer:start(
		0,
		delay,
		vim.schedule_wrap(function()
			position = position + 1

			-- Check if we are at EOF
			if position > #text then
				vim.api.nvim_set_option_value("modifiable", false, { buf = buffer })

				timer:stop()
				timer:close()

				Overlay.close_overlay(window, buffer)

				return
			end

			local chunk = text:sub(1, position)

			set_buffer_and_cursor_position(chunk)
		end)
	)

	return function()
		if not timer:is_closing() then
			timer:stop()
			timer:close()
		end

		Overlay.close_overlay(window, buffer)
	end
end

return M
