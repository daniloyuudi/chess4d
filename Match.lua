local Mouse = require("Mouse")
local Board = require("Board")
local BoardDrawer = require("BoardDrawer")
local AI = require("AI")

local Match = {}

function Match:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.turn = "white"
	o.selected = false
	o.selectedX = 0
	o.selectedY = 0
	o.mouse = Mouse:new()
	o.board = Board:new()
	o.boardDrawer = BoardDrawer:new(o.board)
	o.ai = AI:new()
	return o
end

function Match:getClickedQuad()
	local mouseX = love.mouse.getX()
	local mouseY = love.mouse.getY()
	return math.floor(mouseX / 75) + 1, math.floor(mouseY / 75) + 1
end

function Match:update()
	if self.turn == "white" then
		if self.mouse:checkPressed() then
			if not self.selected then
				local quadX, quadY = self:getClickedQuad()
				if self.board:hasPiece("white", quadX, quadY) then
					self.selected = true
					self.selectedX, self.selectedY = quadX, quadY
				end
			else
				local quadX, quadY = self:getClickedQuad()
				if self.board:checkMove(self.selectedX, self.selectedY, quadX, quadY) then
					self.board:movePiece(self.selectedX, self.selectedY, quadX, quadY)
					self.turn = "black"
				end
				self.selected = false
			end
		end
	else
		local currentBoard = self.board:getMatrix()
		self.ai:setBoardMatrix(currentBoard)
		local originX, originY, destinationX, destinationY = self.ai:getNextMove()
		print("position:", originX, originY, destinationX, destinationY)
		self.board:movePiece(originX, originY, destinationX, destinationY)
		self.turn = "white"
	end
end

function Match:draw()
	self.boardDrawer:draw()
end

return Match