--- @class Overlay

local M = {}

-- TODO: Create method for buffer and window
function M.create_overlay()
	local current_window = vim.api.nvim_get_current_win()

	local width = vim.api.nvim_win_get_width(current_window)
	local height = vim.api.nvim_win_get_height(current_window)

	local buffer = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_set_option_value("buftype", "nofile", { buf = buffer })
	vim.api.nvim_set_option_value("buflisted", false, { buf = buffer })
	vim.api.nvim_set_option_value("swapfile", false, { buf = buffer })
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buffer })

	-- Syntax highlighting
	local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })

	vim.api.nvim_set_option_value("filetype", filetype, { buf = buffer })

	pcall(function()
		vim.treesitter.start(buffer, filetype)
	end)

	local window = vim.api.nvim_open_win(buffer, true, {
		relative = "win",
		win = current_window,
		row = 0,
		col = 0,
		width = width,
		height = height,
		style = "minimal",
		border = "none",
		focusable = true,
		noautocmd = true,
		zindex = 200,
	})

	-- Set to the same background
	vim.api.nvim_set_option_value("winhl", "Normal:Normal,FloatBorder:Normal", { win = window })
	vim.api.nvim_set_option_value("number", false, { win = window })
	vim.api.nvim_set_option_value("relativenumber", false, { win = window })
	vim.api.nvim_set_option_value("signcolumn", "no", { win = window })
	vim.api.nvim_set_option_value("foldcolumn", "0", { win = window })
	vim.api.nvim_set_option_value("wrap", false, { win = window })

	return window, buffer
end

function M.close_overlay(window, buffer)
	if vim.api.nvim_win_is_valid(window) then
		vim.api.nvim_win_close(window, true)
	end

	if vim.api.nvim_buf_is_valid(buffer) then
		vim.api.nvim_buf_delete(buffer, { force = true })
	end
end

return M
