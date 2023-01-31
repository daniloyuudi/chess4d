local Menu = {}

function Menu:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.beginGame = false
	return o
end

function Menu:update()
	if love.mouse.isDown(1) then
		self.beginGame = true
	end
end

function Menu:draw()
	love.graphics.setBackgroundColor(0, 0, 0, 1)
	love.graphics.print("Chess 4D", 200, 200)
	love.graphics.print("Click to begin", 200, 300)
end

function Menu:getBeginGame()
	return self.beginGame
end

return Menu