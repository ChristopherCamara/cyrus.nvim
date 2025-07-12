local M = {}

local socket_conn = require("cyrus.socket_conn")

M.check = function()
	vim.health.start("cyrus report")
	local socket = socket_conn.new()
	if not socket then
		vim.health.error("Cannot connect to primrose server")
		return
	end
	local ready, message = socket.poll_message()
	if ready == true then
		vim.health.ok(message)
	else
		vim.health.error(message)
	end
end

return M
