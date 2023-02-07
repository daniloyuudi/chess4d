local Pawn = require("Pawn")
local Rook = require("Rook")
local Knight = require("Knight")
local Bishop = require("Bishop")
local Queen = require("Queen")
local King = require("King")

local AI = {
	DEPTH = 3
}

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

function AI:getBoardsWhite(currentBoard)
	-- get possible moves from a board
	local boards = {}
	for i = 1, 8 do
		for j = 1, 8 do
			local piece = currentBoard[i][j]
			if piece ~= nil and piece:getColor() == "white" then
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

function AI:getBoardsBlack(currentBoard)
	-- get possible moves from a board
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

function AI:getChildren(currentNode, level)
	local boards = self:getBoardsBlack(currentNode.board)
	if (AI.DEPTH - level) % 2 == 1 then
		boards = self:getBoardsWhite(currentNode.board)
	end
	currentNode.children = {}
	for _, board in ipairs(boards) do
		local childNode = {}
		childNode.board = board
		table.insert(currentNode.children, childNode)
	end
	if level-1 > 0 then
		for _, child in ipairs(currentNode.children) do
			self:getChildren(child, level-1)
		end
	end
end

function AI:newTree(currentBoard, depth)
	-- get tree from current board with given depth
	self.tree = {}
	self.tree.board = currentBoard
	if depth > 0 then
		self:getChildren(self.tree, depth)
	end
end

function AI:evaluateNode(node, turn)
	if node.children ~= nil then
		if turn == "max" then
			local max = self:evaluateNode(node.children[1], "min")
			for i = 2, table.getn(node.children) do
				local value = self:evaluateNode(node.children[i], "min")
				if value > max then
					max = value
				end
			end
			return max
		elseif turn == "min" then
			local min = self:evaluateNode(node.children[1], "max")
			for i = 2, table.getn(node.children) do
				local value = self:evaluateNode(node.children[i], "max")
				if value < min then
					min = value
				end
			end
			return min
		end
	else
		return self:evaluateBoard(node.board)
	end
end

function AI:getMaxValueNode(tree)
	local max = self:evaluateNode(tree.children[1], "min")
	local index = 1
	for i = 2, table.getn(tree.children) do
		local value = self:evaluateNode(tree.children[i], "min")
		if value >= max then
			max = value
			index = i
		end
	end
	return index
end

function AI:setBoardMatrix(matrix)
	self.boardMatrix = matrix
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

function AI:getMoveFromChildNode(index)
	local rootBoard = self.tree.board
	local targetChildNode = self.tree.children[index]
	local targetBoard = targetChildNode.board
	return self:getMatrixDiff(rootBoard, targetBoard)
end

function AI:getNextMoveMiniMax()
	-- generate tree
	self:newTree(self.boardMatrix, AI.DEPTH)
	-- explore tree for best move
	local index = self:getMaxValueNode(self.tree)
	return self:getMoveFromChildNode(index)
end

return AI