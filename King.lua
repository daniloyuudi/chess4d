local Piece = require("Piece")

local King = Piece:new()

King.evaluationWhite = {
	{-3.0, -4.0, -4.0, -5.0, -5.0, -4.0, -4.0, -3.0},
	{-3.0, -4.0, -4.0, -5.0, -5.0, -4.0, -4.0, -3.0},
	{-3.0, -4.0, -4.0, -5.0, -5.0, -4.0, -4.0, -3.0},
	{-3.0, -4.0, -4.0, -5.0, -5.0, -4.0, -4.0, -3.0},
	{-2.0, -3.0, -3.0, -4.0, -4.0, -3.0, -3.0, -2.0},
	{-1.0, -2.0, -2.0, -2.0, -2.0, -2.0, -2.0, -2.0, -1.0},
	{2.0, 2.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0},
	{2.0, 3.0, 1.0, 0.0, 0.0, 1.0, 3.0, 2.0}
}

function King:new(color)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.color = color
	o.evaluationBlack = self:reverseArray(self.evaluationWhite)
	return o
end

function King:copyPrototype(prototype)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.color = prototype.color
	o.board = prototype.board
	o.evaluationBlack = prototype.evaluationBlack
	return o
end

function King:clone()
	return King:copyPrototype(self)
end

function King:getMoves(x, y)
	local moves = {}
	if self.color == "white" then
		-- move left
		if x > 1 then
			if not self:hasPiece("white", x-1, y) then
				table.insert(moves, {x-1, y})
			end
		end
		-- move left-up
		if x > 1 and y > 1 then
			if not self:hasPiece("white", x-1, y-1) then
				table.insert(moves, {x-1, y-1})
			end
		end
		-- move up
		if y > 1 then
			if not self:hasPiece("white", x, y-1) then
				table.insert(moves, {x, y-1})
			end
		end
		-- move right-up
		if x < 8 and y > 1 then
			if not self:hasPiece("white", x+1, y-1) then
				table.insert(moves, {x+1, y-1})
			end
		end
		-- move right
		if x < 8 then
			if not self:hasPiece("white", x+1, y) then
				table.insert(moves, {x+1, y})
			end
		end
		-- move right-down
		if x < 8 and y < 8 then
			if not self:hasPiece("white", x+1, y+1) then
				table.insert(moves, {x+1, y+1})
			end
		end
		-- move down
		if y < 8 then
			if not self:hasPiece("white", x, y+1) then
				table.insert(moves, {x, y+1})
			end
		end
		-- move down-left
		if x > 1 and y < 8 then
			if not self:hasPiece("white", x-1, y+1) then
				table.insert(moves, {x-1, y+1})
			end
		end
	elseif self.color == "black" then
		-- move left
		if x > 1 then
			if not self:hasPiece("black", x-1, y) then
				table.insert(moves, {x-1, y})
			end
		end
		-- move left-up
		if x > 1 and y > 1 then
			if not self:hasPiece("black", x-1, y-1) then
				table.insert(moves, {x-1, y-1})
			end
		end
		-- move up
		if y > 1 then
			if not self:hasPiece("black", x, y-1) then
				table.insert(moves, {x, y-1})
			end
		end
		-- move right-up
		if x < 8 and y > 1 then
			if not self:hasPiece("black", x+1, y-1) then
				table.insert(moves, {x+1, y-1})
			end
		end
		-- move right
		if x < 8 then
			if not self:hasPiece("black", x+1, y) then
				table.insert(moves, {x+1, y})
			end
		end
		-- move right-down
		if x < 8 and y < 8 then
			if not self:hasPiece("black", x+1, y+1) then
				table.insert(moves, {x+1, y+1})
			end
		end
		-- move down
		if y < 8 then
			if not self:hasPiece("black", x, y+1) then
				table.insert(moves, {x, y+1})
			end
		end
		-- move down-left
		if x > 1 and y < 8 then
			if not self:hasPiece("black", x-1, y+1) then
				table.insert(moves, {x-1, y+1})
			end
		end
	end
	return moves
end

function King:getValue(x, y)
	if self.color == "black" then
		return 900 + self.evaluationBlack[y][x]
	elseif self.color == "white" then
		return -(900 + self.evaluationWhite[y][x])
	end
end

return King