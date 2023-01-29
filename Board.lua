local Board = {}

function Board:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.quadColor = "white"
	return o
end

function Board:alternateColor()
	if self.quadColor == "white" then
		self.quadColor = "black"
		love.graphics.setColor(0.5, 0.5, 0.5, 1)
	elseif self.quadColor == "black" then
		self.quadColor = "white"
		love.graphics.setColor(1, 1, 1, 1)
	end
end

function Board:drawBoard()
	for i=1, 8 do
		for j=1, 8 do
			love.graphics.rectangle("fill", 75*(i-1), 75*(j-1), 75, 75)
			if j ~= 8 then
				self:alternateColor()
			end
		end
	end
end

function Board:draw()
	self:drawBoard()
end

return Board

