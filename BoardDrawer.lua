local BoardDrawer = {}

function BoardDrawer:new(board)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.board = board
	o.quadColor = "white"
	return o
end

function BoardDrawer:setQuadColor(x, y)
	if x == self.selectedX and y == self.selectedY then
		love.graphics.setColor(1, 0, 0, 1)
	else
		local color = "white"
		if x % 2 == 1 then
			color = "black"
		end
		if y % 2 == 1 then
			if color == "white" then
				color = "black"
			elseif color == "black" then
				color = "white"
			end
		end
		if color == "white" then
			love.graphics.setColor(1, 1, 1, 1)
		elseif color == "black" then
			love.graphics.setColor(0.5, 0.5, 0.5, 1)
		end
	end
end

function BoardDrawer:drawBoard()
	for i=1, 8 do
		for j=1, 8 do
			self:setQuadColor(i, j)
			love.graphics.rectangle("fill", 75*(i-1), 75*(j-1), 75, 75)
		end
	end
end

function BoardDrawer:setSelectedQuad(x, y)
	self.selectedX, self.selectedY = x, y
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