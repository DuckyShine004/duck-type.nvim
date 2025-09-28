local Type = require("duck-type.type")

local Config = require("duck-type.config")

local M = {}

function M.setup(options)
	Config.setup(options)

	-- Remove if already exists
	pcall(vim.api.nvim_del_user_command, "DuckType")

	vim.api.nvim_create_user_command("DuckType", function()
		Type.type(Config.get_options())
	end, {})
end

return M
