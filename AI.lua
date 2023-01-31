local Piece = require("Piece")
local Moves = require("Moves")

local AI = {}

function AI:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.moves = Moves:new()
	return o
end

function AI:getPossibleMoves(x, y, piece)
	local type = piece:getType()
	if type == "pawn" then
		return self.moves:getPawnMoves(x, y, "black")
	elseif type == "rook" then
		return self.moves:getRookMoves(x, y, "black")
	elseif type == "knight" then
		return self.moves:getKnightMoves(x, y, "black")
	elseif type == "bishop" then
		return self.moves:getBishopMoves(x, y, "black")
	elseif type == "queen" then
		return self.moves:getQueenMoves(x, y, "black")
	elseif type == "king" then
		return self.moves:getKingMoves(x, y, "black")
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

function AI:setBoardMatrix(matrix)
	self.boardMatrix = matrix
	self.moves:setBoardMatrix(matrix)
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