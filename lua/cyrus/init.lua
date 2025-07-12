local M = {}

local socket_conn = require("cyrus.socket_conn")

function M.setup()
	-- local socket = socket_conn.new()
	-- if socket then
	-- 	local _, message = socket.poll_message()
	-- 	print(message)
	-- end
end

vim.api.nvim_create_user_command("CyrusRead", function()
	local socket = socket_conn.new()
	if socket then
		local message = socket.read()
		print("Connected to primrose server: ", message)
	end
end, {})

return M
