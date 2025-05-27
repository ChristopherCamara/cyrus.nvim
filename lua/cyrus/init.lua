local M = {}

local socket = require("cyrus.socket")

function M.setup()
	socket.connect()
end

vim.api.nvim_create_user_command("CyrusConnect", function()
	if socket.connection ~= nil then
		print("Already connected to primrose server")
		return
	end

	local success = socket.connect()
	if success then
		print("Succesfully connected to primrose server")
	else
		print("Failed to connect to primrose server")
	end
end, {})

return M
