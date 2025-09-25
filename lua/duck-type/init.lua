local Type = require("duck-type.type")

local Config = require("duck-type.config")

local M = {}

function M.setup()
	vim.api.nvim_create_user_command("DuckType", function()
		Type.type(Config.options.delay)
	end, {})
end

return M
