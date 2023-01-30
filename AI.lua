local Piece = require("Piece")

local AI = {}

function AI:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function AI:hasPiece(color, x, y)
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

function AI:getPawnMoves(x, y)
	local moves = {}
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
	return moves
end

function AI:getRookMoves(x, y)
	local quadsLeft = x-1
	local quadsRight = 8-x
	local quadsUp = y-1
	local quadsDown = 8-y
	local moves = {}
	-- move right
	for i = 1, quadsRight do
		if self:hasPiece("black", x+i, y) then
			break
		end
		if self:hasPiece("white", x+i, y) then
			table.insert(moves, {x+i, y})
			break
		end
		table.insert(moves, {x+i, y})
	end
	-- move up
	for i = 1, quadsUp do
		if self:hasPiece("black", x, y-i) then
			break
		end
		if self:hasPiece("white", x, y-i) then
			table.insert(moves, {x,y-i})
			break
		end
		table.insert(moves, {x,y-i})
	end
	-- move left
	for i = 1, quadsLeft do
		if self:hasPiece("black", x-i, y) then
			break
		end
		if self:hasPiece("white", x-i, y) then
			table.insert(moves, {x-i, y})
			break
		end
		table.insert(moves, {x-i, y})
	end
	-- move down
	for i = 1, quadsDown do
		if self:hasPiece("black", x, y+i) then
			break
		end
		if self:hasPiece("white", x, y+i) then
			table.insert(moves, {x,y+i})
			break
		end
		table.insert(moves, {x, y+i})
	end
	return moves
end

function AI:getBishopMoves(x, y)
	local quadsLeft = x-1
	local quadsRight = 8-x
	local quadsUp = y-1
	local quadsDown = 8-y
	local quadsLeftUp = math.min(quadsLeft, quadsUp)
	local quadsRightUp = math.min(quadsRight, quadsUp)
	local quadsRightDown = math.min(quadsRight, quadsDown)
	local quadsLeftDown = math.min(quadsLeft, quadsDown)
	local moves = {}
	-- move left-up
	for i = 1, quadsLeftUp do
		if self:hasPiece("black", x-i, y-i) then
			break
		end
		if self:hasPiece("white", x-i, y-i) then
			table.insert(moves, {x-i,y-i})
			break
		end
		table.insert(moves, {x-i,y-i})
	end
	-- move right-up
	for i = 1, quadsRightUp do
		if self:hasPiece("black", x+i, y-i) then
			break
		end
		if self:hasPiece("white", x+i, y-i) then
			table.insert(moves, {x+i,y-i})
			break
		end
		table.insert(moves, {x+i,y-i})
	end
	-- move right-down
	for i = 1, quadsRightDown do
		if self:hasPiece("black", x+i, y+i) then
			break
		end
		if self:hasPiece("white", x+i, y+i) then
			table.insert(moves, {x+i,y+i})
			break
		end
		table.insert(moves, {x+i,y+i})
	end
	-- move left-down
	for i = 1, quadsLeftDown do
		if self:hasPiece("black", x-i, y+i) then
			break
		end
		if self:hasPiece("white", x-i, y+i) then
			table.insert(moves, {x-i,y+i})
			break
		end
		table.insert(moves, {x-i,y+i})
	end
	return moves
end

function AI:getKnightMoves(x, y)
	local moves = {}
	-- move left then up
	if x > 2 and y > 1 then
		if not self:hasPiece("black", x-2, y-1) then
			table.insert(moves, {x-2,y-1})
		end
	end
	-- move up then left
	if x > 1 and y > 2 then
		if not self:hasPiece("black", x-1, y-2) then
			table.insert(moves, {x-1,y-2})
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
	return moves
end

