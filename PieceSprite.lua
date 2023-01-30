local Images = require("Images")

local PieceSprite = {}

function PieceSprite:loadSprite()
	local images = Images:getInstance()
	local type = self.piece:getType()
	local color = self.piece:getColor()
	if type == "king" then
		self.sprite = images:getKing(color)
	elseif type == "queen" then
		self.sprite = images:getQueen(color)
	elseif type == "knight" then
		self.sprite = images:getKnight(color)
	elseif type == "bishop" then
		self.sprite = images:getBishop(color)
	elseif type == "rook" then
		self.sprite = images:getRook(color)
	elseif type == "pawn" then
		self.sprite = images:getPawn(color)
	end
end

function PieceSprite:new(piece, x, y)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.piece = piece
	o.x, o.y = (x-1)*75, (y-1)*75
	o.originX, o.originY = 0, 0
	o.destinationX, o.destinationY = 0, 0
	o.state = "still" -- to add a transition state
	o:loadSprite()
	return o
end

function PieceSprite:update()
	if self.state == "moving" then
		-- add transition
	end
end

function PieceSprite:setNext(pieceSprite)
	self.next = pieceSprite
end

function PieceSprite:getNext()
	return self.next
end

function PieceSprite:getX()
	return self.x
end

function PieceSprite:getY()
	return self.y
end

function PieceSprite:move(x, y)
	-- implement transition later
	self.x, self.y = x, y
end

function PieceSprite:draw()
	love.graphics.draw(self.sprite, self.x, self.y)
end

return PieceSprite