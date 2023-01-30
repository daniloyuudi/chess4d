local Piece = require("Piece")
local PieceSprite = require("PieceSprite")

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
	o.quadColor = "white"
	o:loadMatrix()
	o:loadNewGame()
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
	self.pieces[x2][y2] = self.pieces[x1][y1]
	self.pieces[x1][y1] = nil
	-- remove sprite in new position first
	local targetSprite = self:searchSprite(x2, y2)
	print(targetSprite)
	if targetSprite ~= nil then
		self:removeSprite(targetSprite)
	end
	-- move sprite
	local sprite = self:searchSprite(x1, y1)
	sprite:move((x2-1)*75, (y2-1)*75)
end

function Board:getPawnMoves(x, y)
	local moves = {}
	-- capture left
	if x > 1 then
		if self:hasPiece("black", x-1, y-1) then
			table.insert(moves, {x-1, y-1})
		end
	end
	-- capture right
	if x < 8 then
		if self:hasPiece("black", x+1, y-1) then
			table.insert(moves, {x+1, y-1})
		end
	end
	-- move forward
	if not self:hasPiece("any", x, y-1) then
		table.insert(moves, {x, y-1})
	end
	-- opening move
	if y == 7 then
		if not self:hasPiece("any", x, y-2) then
			table.insert(moves, {x, y-2})
		end
	end
	return moves
end

function Board:getRookMoves(x, y)
	local quadsLeft = x-1
	local quadsRight = 8-x
	local quadsUp = y-1
	local quadsDown = 8-y
	local moves = {}
	-- move right
	for i = 1, quadsRight do
		if self:hasPiece("white", x+i, y) then
			break
		end
		if self:hasPiece("black", x+i, y) then
			table.insert(moves, {x+i, y})
			break
		end
		table.insert(moves, {x+i, y})
	end
	-- move up
	for i = 1, quadsUp do
		if self:hasPiece("white", x, y-i) then
			break
		end
		if self:hasPiece("black", x, y-i) then
			table.insert(moves, {x,y-i})
			break
		end
		table.insert(moves, {x,y-i})
	end
	-- move left
	for i = 1, quadsLeft do
		if self:hasPiece("white", x-i, y) then
			break
		end
		if self:hasPiece("black", x-i, y) then
			table.insert(moves, {x-i, y})
			break
		end
		table.insert(moves, {x-i, y})
	end
	-- move down
	for i = 1, quadsDown do
		if self:hasPiece("white", x, y+i) then
			break
		end
		if self:hasPiece("black", x, y+i) then
			table.insert(moves, {x,y+i})
			break
		end
		table.insert(moves, {x, y+i})
	end
	return moves
end

function Board:getBishopMoves(x, y)
	local quadsLeft = x-1
	local quadsRight = 8-x
	local quadsUp = y-1
	local quadsDown = 8-y
	local quadsLeftUp = math.min(quadsLeft, quadsUp)
	local quadsRightUp = math.min(quadsRight, quadsUp)
	local quadsRightDown = math.min(quadsRight, quadsDown)
	local quadsLeftDown = math.min(quadsLeft, quadsDown)
	local moves = {}
	-- move left-up
	for i = 1, quadsLeftUp do
		if self:hasPiece("white", x-i, y-i) then
			break
		end
		if self:hasPiece("black", x-i, y-i) then
			table.insert(moves, {x-i,y-i})
			break
		end
		table.insert(moves, {x-i,y-i})
	end
	-- move right-up
	for i = 1, quadsRightUp do
		if self:hasPiece("white", x+i, y-i) then
			break
		end
		if self:hasPiece("black", x+i, y-i) then
			table.insert(moves, {x+i,y-i})
			break
		end
		table.insert(moves, {x+i,y-i})
	end
	-- move right-down
	for i = 1, quadsRightDown do
		if self:hasPiece("white", x+i, y+i) then
			break
		end
		if self:hasPiece("black", x+i, y+i) then
			table.insert(moves, {x+i,y+i})
			break
		end
		table.insert(moves, {x+i,y+i})
	end
	-- move left-down
	for i = 1, quadsLeftDown do
		if self:hasPiece("white", x-i, y+i) then
			break
		end
		if self:hasPiece("black", x-i, y+i) then
			table.insert(moves, {x-i,y+i})
			break
		end
		table.insert(moves, {x-i,y+i})
	end
	return moves
