local PieceSprite = require("PieceSprite")
local Images = require("Images")

local KnightSprite = PieceSprite:new()

function KnightSprite:new(color, x, y)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:super(x, y)
	o:loadImage(color)
	return o
end

function KnightSprite:loadImage(color)
	local images = Images:getInstance()
	self.image = images:getKnight(color)
end

return KnightSprite