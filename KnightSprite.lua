local PieceSprite = require("PieceSprite")
local Images = require("Images")

local KnightSprite = PieceSprite:new()

function KnightSprite:new(color, x, y)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.x, o.y = (x-1)*75, (y-1)*75
	o.originX, o.originY = 0, 0
	o.destinationX, o.destinationY = 0, 0
	o.state = "still" -- to add a transition state
	o.animationStep = 0
	o:loadImage(color)
	return o
end

function KnightSprite:loadImage(color)
	local images = Images:getInstance()
	self.image = images:getKnight(color)
end

return KnightSprite