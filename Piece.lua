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

function Piece:clone()
	return self:copyPrototype(self)
end

function Piece:setBoard(board)
	self.board = board
end

function Piece:getColor()
	return self.color
end

return Piece