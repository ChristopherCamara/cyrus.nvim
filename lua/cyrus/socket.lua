local M = {}

M.connection = nil

local socket_lib = require("cyrus.socket_lib")

function M.connect()
	if pcall(socket_lib.connect) then
		M.connection = socket_lib.connect()
	end
end

return M
