local Piece = {}

function Piece:new(color)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.color = color
	return o
end

function Piece:setBoard(board)
	self.board = board
end

function Piece:getColor()
	return self.color
end

return Piece