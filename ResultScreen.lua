local Mouse = require("Mouse")

local ResultScreen = {}

function ResultScreen:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.mouse = Mouse:new()
	o.restartGameFlag = false
	return o
end

function ResultScreen:setResult(result)
	self.result = result
end

function ResultScreen:restartGame()
	return self.restartGameFlag
end

function ResultScreen:update()
	if self.mouse:checkPressed() then
		self.restartGameFlag = true
	end
end

function ResultScreen:draw()
	love.graphics.setBackgroundColor(0, 0, 0, 1)
	if self.result == "victory" then
		love.graphics.print("You won", 200, 200)
	elseif self.result == "defeat" then
		love.graphics.print("You lost", 200, 200)
	end
end

return ResultScreen