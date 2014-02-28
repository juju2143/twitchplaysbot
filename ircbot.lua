require("irc")
require("settings")

irc.initialize(irc.settings)
irc.connect()

while(true) do
    irc.read()
    if irc.messages_size() > 0 then
		msg = irc.message()
		if msg ~= nil then
			input = {}
			if msg.message == "up" then
				input.up = true
			elseif msg.message == "down" then
				input.down = true
			elseif msg.message == "left" then
				input.left = true
			elseif msg.message == "right" then
				input.right = true
			elseif msg.message == "a" then
				input.A = true
			elseif msg.message == "b" then
				input.B = true
			elseif msg.message == "x" then
				input.X = true
			elseif msg.message == "y" then
				input.Y = true
			elseif msg.message == "l" then
				input.L = true
			elseif msg.message == "r" then
				input.R = true
			elseif msg.message == "start" then
				input.start = true
			elseif msg.message == "select" then
				input.select = true
			else
			end
			joypad.set(1, input)
		end
	end
	emu.frameadvance()
end
