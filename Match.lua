local Mouse = require("Mouse")
local Board = require("Board")

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
				end
				self.selected = false
			end
		end
	else
		-- ai turn
	end
end

function Match:draw()
	self.board:draw()
end

return Match