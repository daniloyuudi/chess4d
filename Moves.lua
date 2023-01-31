local Moves = {}

function Moves:new(boardState)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Moves:hasPiece(color, x, y)
	local piece = self.boardMatrix[x][y]
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

function Moves:getPawnMoves(x, y, color)
	local moves = {}
	if color == "white" then
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
		if y == 2 then
			if not self:hasPiece("any", x, y-2) then
				table.insert(moves, {x, y-2})
			end
		end
	elseif color == "black" then
		-- capture left
		if x > 1 then
			if self:hasPiece("white", x-1, y+1) then
				table.insert(moves, {x-1, y+1})
			end
		end
		-- capture right
		if x < 8 then
			if self:hasPiece("white", x+1, y+1) then
				table.insert(moves, {x+1, y+1})
			end
		end
		-- move forward
		if not self:hasPiece("any", x, y+1) then
			table.insert(moves, {x, y+1})
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

function Moves:getRookMoves(x, y, color)
	local quadsLeft = x-1
	local quadsRight = 8-x
	local quadsUp = y-1
	local quadsDown = 8-y
	local moves = {}
	if color == "white" then
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
			if not self:hasPiece("white", x, y-1) then
				table.insert(moves, {x, y-1})
			end
			if self:hasPiece("any", x, y-1) then
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
			if not self:hasPiece("white", x, y+1) then
				table.insert(moves, {x, y+1})
			end
			if self:hasPiece("any", x, y+1) then
				break
			end
		end
	elseif color == "black" then
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
			if not self:hasPiece("black", x, y-1) then
				table.insert(moves, {x, y-1})
			end
			if self:hasPiece("any", x, y-1) then
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
			if not self:hasPiece("black", x, y+1) then
				table.insert(moves, {x, y+1})
			end
			if self:hasPiece("any", x, y+1) then
				break
			end
		end
	end
	return moves
end

function Moves:getBishopMoves(x, y, color)
	local quadsLeft = x-1
	local quadsRight = 8-x
	local quadsUp = y-1
	local quadsDown = 8-y
	local quadsLeftUp = math.min(quadsLeft, quadsUp)
	local quadsRightUp = math.min(quadsRight, quadsUp)
	local quadsRightDown = math.min(quadsRight, quadsDown)
	local quadsLeftDown = math.min(quadsLeft, quadsDown)
	local moves = {}
	if color == "white" then
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
	elseif color == "black" then
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

function Moves:getKnightMoves(x, y, color)
	local moves = {}
	if color == "white" then
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
	elseif color == "black" then
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

function Moves:getQueenMoves(x, y, color)
	local quadsLeft = x-1
	local quadsRight = 8-x
	local quadsUp = y-1
	local quadsDown = 8-y
	local quadsLeftUp = math.min(quadsLeft, quadsUp)
	local quadsRightUp = math.min(quadsRight, quadsUp)
	local quadsRightDown = math.min(quadsRight, quadsDown)
	local quadsLeftDown = math.min(quadsLeft, quadsDown)
	local moves = {}
	if color == "white" then
		-- move right
		for i = 1, quadsRight do
			if not self:hasPiece("white", x+i, y) then
				table.insert(moves, {x+i, y})
			end
			if self:hasPiece("any", x+i, y) then
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
		-- move up
		for i = 1, quadsUp do
			if not self:hasPiece("white", x, y-1) then
				table.insert(moves, {x, y-1})
			end
			if self:hasPiece("any", x, y-1) then
				break
			end
		end
		-- move left-up
		for i = 1, quadsLeftUp do
			if not self:hasPiece("white", x-i, y-i) then
				table.insert(moves, {x-i, y-i})
			end
			if self:hasPiece("any", x-i, y-i) then
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
		-- move left-down
		for i = 1, quadsLeftDown do
			if not self:hasPiece("white", x-i, y+i) then
				table.insert(moves, {x-i, y+i})
			end
			if self:hasPiece("any", x-i, y+i) then
				break
			end
		end
		-- move down
		for i = 1, quadsDown do
			if not self:hasPiece("white", x, y+1) then
				table.insert(moves, {x, y+1})
			end
			if self:hasPiece("any", x, y+1) then
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
	elseif color == "black" then
		-- move right
		for i = 1, quadsRight do
			if not self:hasPiece("black", x+i, y) then
				table.insert(moves, {x+i, y})
			end
			if self:hasPiece("any", x+i, y) then
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
		-- move up
		for i = 1, quadsUp do
			if not self:hasPiece("black", x, y-1) then
				table.insert(moves, {x, y-1})
			end
			if self:hasPiece("any", x, y-1) then
				break
			end
		end
		-- move left-up
		for i = 1, quadsLeftUp do
			if not self:hasPiece("black", x-i, y-i) then
				table.insert(moves, {x-i, y-i})
			end
			if self:hasPiece("any", x-i, y-i) then
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
		-- move left-down
		for i = 1, quadsLeftDown do
			if not self:hasPiece("black", x-i, y+i) then
				table.insert(moves, {x-i, y+i})
			end
			if self:hasPiece("any", x-i, y+i) then
				break
			end
		end
		-- move down
		for i = 1, quadsDown do
			if not self:hasPiece("black", x, y+1) then
				table.insert(moves, {x, y+1})
			end
			if self:hasPiece("any", x, y+1) then
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
	end
	return moves
end

function Moves:getKingMoves(x, y, color)
	local moves = {}
	if color == "white" then
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
	elseif color == "black" then
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

function Moves:setBoardMatrix(matrix)
	self.boardMatrix = matrix
end

return Moves