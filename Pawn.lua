local Piece = require("Piece")

local Pawn = Piece:new()

Pawn.evaluationWhite = {
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
	{5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0},
	{1.0, 1.0, 2.0, 3.0, 3.0, 2.0, 1.0, 1.0},
	{0.5, 0.5, 1.0, 2.5, 2.5, 1.0, 0.5, 0.5},
	{0.0, 0.0, 0.0, 2.0, 2.0, 0.0, 0.0, 0.0},
	{0.5, -0.5, -1.0, 0.0, 0.0, -1.0, -0.5, 0.5},
	{0.5, 1.0, 1.0, -2.0, -2.0, 1.0, 1.0, 0.5},
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}
}

function Pawn:new(color)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.color = color
	o.evaluationBlack = self:reverseArray(self.evaluationWhite)
	return o
end

function Pawn:copyPrototype(prototype)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.color = prototype.color
	o.board = prototype.board
	o.evaluationBlack = prototype.evaluationBlack
	return o
end

function Pawn:clone()
	return self:copyPrototype(self)
end

function Pawn:getMoves(x, y)
	local moves = {}
	if self.color == "white" then
		-- capture left
		if x > 1 and y > 1 then
			if self:hasPiece("black", x-1, y-1) then
				table.insert(moves, {x-1, y-1})
			end
		end
		-- capture right
		if x < 8 and y > 1 then
			if self:hasPiece("black", x+1, y-1) then
				table.insert(moves, {x+1, y-1})
			end
		end
		-- move forward
		if y > 1 then
			if not self:hasPiece("any", x, y-1) then
				table.insert(moves, {x, y-1})
			end
		end
		-- opening move
		if y == 7 then
			if not self:hasPiece("any", x, y-2) then
				table.insert(moves, {x, y-2})
			end
		end
	elseif self.color == "black" then
		-- capture left
		if x > 1 and y < 8 then
			if self:hasPiece("white", x-1, y+1) then
				table.insert(moves, {x-1, y+1})
			end
		end
		-- capture right
		if x < 8 and y < 8 then
			if self:hasPiece("white", x+1, y+1) then
				table.insert(moves, {x+1, y+1})
			end
		end
		-- move forward
		if y < 8 then
			if not self:hasPiece("any", x, y+1) then
				table.insert(moves, {x, y+1})
			end
		end
		-- opening move
		if y == 2 then
			if not self:hasPiece("any", x, y+2) then
				table.insert(moves, {x, y+2})
			end
		end
	end
	return moves
end

function Pawn:getValue(x, y)
	if self.color == "black" then
		return 10 + self.evaluationBlack[y][x]
	elseif self.color == "white" then
		return -(10 + self.evaluationWhite[y][x])
	end
end

function Pawn:getModuleIndex()
	if self.color == "white" then
		return 1
	elseif self.color == "black" then
		return 2
	end
end

return Pawn