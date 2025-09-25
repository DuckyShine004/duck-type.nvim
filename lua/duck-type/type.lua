--- @class Type

local Util = require("duck-type.util")

local Overlay = require("duck-type.overlay")

local M = {}

function M.type()
	local lines = Util.buffer_to_string()

	local window, buffer = Overlay.create_overlay()

	print(lines)
end

return M
