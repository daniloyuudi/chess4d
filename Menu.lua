local Match = require("Match")

local Menu = {}

function Menu:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.context = context
	return o
end

function Menu:setContext(context)
	self.context = context
end

function Menu:update()
	if love.mouse.isDown(1) then
		local match = Match:new()
		self.context:changeScreen(match)
	end
end

function Menu:draw()
	love.graphics.setBackgroundColor(0, 0, 0, 1)
	love.graphics.print("Chess 4D", 200, 200)
	love.graphics.print("Click to begin", 200, 300)
end

return Menu