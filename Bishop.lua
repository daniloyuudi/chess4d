local Piece = require("Piece")

local Bishop = Piece:new()

function Bishop:clone()
	return Bishop:copyPrototype(self)
end

function Bishop:getMoves(x, y)
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
	elseif self.color == "black" then
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

function Bishop:getValue()
	if self.color == "black" then
		return 30
	elseif self.color == "white" then
		return -30
	end
end

return Bishop