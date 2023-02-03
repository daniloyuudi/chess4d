local Images = require("Images")

local PieceSprite = {
	ANIMATION_STEPS = 12
}

function PieceSprite:new(image, x, y)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.image = image
	o.x, o.y = (x-1)*75, (y-1)*75
	o.originX, o.originY = 0, 0
	o.destinationX, o.destinationY = 0, 0
	o.state = "still" -- to add a transition state
	o.animationStep = 0
	o:loadSprite()
	return o
end

function PieceSprite:setNext(pieceSprite)
	self.next = pieceSprite
end

function PieceSprite:getNext()
	return self.next
end

function PieceSprite:getX()
	return self.x
end

function PieceSprite:getY()
	return self.y
end

function PieceSprite:setDestination(x, y)
	self.originX, self.originY = self.x, self.y
	self.destinationX, self.destinationY = x, y
	self.state = "moving"
	self.animationStep = 0
end

function PieceSprite:getAngle(x1, y1, x2, y2)
	local deltaX = x1 - x2
	local deltaY = y1 - y2
	return math.atan2(deltaY, deltaX)
end

function PieceSprite:getDistance(x1, y1, x2, y2)
	return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end

function PieceSprite:move()
	if self.animationStep == (self.ANIMATION_STEPS-1) then
		self.state = "still"
		self.x = self.destinationX
		self.y = self.destinationY
		return
	end
	local angle = self:getAngle(self.destinationX, self.destinationY, self.originX, self.originY)
	local distance = self:getDistance(self.originX, self.originY,
		self.destinationX, self.destinationY)
	local stepDistance = distance/self.ANIMATION_STEPS
	self.x = self.x + math.cos(angle) * stepDistance
	self.y = self.y + math.sin(angle) * stepDistance
	self.animationStep = self.animationStep + 1
end

function PieceSprite:getState()
	return self.state
end

function PieceSprite:draw()
	love.graphics.draw(self.image, self.x, self.y)
end

return PieceSprite