function AI:getQueenMoves(x, y)
	local quadsLeft = x-1
	local quadsRight = 8-x
	local quadsUp = y-1
	local quadsDown = 8-y
	local quadsLeftUp = math.min(quadsLeft, quadsUp)
	local quadsRightUp = math.min(quadsRight, quadsUp)
	local quadsRightDown = math.min(quadsRight, quadsDown)
	local quadsLeftDown = math.min(quadsLeft, quadsDown)
	local moves = {}
	-- move left-up
	for i = 1, quadsLeftUp do
		if self:hasPiece("black", x-i, y-i) then
			break
		end
		if self:hasPiece("white", x-i, y-i) then
			table.insert(moves, {x-i,y-i})
			break
		end
		table.insert(moves, {x-i,y-i})
	end
	-- move right-up
	for i = 1, quadsRightUp do
		if self:hasPiece("black", x+i, y-i) then
			break
		end
		if self:hasPiece("white", x+i, y-i) then
			table.insert(moves, {x+i,y-i})
			break
		end
		table.insert(moves, {x+i,y-i})
	end
	-- move right-down
	for i = 1, quadsRightDown do
		if self:hasPiece("black", x+i, y+i) then
			break
		end
		if self:hasPiece("white", x+i, y+i) then
			table.insert(moves, {x+i,y+i})
			break
		end
		table.insert(moves, {x+i,y+i})
	end
	-- move left-down
	for i = 1, quadsLeftDown do
		if self:hasPiece("black", x-i, y+i) then
			break
		end
		if self:hasPiece("white", x-i, y+i) then
			table.insert(moves, {x-i,y+i})
			break
		end
		table.insert(moves, {x-i,y+i})
	end
	-- move right
	for i = 1, quadsRight do
		if self:hasPiece("black", x+i, y) then
			break
		end
		if self:hasPiece("white", x+i, y) then
			table.insert(moves, {x+i, y})
			break
		end
		table.insert(moves, {x+i, y})
	end
	-- move up
	for i = 1, quadsUp do
		if self:hasPiece("black", x, y-i) then
			break
		end
		if self:hasPiece("white", x, y-i) then
			table.insert(moves, {x,y-i})
			break
		end
		table.insert(moves, {x,y-i})
	end
	-- move left
	for i = 1, quadsLeft do
		if self:hasPiece("black", x-i, y) then
			break
		end
		if self:hasPiece("white", x-i, y) then
			table.insert(moves, {x-i, y})
			break
		end
		table.insert(moves, {x-i, y})
	end
	-- move down
	for i = 1, quadsDown do
		if self:hasPiece("black", x, y+i) then
			break
		end
		if self:hasPiece("white", x, y+i) then
			table.insert(moves, {x,y+i})
			break
		end
		table.insert(moves, {x, y+i})
	end
	return moves
end

function AI:getKingMoves(x, y)
	local moves = {}
	-- move left
	if x > 1 then
		if not self:hasPiece("black", x-1, y) then
			table.insert(moves, {x-1,y})
		end
	end
	-- move left-up
	if x > 1 and y > 1 then
		if not self:hasPiece("black", x-1, y-1) then
			table.insert(moves, {x-1,y-1})
		end
	end
	-- move up
	if y > 1 then
		if not self:hasPiece("black", x, y-1) then
			table.insert(moves, {x,y-1})
		end
	end
	-- move right-up
	if x < 8 and y > 1 then
		if not self:hasPiece("black", x+1, y-1) then
			table.insert(moves, {x+1,y-1})
		end
	end
	-- move right
	if x < 8 then
		if not self:hasPiece("black", x+1, y) then
			table.insert(moves, {x+1,y})
		end
	end
	-- move right-down
	if x < 8 and y < 8 then
		if not self:hasPiece("black", x+1, y+1) then
			table.insert(moves, {x+1,y+1})
		end
	end
	-- move down
	if y < 8 then
		if not self:hasPiece("black", x, y+1) then
			table.insert(moves, {x,y+1})
		end
	end
	-- move down-left
	if x > 1 and y < 8 then
		if not self:hasPiece("black", x-1, y+1) then
			table.insert(moves, {x-1, y+1})
		end
	end
	return moves
end

function AI:getPossibleMoves(x, y, piece)
	local type = piece:getType()
	if type == "pawn" then
		return self:getPawnMoves(x, y)
	elseif type == "rook" then
		return self:getRookMoves(x, y)
	elseif type == "knight" then
		return self:getKnightMoves(x, y)
	elseif type == "bishop" then
		return self:getBishopMoves(x, y)
	elseif type == "queen" then
		return self:getQueenMoves(x, y)
	elseif type == "king" then
		return self:getKingMoves(x, y)
	end
	return {}
