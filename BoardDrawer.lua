local BoardDrawer = {}

function BoardDrawer:new(board)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.board = board
	o.quadColor = "white"
	return o
end

function BoardDrawer:alternateColor()
	if self.quadColor == "white" then
		self.quadColor = "black"
		love.graphics.setColor(0.5, 0.5, 0.5, 1)
	elseif self.quadColor == "black" then
		self.quadColor = "white"
		love.graphics.setColor(1, 1, 1, 1)
	end
end

function BoardDrawer:drawBoard()
	for i=1, 8 do
		for j=1, 8 do
			love.graphics.rectangle("fill", 75*(i-1), 75*(j-1), 75, 75)
			if j ~= 8 then
				self:alternateColor()
			end
		end
	end
end

function BoardDrawer:drawPieces()
	local pointer = self.board:getSprites()
	while pointer ~= nil do
		pointer:draw()
		pointer = pointer:getNext()
	end
end

function BoardDrawer:draw()
	self:drawBoard()
	self:drawPieces()
end

return BoardDrawer