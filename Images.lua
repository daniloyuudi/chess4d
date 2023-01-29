local Images = {}

function Images:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:loadAll()
	return o
end

function Images:loadBlack()
	self.black.king = love.graphics.newImage("images/pieces/black/king.png")
	self.black.queen = love.graphics.newImage("images/pieces/black/queen.png")
	self.black.rook = love.graphics.newImage("images/pieces/black/rook.png")
	self.black.knight = love.graphics.newImage("images/pieces/black/knight.png")
	self.black.bishop = love.graphics.newImage("images/pieces/black/bishop.png")
	self.black.pawn = love.graphics.newImage("images/pieces/black/pawn.png")
end

function Images:loadWhite()
	self.white.king = love.graphics.newImage("images/pieces/white/king.png")
	self.white.queen = love.graphics.newImage("images/pieces/white/queen.png")
	self.white.rook = love.graphics.newImage("images/pieces/white/rook.png")
	self.white.knight = love.graphics.newImage("images/pieces/white/knight.png")
	self.white.bishop = love.graphics.newImage("images/pieces/white/bishop.png")
	self.white.pawn = love.graphics.newImage("images/pieces/white/pawn.png")
end

function Images:loadAll()
	self.white = {}
	self.black = {}

	self:loadBlack()
	self:loadWhite()
end

function Images:getKing(side)
	return self[side].king
end

function Images:getQueen(side)
	return self[side].queen
end

function Images:getRook(side)
	return self[side].rook
end

function Images:getKnight(side)
	return self[side].knight
end

function Images:getBishop(side)
	return self[side].bishop
end

function Images:getPawn(side)
	return self[side].pawn
end

return Images