local Piece = {}

function Piece:new(color)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.color = color
	return o
end

function Piece:copyPrototype(prototype)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.color = prototype.color
	o.board = prototype.board
	return o
end

function Piece:hasPiece(color, x, y)
	local piece = self.board[x][y]
	if piece ~= nil then
		if color == "any" then
			return true
		end
		if piece:getColor() == color then
			return true
		end
	end
	return false
end

function Piece:setBoard(board)
	self.board = board
end

function Piece:getColor()
	return self.color
end

return Piece