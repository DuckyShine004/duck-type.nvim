--- @class Overlay

local M = {}

function M.create_overlay()
	local current_window = vim.api.nvim_get_current_win()

	local width = vim.api.nvim_win_get_width(current_window)
	local height = vim.api.nvim_win_get_height(current_window)

	local buffer = vim.api.nvim_create_buf(false, true)

	local window = vim.api.nvim_open_win(buffer, false, {
		relative = "win",
		window = current_window,
		row = 0,
		col = 0,
		width = width,
		height = height,
		style = "minimal",
		zindex = 200,
	})

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
