local Piece = {}

function Piece:new(color)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.color = color
	return o
end

function Piece:hasPiece(color, x, y)
	local piece = self.board[x][y]
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

function Piece:setBoard(board)
	self.board = board
end

function Piece:getColor()
	return self.color
end

function Piece:reverseArray(array)
	local reversed = {}
	local j = 0
	for i = table.getn(array), 1, -1 do
		j = (j + 1)
		reversed[j] = array[i]
	end
	return reversed
end

return Piece