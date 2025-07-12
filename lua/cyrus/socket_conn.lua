local M = {}

local socket_lib = require("cyrus.socket_lib")

function M.new()
	local socket = {}
	local ok, conn = pcall(socket_lib.connect)
	if not ok then
		return nil
	end

	socket.poll = function()
		ok = socket_lib.poll(conn)
		return ok
	end

	socket.poll_message = function()
		ok = socket.poll()
		local message = ""
		if ok == true then
			message = "Can connect to primrose server"
		else
			message = "Cannot connect to primrose server"
		end
		return ok, message
	end

	socket.read = function()
		return socket_lib.read(conn)
	end

	return socket
end

-- function M.read()
-- 	local success, error = pcall(socket_lib.read)
-- 	if success then
-- 		local message = socket_lib.read()
-- 		return message
-- 	end
-- 	return error
-- end
--

-- function M.read()
-- 	return socket_lib.read()
-- end

return M