end

function AI:copyMatrix(matrix)
	local newMatrix = {}
	for i = 1, 8 do
		newMatrix[i] = {}
	end
	for i = 1, 8 do
		for j = 1, 8 do
			local piece = matrix[i][j]
			if piece ~= nil then
				local newPiece = Piece:new(piece:getColor(), piece:getType())
				newMatrix[i][j] = newPiece
			end
		end
	end
	return newMatrix
end

function AI:movePiece(matrix, x1, y1, x2, y2)
	matrix[x2][y2] = matrix[x1][y1]
	matrix[x1][y1] = nil
end

function AI:getBoards(currentBoard)
	-- get possible moves from a board recursively
	local boards = {}
	for i = 1, 8 do
		for j = 1, 8 do
			local piece = currentBoard[i][j]
			if piece ~= nil and piece:getColor() == "black" then
				local moves = self:getPossibleMoves(i, j, piece)
				if next(moves) then
					for _, v in ipairs(moves) do
						local newBoard = self:copyMatrix(currentBoard)
						local destinationX, destinationY = v[1], v[2]
						self:movePiece(newBoard, i, j, destinationX, destinationY)
						table.insert(boards, newBoard) -- add new move to array
					end
				end
			end
		end
	end
	return boards
end

function AI:setBoardMatrix(boardMatrix)
	self.boardMatrix = boardMatrix
end

function AI:selectRandomMove(array)
	local arraySize = table.getn(array)
	local randomNumber = math.random(arraySize)
	return array[randomNumber]
end

function AI:getPieceValue(piece)
	local type = piece:getType()
	local color = piece:getColor()
	if color == "black" then
		if type == "pawn" then
			return 10
		elseif type == "knight" then
			return 30
		elseif type == "bishop" then
			return 30
		elseif type == "rook" then
			return 50
		elseif type == "queen" then
			return 90
		elseif type == "king" then
			return 900
		end
	elseif color == "white" then
		if type == "pawn" then
			return -10
		elseif type == "knight" then
			return -30
		elseif type == "bishop" then
			return -30
		elseif type == "rook" then
			return -50
		elseif type == "queen" then
			return -90
		elseif type == "king" then
			return -900
		end
	end
end

function AI:evaluateBoard(matrix)
	local value = 0
	for i = 1, 8 do
		for j = 1, 8 do
			local piece = matrix[i][j]
			if piece ~= nil then
				value = value + self:getPieceValue(piece)
			end
		end
	end
	return value
end

function AI:selectBestMove(array)
	-- check first if can capture any piece
	local firstValue = self:evaluateBoard(array[1])
	for i = 2, table.getn(array) do
		local board = array[i]
		local value = self:evaluateBoard(board)
		if value > firstValue then
			-- algorithm to capture a piece
			local highestValue = -1000000
			local selectedIndex = nil
			-- select strongest board in array
			for i, v in ipairs(array) do
				local value = self:evaluateBoard(v)
				print(value)
				if value > highestValue then
					highestValue = value
					selectedIndex = i
				end
			end
			return array[selectedIndex]
		end
	end
	-- all moves are the same so do random move
	return AI:selectRandomMove(array)
end

function AI:getMatrixDiff(matrix1, matrix2)
	local originX, originY
	local destinationX, destinationY
	for i = 1, 8 do
		for j = 1, 8 do
			local piece1 = matrix1[i][j]
			local piece2 = matrix2[i][j]
			if piece1 ~= nil and piece1:getColor() == "black"
				and piece2 == nil then
				originX, originY = i, j
			end
			if (piece1 == nil or piece1 ~= nil and piece1:getColor() == "white")
				and piece2 ~= nil and piece2:getColor() == "black" then
				destinationX, destinationY = i, j
			end
		end
	end
	return originX, originY, destinationX, destinationY
end

function AI:getNextMove()
	local moveArray = self:getBoards(self.boardMatrix)
	local selectedBoard = self:selectBestMove(moveArray)
	local originX, originY, destinationX, destinationY =
		self:getMatrixDiff(self.boardMatrix, selectedBoard)
	return originX, originY, destinationX, destinationY
end

return AI