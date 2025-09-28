--- @class Type

local Util = require("duck-type.util")

local Overlay = require("duck-type.overlay")

local namespace = vim.api.nvim_create_namespace("duck-type")

local M = {}

function M.type(options)
	local buffer_lines = Util.buffer_to_lines(0)

	local text = table.concat(buffer_lines, "\n")

	local window, buffer = Overlay.create_overlay()

	local position = 0

	local timer = vim.loop.new_timer()

	-- Check for timer initialisation error
	if timer == nil then
		vim.notify("duck-type.nvim Error: timer could not be initialised", vim.log.levels.ERROR)

		Overlay.close_overlay(window, buffer)

		return
	end

	-- Create key handler
	local keyhandler_set = false

	local function remove_keyhandler()
		if keyhandler_set then
			vim.on_key(nil, namespace)

			keyhandler_set = false
		end
	end

	-- Close typing function
	local closing = false

	local function close()
		if closing then
			return
		end

		closing = true

		pcall(vim.api.nvim_set_option_value, "modifiable", false, { buf = buffer })

		if timer and not timer:is_closing() then
			timer:stop()
			timer:close()
		end

		remove_keyhandler()

		Overlay.close_overlay(window, buffer)
	end

	-- Set local mapping for 'q' so macros are not recorded
	vim.keymap.set({ "n", "v", "o" }, "q", function()
		close()
	end, { buffer = buffer, nowait = true, silent = true })

	-- Set the key handler
	vim.on_key(function(_)
		if timer and not timer:is_closing() then
			timer:stop()
		end

		vim.schedule(close)
	end, namespace)

	keyhandler_set = true

	-- Type next character
	local function type_next()
		if closing or not vim.api.nvim_buf_is_valid(buffer) then
			return
		end

		if not vim.api.nvim_win_is_valid(window) then
			return
		end

		local chunk = text:sub(1, position)

		local lines = vim.split(chunk, "\n", { plain = true, trimempty = true })

		if #lines == 0 then
			lines = { "" }
		end

		-- Add custom cursor
		lines[#lines] = lines[#lines] .. options.cursor

		-- Add custom cursor
		if not pcall(vim.api.nvim_buf_set_lines, buffer, 0, -1, false, lines) then
			return
		end

		local last = lines[#lines] or ""

		local row = #lines
		local column = #last

		pcall(vim.api.nvim_win_set_cursor, window, { row, column })
	end

	-- Type function
	local function typing()
		if closing then
			return
		end

		position = position + 1

		-- Check if we are at EOF
		if position > #text then
			if options.loop then
				position = 0

				Overlay.clear(buffer)

				if timer and not timer:is_closing() then
					timer:stop()
					timer:start(0, options.delay, vim.schedule_wrap(typing))
				end

				return
			else
				close()

				return
			end
		end

		type_next()
	end

	-- Start typing
	timer:start(0, options.delay, vim.schedule_wrap(typing))

	return function()
		close()
	end
end

return M
