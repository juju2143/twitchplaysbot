local socket = require("socket")
local io = io
local string = string
local emu = emu

module("irc")
local connection
local host
local port
local channel
local nickname
local password
local messages = {
	ptr = 0, 
	size = -1
}
local connected = false

function initialize(settings)
	host = settings.host
	port = settings.port
	nickname = settings.nickname
	channel = settings.channel
	password = settings.password
	connection, err = socket.tcp()
	if err ~= nil then
		emu.print(err)
	end
	connection:settimeout(0)
end

function connect()
	if connection == nil then
		connection, err = socket.tcp()
		if err ~= nil then
			emu.print(err)
		end
		connection:settimeout(0)
	end
	connection:connect(host, port)
end

function disconnect()
	if connection ~= nil then
		connection:close()
	end
	connection = nil
end

function read()
	local buffer, err
	local prefix, cmd, param, param1, param2
	local user, userhost
	err = nil
	if connection ~= nil then
		buffer, err = connection:receive("*l")
		if err == nil or err == "timeout" then
			if not connected then
				socket.sleep(1)
				if password ~= nil and password ~= "" then
					send("PASS "..password)
				end
				send("NICK "..nickname)
				send("USER "..nickname.." 0 * :TwitchPlaysBot by juju2143 http://github.com/juju2143/twitchplaysbot")
				connected = true
			end
		else
			emu.print(buffer)
		end
		if buffer ~= nil then
			emu.print(buffer)
			io.flush()
			if string.sub(buffer,1,4) == "PING" then
				send(string.gsub(buffer,"PING","PONG",1))
			else
				prefix, cmd, param = string.match(buffer, "^:([^ ]+) ([^ ]+)(.*)$")
				if cmd == "376" then
					send("JOIN "..channel)
				end
				if param ~= nil then
					param = string.sub(param,2)
					param1, param2 = string.match(param,"^([^:]+) :(.*)$")
					if cmd == "PRIVMSG" then
						user, userhost = string.match(prefix,"^([^!]+)!(.*)$")
						messages.size = messages.size + 1
						messages[messages.size] = {}
						messages[messages.size].nick = user
						messages[messages.size].message = param2
					end
				end
			end
		end
	end
	return buffer, err
end

function send(data)
	if connection ~= nil then
		connection:send(data.."\r\n")
		emu.print(data.."\n")
		io.flush()
	end
end

function message()
	local ptr = messages.ptr
	if ptr > messages.size then 
		return nil
	end
	local message = messages[ptr]
	messages[ptr] = nil
	messages.ptr = ptr + 1
	return message
end

function messages_size()
   return messages.size
end