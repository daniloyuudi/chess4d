local King = require("King")
local Queen = require("Queen")
local Rook = require("Rook")
local Knight = require("Knight")
local Bishop = require("Bishop")
local Pawn = require("Pawn")
local KingSprite = require("KingSprite")
local QueenSprite = require("QueenSprite")
local RookSprite = require("RookSprite")
local KnightSprite = require("KnightSprite")
local BishopSprite = require("BishopSprite")
local PawnSprite = require("PawnSprite")

local Board = {}

function Board:loadMatrix()
	self.pieces = {}
	for i = 1, 8 do
		self.pieces[i] = {}
	end
end

function Board:addSprite(sprite)
	if self.sprites ~= nil then
		local pointer = self.sprites
		while pointer:getNext() ~= nil do
			pointer = pointer:getNext()
		end
		pointer:setNext(sprite)
	else
		self.sprites = sprite
	end
end

function Board:addKing(x, y, color)
	local king = King:new(color)
	king:setBoard(self)
	self.pieces[x][y] = king
	local kingSprite = KingSprite:new(color, x, y)
	self:addSprite(kingSprite)
end

function Board:addQueen(x, y, color)
	local queen = Queen:new(color)
	queen:setBoard(self)
	self.pieces[x][y] = queen
	local queenSprite = QueenSprite:new(color, x, y)
	self:addSprite(queenSprite, x, y)
end

function Board:addRook(x, y, color)
	local rook = Rook:new(color)
	rook:setBoard(self)
	self.pieces[x][y] = rook
	local rookSprite = RookSprite:new(color, x, y)
	self:addSprite(rookSprite, x, y)
end

function Board:addKnight(x, y, color)
	local knight = Knight:new(color)
	knight:setBoard(self)
	self.pieces[x][y] = knight
	local knightSprite = KnightSprite:new(color, x, y)
	self:addSprite(knightSprite, x, y)
end

function Board:addBishop(x, y, color)
	local bishop = Bishop:new(color)
	bishop:setBoard(self)
	self.pieces[x][y] = bishop
	local bishopSprite = BishopSprite:new(color, x, y)
	self:addSprite(bishopSprite, x, y)
end

function Board:addPawn(x, y, color)
	local pawn = Pawn:new(color)
	pawn:setBoard(self)
	self.pieces[x][y] = pawn
	local pawnSprite = PawnSprite:new(color, x, y)
	self:addSprite(pawnSprite, x, y)
end

function Board:loadNewGame()
	self:addRook(1, 1, "black")
	self:addKnight(2, 1, "black")
	self:addBishop(3, 1, "black")
	self:addQueen(4, 1, "black")
	self:addKing(5, 1, "black")
	self:addBishop(6, 1, "black")
	self:addKnight(7, 1, "black")
	self:addRook(8, 1, "black")
	for i = 1, 8 do
		self:addPawn(i, 2, "black")
	end
	self:addRook(1, 8, "white")
	self:addKnight(2, 8, "white")
	self:addBishop(3, 8, "white")
	self:addQueen(4, 8, "white")
	self:addKing(5, 8, "white")
	self:addBishop(6, 8, "white")
	self:addKnight(7, 8, "white")
	self:addRook(8, 8, "white")
	for i = 1, 8 do
		self:addPawn(i, 7, "white")
	end
end

function Board:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:loadMatrix()
	o:loadNewGame()
	o.checkMate = false
	return o
end

function Board:hasPiece(color, x, y)
	local piece = self.pieces[x][y]
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

function Board:searchSprite(x, y)
	local sprite = self.sprites
	while sprite ~= nil do
		if sprite:getX() == (x-1)*75 and sprite:getY() == (y-1)*75 then
			return sprite
		end
		sprite = sprite:getNext()
	end
	return nil
end

function Board:removeSprite(sprite)
	if self.sprites == sprite then
		self.sprites = self.sprites:getNext()
	else
		local pointer = self.sprites
		while pointer:getNext() ~= sprite do
			pointer = pointer:getNext()
		end
		local next = pointer:getNext():getNext()
		pointer:setNext(next)
	end
end

function Board:isKing(piece)
	local type = getmetatable(piece)
	if type == King then
		return true
	end
	return false
end

function Board:movePiece(x1, y1, x2, y2)
	-- if king captured set checkmate
	local piece = self.pieces[x2][y2]
	if piece ~= nil and self:isKing(piece) then
		self.checkMate = true
	end
	-- change switch pieces in matrix
	self.pieces[x2][y2] = self.pieces[x1][y1]
	self.pieces[x1][y1] = nil
	-- remove sprite in new position first
	local targetSprite = self:searchSprite(x2, y2)
	if targetSprite ~= nil then
		self:removeSprite(targetSprite)
	end
	-- move sprite
	local sprite = self:searchSprite(x1, y1)
	sprite:setDestination((x2-1)*75, (y2-1)*75)
end

function Board:hasMove(moves, x, y)
	for _, v in ipairs(moves) do
		if v[1] == x and v[2] == y then
			return true
		end
	end
	return false
end

function Board:checkMove(x1, y1, x2, y2)
	local piece = self.pieces[x1][y1]
	if piece ~= nil then
		local moves = piece:getMoves(x1, y1)
		if self:hasMove(moves, x2, y2) then
			return true
		end
		return false
	end
end

function Board:getSprites()
	return self.sprites
end

function Board:getMatrix()
	return self.pieces
end

function Board:gameEnded()
	return self.checkMate
end

function Board:getPieceSprite(x, y)
	return self:searchSprite(x, y)
end

return Board

