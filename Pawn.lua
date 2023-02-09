local Piece = require("Piece")

local Pawn = Piece:new()

function Pawn:clone()
	return Pawn:copyPrototype(self)
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

function Pawn:getValue()
	if self.color == "black" then
		return 10
	elseif self.color == "white" then
		return -10
	end
end

return Pawn