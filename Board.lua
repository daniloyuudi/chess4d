local Piece = require("Piece")

local Board = {}

function Board:loadMatrix()
	self.pieces = {}
	for i = 1, 8 do
		self.pieces[i] = {}
	end
end

function Board:loadNewGame()
	self.pieces[1][1] = Piece:new("black", "rook")
	self.pieces[2][1] = Piece:new("black", "knight")
	self.pieces[3][1] = Piece:new("black", "bishop")
	self.pieces[4][1] = Piece:new("black", "queen")
	self.pieces[5][1] = Piece:new("black", "king")
	self.pieces[6][1] = Piece:new("black", "bishop")
	self.pieces[7][1] = Piece:new("black", "knight")
	self.pieces[8][1] = Piece:new("black", "rook")
	for i = 1, 8 do
		self.pieces[i][2] = Piece:new("black", "pawn")
	end

	self.pieces[1][8] = Piece:new("white", "rook")
	self.pieces[2][8] = Piece:new("white", "knight")
	self.pieces[3][8] = Piece:new("white", "bishop")
	self.pieces[4][8] = Piece:new("white", "queen")
	self.pieces[5][8] = Piece:new("white", "king")
	self.pieces[6][8] = Piece:new("white", "bishop")
	self.pieces[7][8] = Piece:new("white", "knight")
	self.pieces[8][8] = Piece:new("white", "rook")
	for i = 1, 8 do
		self.pieces[i][7] = Piece:new("white", "pawn")
	end	
end

function Board:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.quadColor = "white"
	o:loadMatrix()
	o:loadNewGame()
	return o
end

function Board:hasPiece(color, x, y)
	local piece = self.pieces[x][y]
	if piece ~= nil then
		if piece:getColor() == color then
			return true
		end
	end
	return false
end

function Board:movePiece(x1, y1, x2, y2)
	self.pieces[x2][y2] = self.pieces[x1][y1]
	self.pieces[x1][y1] = nil
end

function Board:alternateColor()
	if self.quadColor == "white" then
		self.quadColor = "black"
		love.graphics.setColor(0.5, 0.5, 0.5, 1)
	elseif self.quadColor == "black" then
		self.quadColor = "white"
		love.graphics.setColor(1, 1, 1, 1)
	end
end

function Board:drawBoard()
	for i=1, 8 do
		for j=1, 8 do
			love.graphics.rectangle("fill", 75*(i-1), 75*(j-1), 75, 75)
			if j ~= 8 then
				self:alternateColor()
			end
		end
	end
end

function Board:drawPieces()
	for i = 1, 8 do
		for j = 1, 8 do
			local piece = self.pieces[i][j]
			if piece ~= nil then
				self.pieces[i][j]:draw((i-1)*75,(j-1)*75)
			end
		end
	end
end

function Board:draw()
	self:drawBoard()
	self:drawPieces()
end

return Board

