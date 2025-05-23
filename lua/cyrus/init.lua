local M = {}

local socket = require("cyrus.socket")

function M.setup()
	socket.connect()
end

return M