end

function Board:getKingMoves(x, y)
	local moves = {}
	-- move left
	if x > 1 then
		if not self:hasPiece("white", x-1, y) then
			table.insert(moves, {x-1,y})
		end
	end
	-- move left-up
	if x > 1 and y > 1 then
		if not self:hasPiece("white", x-1, y-1) then
			table.insert(moves, {x-1,y-1})
		end
	end
	-- move up
	if y > 1 then
		if not self:hasPiece("white", x, y-1) then
			table.insert(moves, {x,y-1})
		end
	end
	-- move right-up
	if x < 8 and y > 1 then
		if not self:hasPiece("white", x+1, y-1) then
			table.insert(moves, {x+1,y-1})
		end
	end
	-- move right
	if x < 8 then
		if not self:hasPiece("white", x+1, y) then
			table.insert(moves, {x+1,y})
		end
	end
	-- move right-down
	if x < 8 and y < 8 then
		if not self:hasPiece("white", x+1, y+1) then
			table.insert(moves, {x+1,y+1})
		end
	end
	-- move down
	if y < 8 then
		if not self:hasPiece("white", x, y+1) then
			table.insert(moves, {x,y+1})
		end
	end
	-- move down-left
	if x > 1 and y < 8 then
		if not self:hasPiece("white", x-1, y+1) then
			table.insert(moves, {x-1, y+1})
		end
	end
	return moves
end

function Board:getQueenMoves(x, y)
	local quadsLeft = x-1
	local quadsRight = 8-x
	local quadsUp = y-1
	local quadsDown = 8-y
	local quadsLeftUp = math.min(quadsLeft, quadsUp)
	local quadsRightUp = math.min(quadsRight, quadsUp)
	local quadsRightDown = math.min(quadsRight, quadsDown)
	local quadsLeftDown = math.min(quadsLeft, quadsDown)
	local moves = {}
	-- move left-up
	for i = 1, quadsLeftUp do
		if self:hasPiece("white", x-i, y-i) then
			break
		end
		if self:hasPiece("black", x-i, y-i) then
			table.insert(moves, {x-i,y-i})
			break
		end
		table.insert(moves, {x-i,y-i})
	end
	-- move right-up
	for i = 1, quadsRightUp do
		if self:hasPiece("white", x+i, y-i) then
			break
		end
		if self:hasPiece("black", x+i, y-i) then
			table.insert(moves, {x+i,y-i})
			break
		end
		table.insert(moves, {x+i,y-i})
	end
	-- move right-down
	for i = 1, quadsRightDown do
		if self:hasPiece("white", x+i, y+i) then
			break
		end
		if self:hasPiece("black", x+i, y+i) then
			table.insert(moves, {x+i,y+i})
			break
		end
		table.insert(moves, {x+i,y+i})
	end
	-- move left-down
	for i = 1, quadsLeftDown do
		if self:hasPiece("white", x-i, y+i) then
			break
		end
		if self:hasPiece("black", x-i, y+i) then
			table.insert(moves, {x-i,y+i})
			break
		end
		table.insert(moves, {x-i,y+i})
	end
	-- move right
	for i = 1, quadsRight do
		if self:hasPiece("white", x+i, y) then
			break
		end
		if self:hasPiece("black", x+i, y) then
			table.insert(moves, {x+i, y})
			break
		end
		table.insert(moves, {x+i, y})
	end
	-- move up
	for i = 1, quadsUp do
		if self:hasPiece("white", x, y-i) then
			break
		end
		if self:hasPiece("black", x, y-i) then
			table.insert(moves, {x,y-i})
			break
		end
		table.insert(moves, {x,y-i})
	end
	-- move left
	for i = 1, quadsLeft do
		if self:hasPiece("white", x-i, y) then
			break
		end
		if self:hasPiece("black", x-i, y) then
			table.insert(moves, {x-i, y})
			break
		end
		table.insert(moves, {x-i, y})
	end
	-- move down
	for i = 1, quadsDown do
		if self:hasPiece("white", x, y+i) then
			break
		end
		if self:hasPiece("black", x, y+i) then
			table.insert(moves, {x,y+i})
			break
		end
		table.insert(moves, {x, y+i})
	end
	return moves
