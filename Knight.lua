local Piece = require("Piece")

local Knight = Piece:new()

Knight.evaluation = {
	{-5.0, -4.0, -3.0, -3.0, -3.0, -3.0, -4.0, -5.0},
	{-4.0, -2.0, 0.0, 0.0, 0.0, 0.0, -2.0, -4.0},
	{-3.0, 0.0, 1.0, 1.5, 1.5, 1.0, 0.0, -3.0},
	{-3.0, 0.5, 1.5, 2.0, 2.0, 1.5, 0.5, -3.0},
	{-3.0, 0.0, 1.5, 2.0, 2.0, 1.5, 0.0, -3.0},
	{-3.0, 0.5, 1.0, 1.5, 1.5, 1.0, 0.5, -3.0},
	{-4.0, -2.0, 0.0, 0.5, 0.5, 0.0, -2.0, -4.0},
	{-5.0, -4.0, -3.0, -3.0, -3.0, -3.0, -4.0, -5.0}
}

function Knight:new(color)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.color = color
	return o
end

function Knight:copyPrototype(prototype)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.color = prototype.color
	o.board = prototype.board
	return o
end

function Knight:clone()
	return self:copyPrototype(self)
end

function Knight:getMoves(x, y)
	local moves = {}
	if self.color == "white" then
		-- move left then up
		if x > 2 and y > 1 then
			if not self:hasPiece("white", x-2, y-1) then
				table.insert(moves, {x-2, y-1})
			end
		end
		-- move up then left
		if x > 1 and y > 2 then
			if not self:hasPiece("white", x-1, y-2) then
				table.insert(moves, {x-1, y-2})
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
	elseif self.color == "black" then
		-- move left then up
		if x > 2 and y > 1 then
			if not self:hasPiece("black", x-2, y-1) then
				table.insert(moves, {x-2, y-1})
			end
		end
		-- move up then left
		if x > 1 and y > 2 then
			if not self:hasPiece("black", x-1, y-2) then
				table.insert(moves, {x-1, y-2})
			end
		end
		-- move up then right
		if x < 8 and y > 2 then
			if not self:hasPiece("black", x+1, y-2) then
				table.insert(moves, {x+1, y-2})
			end
		end
		-- move right then up
		if x < 7 and y > 1 then
			if not self:hasPiece("black", x+2, y-1) then
				table.insert(moves, {x+2, y-1})
			end
		end
		-- move right then down
		if x < 7 and y < 8 then
			if not self:hasPiece("black", x+2, y+1) then
				table.insert(moves, {x+2, y+1})
			end
		end
		-- move down then right
		if x < 8 and y < 7 then
			if not self:hasPiece("black", x+1, y+2) then
				table.insert(moves, {x+1, y+2})
			end
		end
		-- move down then left
		if x > 1 and y < 7 then
			if not self:hasPiece("black", x-1, y+2) then
				table.insert(moves, {x-1, y+2})
			end
		end
		-- move left then down
		if x > 2 and y < 8 then
			if not self:hasPiece("black", x-2, y+1) then
				table.insert(moves, {x-2, y+1})
			end
		end
	end
	return moves
end

function Knight:getValue(x, y)
	if self.color == "black" then
		return 30 + self.evaluation[y][x]
	elseif self.color == "white" then
		return -(30 + self.evaluation[y][x])
	end
end

function Knight:getModuleIndex()
	if self.color == "white" then
		return 5
	elseif self.color == "black" then
		return 6
	end
end

return Knight