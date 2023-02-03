local Mouse = require("Mouse")
local Match

local ResultScreen = {}

function ResultScreen:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.mouse = Mouse:new()
	return o
end

function ResultScreen:setContext(context)
	self.context = context
end

function ResultScreen:update()
	Match = Match or require("Match")
	if self.mouse:checkPressed() then
		local match = Match:new()
		self.context:changeScreen(match)
	end
end

return ResultScreen