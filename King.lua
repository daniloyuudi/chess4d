local Piece = require("Piece")

local King = Piece:new()

function King:getMoves(x, y)
	local moves = {}
	if self.color == "white" then
		-- move left
		if x > 1 then
			if not self.board:hasPiece("white", x-1, y) then
				table.insert(moves, {x-1, y})
			end
		end
		-- move left-up
		if x > 1 and y > 1 then
			if not self.board:hasPiece("white", x-1, y-1) then
				table.insert(moves, {x-1, y-1})
			end
		end
		-- move up
		if y > 1 then
			if not self.board:hasPiece("white", x, y-1) then
				table.insert(moves, {x, y-1})
			end
		end
		-- move right-up
		if x < 8 and y > 1 then
			if not self.board:hasPiece("white", x+1, y-1) then
				table.insert(moves, {x+1, y-1})
			end
		end
		-- move right
		if x < 8 then
			if not self.board:hasPiece("white", x+1, y) then
				table.insert(moves, {x+1, y})
			end
		end
		-- move right-down
		if x < 8 and y < 8 then
			if not self.board:hasPiece("white", x+1, y+1) then
				table.insert(moves, {x+1, y+1})
			end
		end
		-- move down
		if y < 8 then
			if not self.board:hasPiece("white", x, y+1) then
				table.insert(moves, {x, y+1})
			end
		end
		-- move down-left
		if x > 1 and y < 8 then
			if not self.board:hasPiece("white", x-1, y+1) then
				table.insert(moves, {x-1, y+1})
			end
		end
	elseif color == "black" then
		-- move left
		if x > 1 then
			if not self.board:hasPiece("black", x-1, y) then
				table.insert(moves, {x-1, y})
			end
		end
		-- move left-up
		if x > 1 and y > 1 then
			if not self.board:hasPiece("black", x-1, y-1) then
				table.insert(moves, {x-1, y-1})
			end
		end
		-- move up
		if y > 1 then
			if not self.board:hasPiece("black", x, y-1) then
				table.insert(moves, {x, y-1})
			end
		end
		-- move right-up
		if x < 8 and y > 1 then
			if not self.board:hasPiece("black", x+1, y-1) then
				table.insert(moves, {x+1, y-1})
			end
		end
		-- move right
		if x < 8 then
			if not self.board:hasPiece("black", x+1, y) then
				table.insert(moves, {x+1, y})
			end
		end
		-- move right-down
		if x < 8 and y < 8 then
			if not self.board:hasPiece("black", x+1, y+1) then
				table.insert(moves, {x+1, y+1})
			end
		end
		-- move down
		if y < 8 then
			if not self.board:hasPiece("black", x, y+1) then
				table.insert(moves, {x, y+1})
			end
		end
		-- move down-left
		if x > 1 and y < 8 then
			if not self.board:hasPiece("black", x-1, y+1) then
				table.insert(moves, {x-1, y+1})
			end
		end
	end
	return moves
end

function King:getValue()
	if self.color == "black" then
		return 900
	elseif self.color == "white" then
		return -900
	end
end

return King