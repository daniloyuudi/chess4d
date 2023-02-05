local BoardDrawer = {}

function BoardDrawer:new(board)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.board = board
	return o
end

function BoardDrawer:setQuadColor(x, y)
	if x == self.selectedX and y == self.selectedY then
		love.graphics.setColor(1, 0, 0, 1)
	else
		-- calculate if the quad is odd or even
		local modulus = math.abs(x % 2 - y % 2)
		if modulus == 0 then
			love.graphics.setColor(1, 1, 1, 1)
		elseif modulus == 1 then
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