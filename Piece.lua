local Images = require("Images")

local Piece = {}

function Piece:loadImage()
	local images = Images:new()

	if self.type == "king" then
		self.image = images:getKing(self.side)
	elseif self.type == "queen" then
		self.image = images:getQueen(self.side)
	elseif self.type == "knight" then
		self.image = images:getKnight(self.side)
	elseif self.type == "bishop" then
		self.image = images:getBishop(self.side)
	elseif self.type == "rook" then
		self.image = images:getRook(self.side)
	elseif self.type == "pawn" then
		self.image = images:getRook(self.side)
	end
end

function Piece:new(side, type)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.side = side
	o.type = type
	o:loadImage()
	return o
end

function Piece:draw(x, y)
	love.graphics.draw(self.image, x, y)
end

return Piece