local Images = require("Images")

local Piece = {}

function Piece:loadImage()
	local images = Images:new()

	if self.type == "king" then
		self.image = images:getKing(self.color)
	elseif self.type == "queen" then
		self.image = images:getQueen(self.color)
	elseif self.type == "knight" then
		self.image = images:getKnight(self.color)
	elseif self.type == "bishop" then
		self.image = images:getBishop(self.color)
	elseif self.type == "rook" then
		self.image = images:getRook(self.color)
	elseif self.type == "pawn" then
		self.image = images:getPawn(self.color)
	end
end

function Piece:new(color, type)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.color = color
	o.type = type
	o:loadImage()
	return o
end

function Piece:getColor()
	return self.color
end

function Piece:getType()
	return self.type
end

function Piece:draw(x, y)
	love.graphics.draw(self.image, x, y)
end

return Piece