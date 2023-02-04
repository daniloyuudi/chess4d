local Pawn = require("Pawn")
local Rook = require("Rook")
local Knight = require("Knight")
local Bishop = require("Bishop")
local Queen = require("Queen")
local King = require("King")

local AI = {}

function AI:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	return o
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
				local newPiece = piece:clone()
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
				local moves = piece:getMoves(i, j)
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
end

function AI:selectRandomMove(array)
	local arraySize = table.getn(array)
	local randomNumber = math.random(arraySize)
	return array[randomNumber]
end

function AI:evaluateBoard(matrix)
	local value = 0
	for i = 1, 8 do
		for j = 1, 8 do
			local piece = matrix[i][j]
			if piece ~= nil then
				value = value + piece:getValue()
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