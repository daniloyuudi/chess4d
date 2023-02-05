local PieceSprite = require("PieceSprite")
local Images = require("Images")

local PawnSprite = PieceSprite:new()

function PawnSprite:new(color, x, y)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:super(x, y)
	o:loadImage(color)
	return o
end

function PawnSprite:loadImage(color)
	local images = Images:getInstance()
	self.image = images:getPawn(color)
end

return PawnSprite