local Piece = require("Piece")
local PieceSprite = require("PieceSprite")
local Moves = require("Moves")

local Board = {}

function Board:loadMatrix()
	self.pieces = {}
	for i = 1, 8 do
		self.pieces[i] = {}
	end
end

function Board:addPiece(x, y, color, type)
	local newPiece = Piece:new(color, type)
	self.pieces[x][y] = newPiece
	local newSprite = PieceSprite:new(newPiece, x, y)
	if self.sprites == nil then
		self.sprites = newSprite
	else
		local pointer = self.sprites
		while pointer:getNext() do
			pointer = pointer:getNext()
		end
		pointer:setNext(newSprite)
	end
end

function Board:loadNewGame()
	self:addPiece(1, 1, "black", "rook")
	self:addPiece(2, 1, "black", "knight")
	self:addPiece(3, 1, "black", "bishop")
	self:addPiece(4, 1, "black", "queen")
	self:addPiece(5, 1, "black", "king")
	self:addPiece(6, 1, "black", "bishop")
	self:addPiece(7, 1, "black", "knight")
	self:addPiece(8, 1, "black", "rook")
	for i = 1, 8 do
		self:addPiece(i, 2, "black", "pawn")
	end
	self:addPiece(1, 8, "white", "rook")
	self:addPiece(2, 8, "white", "knight")
	self:addPiece(3, 8, "white", "bishop")
	self:addPiece(4, 8, "white", "queen")
	self:addPiece(5, 8, "white", "king")
	self:addPiece(6, 8, "white", "bishop")
	self:addPiece(7, 8, "white", "knight")
	self:addPiece(8, 8, "white", "rook")
	for i = 1, 8 do
		self:addPiece(i, 7, "white", "pawn")
	end
end

function Board:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:loadMatrix()
	o:loadNewGame()
	o.moves = Moves:new()
	o.moves:setBoardMatrix(o.pieces)
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
	local pointer = self.sprites
	while pointer:getNext() ~= sprite do
		pointer = pointer:getNext()
	end
	local next = pointer:getNext():getNext()
	pointer:setNext(next)
end

function Board:movePiece(x1, y1, x2, y2)
	-- if king captured then set checkmate
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
		local type = piece:getType()
		if type == "pawn" then
			local moves = self.moves:getPawnMoves(x1, y1, "white")
			if self:hasMove(moves, x2, y2) then
				return true
			end
			return false
		end
		if type == "rook" then
			local moves = self.moves:getRookMoves(x1, y1, "white")
			if self:hasMove(moves, x2, y2) then
				return true
			end
			return false
		end
		if type == "bishop" then
			local moves = self.moves:getBishopMoves(x1, y1, "white")
			if self:hasMove(moves, x2, y2) then
				return true
			end
			return false
		end
		if type == "king" then
			local moves = self.moves:getKingMoves(x1, y1, "white")
			if self:hasMove(moves, x2, y2) then
				return true
			end
			return false
		end
		if type == "queen" then
			local moves = self.moves:getQueenMoves(x1, y1, "white")
			if self:hasMove(moves, x2, y2) then
				return true
			end
			return false
		end
		if type == "knight" then
			local moves = self.moves:getKnightMoves(x1, y1, "white")
			if self:hasMove(moves, x2, y2) then
				return true
			end
			return false
		end
		return true
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

