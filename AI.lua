local Pawn = require("Pawn")
local Rook = require("Rook")
local Knight = require("Knight")
local Bishop = require("Bishop")
local Queen = require("Queen")
local King = require("King")

local AI = {
	DEPTH = 2
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

function AI:newNode(data)
	local node = {}
	node.data = data
	return node
end

function AI:getBlackMoves(node, level)
	node.children = {}
	for i = 1, 8 do
		for j = 1, 8 do
			local piece = node.data[i][j]
			if piece ~= nil and piece:getColor() == "black" then
				local moves = piece:getMoves(i, j)
				if next(moves) then
					for _, move in ipairs(moves) do
						local newBoard = self:copyMatrix(node.data)
						local destinationX, destinationY = move[1], move[2]
						self:movePiece(newBoard, i, j, destinationX, destinationY)
						local newChild = self:newNode(newBoard)
						table.insert(node.children, newChild)
					end
				end
			end
		end
	end
	if level-1 > 0 then
		for _, child in ipairs(node.children) do
			self:getWhiteMoves(child, level-1)
		end
	end
end

function AI:getWhiteMoves(node, level)
	node.children = {}
	for i = 1, 8 do
		for j = 1, 8 do
			local piece = node.data[i][j]
			if piece ~= nil and piece:getColor() == "white" then
				local moves = piece:getMoves(i, j)
				if next(moves) then
					for _, move in ipairs(moves) do
						local newBoard = self:copyMatrix(node.data)
						local destinationX, destinationY = move[1], move[2]
						self:movePiece(newBoard, i, j, destinationX, destinationY)
						local newChild = self:newNode(newBoard)
						table.insert(node.children, newChild)
					end
				end
			end
		end
	end
	if level-1 > 0 then
		for _, child in ipairs(node.children) do
			self:getBlackMoves(child, level-1)
		end
	end
end

function AI:generateTree()
	-- get tree from current board with given depth
	self.tree = self:newNode(self.boardMatrix)
	self:getBlackMoves(self.tree, self.DEPTH)
end

function AI:maximize(node)
	if node.children ~= nil then
		local max = -math.huge
		for _, child in ipairs(node.children) do
			local value = self:minimize(child)
			if value > max then
				max = value
			end
		end
		return max
	else
		return self:getUtility(node.data)
	end
end

function AI:minimize(node)
	if node.children ~= nil then
		local min = math.huge
		for _, child in ipairs(node.children) do
			local value = self:maximize(child)
			if value < min then
				min = value
			end
		end
		return min
	else
		return self:getUtility(node.data)
	end
end

function AI:maximizeFirst()
	local max = -math.huge
	local index = nil
	for key, child in ipairs(self.tree.children) do
		local value = self:minimize(child)
		print(key.."=", value)
		if value > max then
			max = value
			index = key
		end
	end
	print("selected=", index)
	return index
end

function AI:getNextMoveMiniMax()
	self:generateTree()
	local index = self:maximizeFirst()
	local selectedNode = self.tree.children[index].data
	return self:getMatrixDiff(self.tree.data, selectedNode)
end

function AI:setBoardMatrix(matrix)
	self.boardMatrix = matrix
end

function AI:getBoardValue(matrix)
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

function AI:getUtility(matrix)
	local originalValue = self:getBoardValue(self.tree.data)
	local finalValue = self:getBoardValue(matrix)
	return finalValue - originalValue
	--return self:getBoardValue(matrix)
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

return AI