local PieceSprite = require("PieceSprite")
local Images = require("Images")

local BishopSprite = PieceSprite:new()

function BishopSprite:new(color, x, y)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:super(x, y)
	o:loadImage(color)
	return o
end

function BishopSprite:loadImage(color)
	local images = Images:getInstance()
	self.image = images:getBishop(color)
end

return BishopSprite