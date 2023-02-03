local Piece = require("Piece")

local Knight = Piece:new()

function Knight:getMoves(x, y)
	local moves = {}
	if self.color == "white" then
		-- move left then up
		if x > 2 and y > 1 then
			if not self.board:hasPiece("white", x-2, y-1) then
				table.insert(moves, {x-2, y-1})
			end
		end
		-- move up then left
		if x > 1 and y > 2 then
			if not self.board:hasPiece("white", x-1, y-2) then
				table.insert(moves, {x-1, y-2})
			end
		end
		-- move up then right
		if x < 8 and y > 2 then
			if not self.board:hasPiece("white", x+1, y-2) then
				table.insert(moves, {x+1, y-2})
			end
		end
		-- move right then up
		if x < 7 and y > 1 then
			if not self.board:hasPiece("white", x+2, y-1) then
				table.insert(moves, {x+2, y-1})
			end
		end
		-- move right then down
		if x < 7 and y < 8 then
			if not self.board:hasPiece("white", x+2, y+1) then
				table.insert(moves, {x+2, y+1})
			end
		end
		-- move down then right
		if x < 8 and y < 7 then
			if not self.board:hasPiece("white", x+1, y+2) then
				table.insert(moves, {x+1, y+2})
			end
		end
		-- move down then left
		if x > 1 and y < 7 then
			if not self.board:hasPiece("white", x-1, y+2) then
				table.insert(moves, {x-1, y+2})
			end
		end
		-- move left then down
		if x > 2 and y < 8 then
			if not self.board:hasPiece("white", x-2, y+1) then
				table.insert(moves, {x-2, y+1})
			end
		end
	elseif self.color == "black" then
		-- move left then up
		if x > 2 and y > 1 then
			if not self.board:hasPiece("black", x-2, y-1) then
				table.insert(moves, {x-2, y-1})
			end
		end
		-- move up then left
		if x > 1 and y > 2 then
			if not self.board:hasPiece("black", x-1, y-2) then
				table.insert(moves, {x-1, y-2})
			end
		end
		-- move up then right
		if x < 8 and y > 2 then
			if not self.board:hasPiece("black", x+1, y-2) then
				table.insert(moves, {x+1, y-2})
			end
		end
		-- move right then up
		if x < 7 and y > 1 then
			if not self.board:hasPiece("black", x+2, y-1) then
				table.insert(moves, {x+2, y-1})
			end
		end
		-- move right then down
		if x < 7 and y < 8 then
			if not self.board:hasPiece("black", x+2, y+1) then
				table.insert(moves, {x+2, y+1})
			end
		end
		-- move down then right
		if x < 8 and y < 7 then
			if not self.board:hasPiece("black", x+1, y+2) then
				table.insert(moves, {x+1, y+2})
			end
		end
		-- move down then left
		if x > 1 and y < 7 then
			if not self.board:hasPiece("black", x-1, y+2) then
				table.insert(moves, {x-1, y+2})
			end
		end
		-- move left then down
		if x > 2 and y < 8 then
			if not self.board:hasPiece("black", x-2, y+1) then
				table.insert(moves, {x-2, y+1})
			end
		end
	end
	return moves
end

function Knight:getValue()
	if self.color == "black" then
		return 30
	elseif self.color == "white" then
		return -30
	end
end

return Knight