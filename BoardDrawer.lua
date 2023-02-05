local KingSprite = require("KingSprite")
local QueenSprite = require("QueenSprite")
local RookSprite = require("RookSprite")
local KnightSprite = require("KnightSprite")
local BishopSprite = require("BishopSprite")
local PawnSprite = require("PawnSprite")

local BoardDrawer = {}

function BoardDrawer:new(board)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.board = board
	o:loadNewGame()
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

function BoardDrawer:addSprite(sprite)
	local pointer = self.sprites
	if pointer ~= nil then
		while pointer:getNext() ~= nil do
			pointer = pointer:getNext()
		end
		pointer:setNext(sprite)
	else
		self.sprites = sprite
	end
end

function BoardDrawer:addKing(color, x, y)
	local king = KingSprite:new(color, x, y)
	self:addSprite(king)
end

function BoardDrawer:addQueen(color, x, y)
	local queen = QueenSprite:new(color, x, y)
	self:addSprite(queen)
end

function BoardDrawer:addRook(color, x, y)
	local rook = RookSprite:new(color, x, y)
	self:addSprite(rook)
end

function BoardDrawer:addKnight(color, x, y)
	local knight = KnightSprite:new(color, x, y)
	self:addSprite(knight)
end

function BoardDrawer:addBishop(color, x, y)
	local bishop = BishopSprite:new(color, x, y)
	self:addSprite(bishop)
end

function BoardDrawer:addPawn(color, x, y)
	local pawn = PawnSprite:new(color, x, y)
	self:addSprite(pawn)
end

function BoardDrawer:loadNewGame()
	self:addRook("black", 1, 1)
	self:addKnight("black", 2, 1)
	self:addBishop("black", 3, 1)
	self:addQueen("black", 4, 1)
	self:addKing("black", 5, 1)
	self:addBishop("black", 6, 1)
	self:addKnight("black", 7, 1)
	self:addRook("black", 8, 1)
	for i = 1, 8 do
		self:addPawn("black", i, 2)
	end
	self:addRook("white", 1, 8)
	self:addKnight("white", 2, 8)
	self:addBishop("white", 3, 8)
	self:addQueen("white", 4, 8)
	self:addKing("white", 5, 8)
	self:addBishop("white", 6, 8)
	self:addKnight("white", 7, 8)
	self:addRook("white", 8, 8)
	for i = 1, 8 do
		self:addPawn("white", i, 7)
	end
end

function BoardDrawer:searchSprite(x, y)
	local pointer = self.sprites
	while pointer ~= nil do
		if pointer:getX() == (x-1)*75 and pointer:getY() == (y-1)*75 then
			return pointer
		end
		pointer = pointer:getNext()
	end
end

function BoardDrawer:getSprite(x, y)
	return self:searchSprite(x, y)
end

function BoardDrawer:removeSprite(x, y)
	local sprite = self:searchSprite(x, y)
	local pointer = self.sprites
	if pointer ~= sprite then
		while pointer:getNext() ~= sprite do
			pointer = pointer:getNext()
		end
		local next = pointer:getNext():getNext()
		pointer:setNext(next)
	else
		self.sprites = pointer:getNext()
	end
end

function BoardDrawer:setSelectedQuad(x, y)
	self.selectedX, self.selectedY = x, y
end

function BoardDrawer:drawPieces()
	local pointer = self.sprites
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