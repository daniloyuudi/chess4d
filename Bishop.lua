local Piece = require("Piece")

local Bishop = Piece:new()

Bishop.evaluationWhite = {
	{-2.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -2.0},
	{-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0},
	{-1.0, 0.0, 0.5, 1.0, 1.0, 0.5, 0.0, -1.0},
	{-1.0, 0.5, 0.5, 1.0, 1.0, 0.5, 0.5, -1.0},
	{-1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, -1.0},
	{-1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, -1.0},
	{-1.0, 0.5, 0.0, 0.0, 0.0, 0.0, 0.5, -1.0},
	{-2.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -2.0}
}

function Bishop:new(color)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.color = color
	o.evaluationBlack = self:reverseArray(self.evaluationWhite)
	return o
end

function Bishop:copyPrototype(prototype)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.color = prototype.color
	o.board = prototype.board
	o.evaluationBlack = prototype.evaluationBlack
	return o
end

function Bishop:clone()
	return self:copyPrototype(self)
end

function Bishop:getMoves(x, y)
	local quadsLeft = x-1
	local quadsRight = 8-x
	local quadsUp = y-1
	local quadsDown = 8-y
	local quadsLeftUp = math.min(quadsLeft, quadsUp)
	local quadsRightUp = math.min(quadsRight, quadsUp)
	local quadsRightDown = math.min(quadsRight, quadsDown)
	local quadsLeftDown = math.min(quadsLeft, quadsDown)
	local moves = {}
	if self.color == "white" then
		-- move left-up
		for i = 1, quadsLeftUp do
			if not self:hasPiece("white", x-i, y-i) then
				table.insert(moves, {x-i, y-i})
			end
			if self:hasPiece("any", x-i, y-i) then
				break
			end
		end
		-- move right-up
		for i = 1, quadsRightUp do
			if not self:hasPiece("white", x+i, y-i) then
				table.insert(moves, {x+i, y-i})
			end
			if self:hasPiece("any", x+i, y-i) then
				break
			end
		end
		-- move right-down
		for i = 1, quadsRightDown do
			if not self:hasPiece("white", x+i, y+i) then
				table.insert(moves, {x+i, y+i})
			end
			if self:hasPiece("any", x+i, y+i) then
				break
			end
		end
		-- move left-down
		for i = 1, quadsLeftDown do
			if not self:hasPiece("white", x-i, y+i) then
				table.insert(moves, {x-i, y+i})
			end
			if self:hasPiece("any", x-i, y+i) then
				break
			end
		end
	elseif self.color == "black" then
		-- move left-up
		for i = 1, quadsLeftUp do
			if not self:hasPiece("black", x-i, y-i) then
				table.insert(moves, {x-i, y-i})
			end
			if self:hasPiece("any", x-i, y-i) then
				break
			end
		end
		-- move right-up
		for i = 1, quadsRightUp do
			if not self:hasPiece("black", x+i, y-i) then
				table.insert(moves, {x+i, y-i})
			end
			if self:hasPiece("any", x+i, y-i) then
				break
			end
		end
		-- move right-down
		for i = 1, quadsRightDown do
			if not self:hasPiece("black", x+i, y+i) then
				table.insert(moves, {x+i, y+i})
			end
			if self:hasPiece("any", x+i, y+i) then
				break
			end
		end
		-- move left-down
		for i = 1, quadsLeftDown do
			if not self:hasPiece("black", x-i, y+i) then
				table.insert(moves, {x-i, y+i})
			end
			if self:hasPiece("any", x-i, y+i) then
				break
			end
		end
	end
	return moves
end

function Bishop:getValue(x, y)
	if self.color == "black" then
		return 30 + self.evaluationBlack[y][x]
	elseif self.color == "white" then
		return -(30 + self.evaluationWhite[y][x])
	end
end

return Bishop