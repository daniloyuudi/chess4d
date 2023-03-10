local Mouse = require("Mouse")
local Board = require("Board")
local BoardDrawer = require("BoardDrawer")
local AI = require("AI")
local VictoryScreen
local DefeatScreen

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
	o.gameEnded = false
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
	VictoryScreen = VictoryScreen or require("VictoryScreen")
	DefeatScreen = DefeatScreen or require("DefeatScreen")
	-- debug
	if love.keyboard.isDown("z") then
		local victoryScreen = VictoryScreen:new()
		self.context:changeScreen(victoryScreen)
	end
	if love.keyboard.isDown("x") then
		local defeatScreen = DefeatScreen:new()
		self.context:changeScreen(defeatScreen)
	end

	if self.turn == "white" then
		if self.movingPiece then
			self:moveSprite()
		else
			if self.gameEnded then
				local defeatScreen = DefeatScreen:new()
				self.context:changeScreen(defeatScreen)
			end
			if self.mouse:checkPressed() then
				if not self.selected then
					local quadX, quadY = self:getClickedQuad()
					if self.board:hasPiece("white", quadX, quadY) then
						self.selected = true
						self.selectedX, self.selectedY = quadX, quadY
						self.boardDrawer:setSelectedQuad(quadX, quadY)
					end
				else
					local quadX, quadY = self:getClickedQuad()
					if self.board:checkMove(self.selectedX, self.selectedY, quadX, quadY) then
						if self.board:hasPiece("black", quadX, quadY) then
							self.boardDrawer:removeSprite(quadX, quadY)
						end
						self.board:movePiece(self.selectedX, self.selectedY, quadX, quadY)
						if self.board:gameEnded() then
							self.gameEnded = true
						end
						self.turn = "black"
						self.currentSprite = self.boardDrawer:getSprite(self.selectedX, self.selectedY)
						self.currentSprite:setDestination(quadX, quadY)
						self.movingPiece = true
					end
					self.selected = false
					self.boardDrawer:setSelectedQuad(nil, nil)
				end
			end
		end
	else
		if self.movingPiece then
			self:moveSprite()
		else
			if self.gameEnded then
				local victoryScreen = VictoryScreen:new()
				self.context:changeScreen(victoryScreen)
			end
			local currentBoard = self.board:getMatrix()
			self.ai:setBoardMatrix(currentBoard)
			local originX, originY, destinationX, destinationY = self.ai:getNextMoveMiniMax()
			if self.board:hasPiece("white", destinationX, destinationY) then
				self.boardDrawer:removeSprite(destinationX, destinationY)
			end
			self.board:movePiece(originX, originY, destinationX, destinationY)
			if self.board:gameEnded() then
				self.gameEnded = true
			end
			self.turn = "white"
			self.currentSprite = self.boardDrawer:getSprite(originX, originY)
			self.currentSprite:setDestination(destinationX, destinationY)
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