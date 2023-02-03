local Mouse = require("Mouse")
local Board = require("Board")
local BoardDrawer = require("BoardDrawer")
local AI = require("AI")
local ResultScreen

local Match = {}

function Match:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.turn = "white"
	o.movingPiece = false
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

function Match:moveSprite()
	if self.currentSprite:getState() == "still" then
		self.movingPiece = false
	end
	self.currentSprite:move()
end

function Match:update()
	ResultScreen = ResultScreen or require("ResultScreen")
	-- debug
	if love.keyboard.isDown("z") then
		local resultScreen = ResultScreen:new()
		resultScreen:setResult('victory')
		self.context:changeScreen(resultScreen)
	end
	if love.keyboard.isDown("x") then
		local resultScreen = ResultScreen:new()
		resultScreen:setResult('defeat')
		self.context:changeScreen(resultScreen)
	end
	
	if self.turn == "white" then
		if self.movingPiece then
			self:moveSprite()
		else
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
						if self.board:gameEnded() then
							local resultScreen = ResultScreen:new()
							resultScreen:setResult('victory')
							self.context:changeScreen(resultScreen)
						end
						self.turn = "black"
						self.currentSprite = self.board:getPieceSprite(self.selectedX, self.selectedY)
						self.movingPiece = true
					end
					self.selected = false
				end
			end
		end
	else
		if self.movingPiece then
			self:moveSprite()
		else
			local currentBoard = self.board:getMatrix()
			self.ai:setBoardMatrix(currentBoard)
			local originX, originY, destinationX, destinationY = self.ai:getNextMove()
			self.board:movePiece(originX, originY, destinationX, destinationY)
			if self.board:gameEnded() then
				local resultScreen = ResultScreen:new()
				resultScreen:setResult('defeat')
				self.context:changeScreen(resultScreen)
			end
			self.turn = "white"
			self.currentSprite = self.board:getPieceSprite(originX, originY)
			self.movingPiece = true
		end
	end
end

function Match:setContext(context)
	self.context = context
end

function Match:draw()
	self.boardDrawer:draw()
end

return Match