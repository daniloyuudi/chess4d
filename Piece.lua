local Piece = {}

function Piece:new(color, type)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.color = color
	o.type = type
	return o
end

function Piece:getColor()
	return self.color
end

function Piece:getType()
	return self.type
end

return Piece