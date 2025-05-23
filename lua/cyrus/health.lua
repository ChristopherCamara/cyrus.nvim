local M = {}

local socket = require("cyrus.socket")

M.check = function()
	vim.health.start("cyrus report")
	if socket.connection ~= nil then
		vim.health.ok("connected to primrose server")
	else
		vim.health.error("not connected to primrose server")
	end
end

return M
