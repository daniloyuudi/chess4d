local Piece = require("Piece")

local Rook = Piece:new()

function Rook:clone()
	return Rook:copyPrototype(self)
end

function Rook:getMoves(x, y)
	local quadsLeft = x-1
	local quadsRight = 8-x
	local quadsUp = y-1
	local quadsDown = 8-y
	local moves = {}
	if self.color == "white" then
		-- move right
		for i = 1, quadsRight do
			if not self:hasPiece("white", x+i, y) then
				table.insert(moves, {x+i, y})
			end
			if self:hasPiece("any", x+i, y) then
				break
			end
		end
		-- move up
		for i = 1, quadsUp do
			if not self:hasPiece("white", x, y-i) then
				table.insert(moves, {x, y-i})
			end
			if self:hasPiece("any", x, y-i) then
				break
			end
		end
		-- move left
		for i = 1, quadsLeft do
			if not self:hasPiece("white", x-i, y) then
				table.insert(moves, {x-i, y})
			end
			if self:hasPiece("any", x-i, y) then
				break
			end
		end
		-- move down
		for i = 1, quadsDown do
			if not self:hasPiece("white", x, y+i) then
				table.insert(moves, {x, y+i})
			end
			if self:hasPiece("any", x, y+i) then
				break
			end
		end
	elseif self.color == "black" then
		-- move right
		for i = 1, quadsRight do
			if not self:hasPiece("black", x+i, y) then
				table.insert(moves, {x+i, y})
			end
			if self:hasPiece("any", x+i, y) then
				break
			end
		end
		-- move up
		for i = 1, quadsUp do
			if not self:hasPiece("black", x, y-i) then
				table.insert(moves, {x, y-i})
			end
			if self:hasPiece("any", x, y-i) then
				break
			end
		end
		-- move left
		for i = 1, quadsLeft do
			if not self:hasPiece("black", x-i, y) then
				table.insert(moves, {x-i, y})
			end
			if self:hasPiece("any", x-i, y) then
				break
			end
		end
		-- move down
		for i = 1, quadsDown do
			if not self:hasPiece("black", x, y+i) then
				table.insert(moves, {x, y+i})
			end
			if self:hasPiece("any", x, y+i) then
				break
			end
		end
	end
	return moves
end

function Rook:getValue()
	if self.color == "black" then
		return 50
	elseif self.color == "white" then
		return -50
	end
end

return Rook