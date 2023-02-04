local Piece = require("Piece")

local Queen = Piece:new()

function Queen:getMoves(x, y)
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
		-- move right
		for i = 1, quadsRight do
			if not self.board:hasPiece("white", x+i, y) then
				table.insert(moves, {x+i, y})
			end
			if self.board:hasPiece("any", x+i, y) then
				break
			end
		end
		-- move right-up
		for i = 1, quadsRightUp do
			if not self.board:hasPiece("white", x+i, y-i) then
				table.insert(moves, {x+i, y-i})
			end
			if self.board:hasPiece("any", x+i, y-i) then
				break
			end
		end
		-- move up
		for i = 1, quadsUp do
			if not self.board:hasPiece("white", x, y-i) then
				table.insert(moves, {x, y-i})
			end
			if self.board:hasPiece("any", x, y-i) then
				break
			end
		end
		-- move left-up
		for i = 1, quadsLeftUp do
			if not self.board:hasPiece("white", x-i, y-i) then
				table.insert(moves, {x-i, y-i})
			end
			if self.board:hasPiece("any", x-i, y-i) then
				break
			end
		end
		-- move left
		for i = 1, quadsLeft do
			if not self.board:hasPiece("white", x-i, y) then
				table.insert(moves, {x-i, y})
			end
			if self.board:hasPiece("any", x-i, y) then
				break
			end
		end
		-- move left-down
		for i = 1, quadsLeftDown do
			if not self.board:hasPiece("white", x-i, y+i) then
				table.insert(moves, {x-i, y+i})
			end
			if self.board:hasPiece("any", x-i, y+i) then
				break
			end
		end
		-- move down
		for i = 1, quadsDown do
			if not self.board:hasPiece("white", x, y+i) then
				table.insert(moves, {x, y+i})
			end
			if self.board:hasPiece("any", x, y+i) then
				break
			end
		end
		-- move right-down
		for i = 1, quadsRightDown do
			if not self.board:hasPiece("white", x+i, y+i) then
				table.insert(moves, {x+i, y+i})
			end
			if self.board:hasPiece("any", x+i, y+i) then
				break
			end
		end
	elseif self.color == "black" then
		-- move right
		for i = 1, quadsRight do
			if not self.board:hasPiece("black", x+i, y) then
				table.insert(moves, {x+i, y})
			end
			if self.board:hasPiece("any", x+i, y) then
				break
			end
		end
		-- move right-up
		for i = 1, quadsRightUp do
			if not self.board:hasPiece("black", x+i, y-i) then
				table.insert(moves, {x+i, y-i})
			end
			if self.board:hasPiece("any", x+i, y-i) then
				break
			end
		end
		-- move up
		for i = 1, quadsUp do
			if not self.board:hasPiece("black", x, y-i) then
				table.insert(moves, {x, y-i})
			end
			if self.board:hasPiece("any", x, y-i) then
				break
			end
		end
		-- move left-up
		for i = 1, quadsLeftUp do
			if not self.board:hasPiece("black", x-i, y-i) then
				table.insert(moves, {x-i, y-i})
			end
			if self.board:hasPiece("any", x-i, y-i) then
				break
			end
		end
		-- move left
		for i = 1, quadsLeft do
			if not self.board:hasPiece("black", x-i, y) then
				table.insert(moves, {x-i, y})
			end
			if self.board:hasPiece("any", x-i, y) then
				break
			end
		end
		-- move left-down
		for i = 1, quadsLeftDown do
			if not self.board:hasPiece("black", x-i, y+i) then
				table.insert(moves, {x-i, y+i})
			end
			if self.board:hasPiece("any", x-i, y+i) then
				break
			end
		end
		-- move down
		for i = 1, quadsDown do
			if not self.board:hasPiece("black", x, y+i) then
				table.insert(moves, {x, y+i})
			end
			if self.board:hasPiece("any", x, y+i) then
				break
			end
		end
		-- move right-down
		for i = 1, quadsRightDown do
			if not self.board:hasPiece("black", x+i, y+i) then
				table.insert(moves, {x+i, y+i})
			end
			if self.board:hasPiece("any", x+i, y+i) then
				break
			end
		end
	end
	return moves
end

function Queen:getValue()
	if self.color == "black" then
		return 90
	elseif self.color == "white" then
		return -90
	end
end

return Queen