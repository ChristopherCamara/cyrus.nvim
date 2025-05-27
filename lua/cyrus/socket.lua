local M = {}

M.connection = nil

local socket_lib = require("cyrus.socket_lib")

function M.connect()
	local success, err = pcall(socket_lib.connect)
	if success then
		M.connection = socket_lib.connect()
	end
	return success, err
end

return M