end

function Board:getKnightMoves(x, y)
	local moves = {}
	-- move left then up
	if x > 2 and y > 1 then
		if not self:hasPiece("white", x-2, y-1) then
			table.insert(moves, {x-2,y-1})
		end
	end
	-- move up then left
	if x > 1 and y > 2 then
		if not self:hasPiece("white", x-1, y-2) then
			table.insert(moves, {x-1,y-2})
		end
	end
	-- move up then right
	if x < 8 and y > 2 then
		if not self:hasPiece("white", x+1, y-2) then
			table.insert(moves, {x+1, y-2})
		end
	end
	-- move right then up
	if x < 7 and y > 1 then
		if not self:hasPiece("white", x+2, y-1) then
			table.insert(moves, {x+2, y-1})
		end
	end
	-- move right then down
	if x < 7 and y < 8 then
		if not self:hasPiece("white", x+2, y+1) then
			table.insert(moves, {x+2, y+1})
		end
	end
	-- move down then right
	if x < 8 and y < 7 then
		if not self:hasPiece("white", x+1, y+2) then
			table.insert(moves, {x+1, y+2})
		end
	end
	-- move down then left
	if x > 1 and y < 7 then
		if not self:hasPiece("white", x-1, y+2) then
			table.insert(moves, {x-1, y+2})
		end
	end
	-- move left then down
	if x > 2 and y < 8 then
		if not self:hasPiece("white", x-2, y+1) then
			table.insert(moves, {x-2, y+1})
		end
	end
	return moves
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
			local moves = self:getPawnMoves(x1, y1)
			if self:hasMove(moves, x2, y2) then
				return true
			end
			return false
		end
		if type == "rook" then
			local moves = self:getRookMoves(x1, y1)
			if self:hasMove(moves, x2, y2) then
				return true
			end
			return false
		end
		if type == "bishop" then
			local moves = self:getBishopMoves(x1, y1)
			if self:hasMove(moves, x2, y2) then
				return true
			end
			return false
		end
		if type == "king" then
			local moves = self:getKingMoves(x1, y1)
			if self:hasMove(moves, x2, y2) then
				return true
			end
			return false
		end
		if type == "queen" then
			local moves = self:getQueenMoves(x1, y1)
			if self:hasMove(moves, x2, y2) then
				return true
			end
			return false
		end
		if type == "knight" then
			local moves = self:getKnightMoves(x1, y1)
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

--[[function Board:alternateColor()
	if self.quadColor == "white" then
		self.quadColor = "black"
		love.graphics.setColor(0.5, 0.5, 0.5, 1)
	elseif self.quadColor == "black" then
		self.quadColor = "white"
		love.graphics.setColor(1, 1, 1, 1)
	end
end]]

--[[function Board:drawBoard()
	for i=1, 8 do
		for j=1, 8 do
			love.graphics.rectangle("fill", 75*(i-1), 75*(j-1), 75, 75)
			if j ~= 8 then
				self:alternateColor()
			end
		end
	end
end]]

--[[function Board:drawPieces()
	local pointer = self.sprites
	while pointer ~= nil do
		pointer:draw()
		pointer = pointer:getNext()
	end
end]]

--[[function Board:draw()
	self:drawBoard()
	self:drawPieces()
end]]

return Board

