local PieceSprite = require("PieceSprite")
local Images = require("Images")

local KingSprite = PieceSprite:new()

function KingSprite:new(color, x, y)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:super(x, y)
	o:loadImage(color)
	return o
end

function KingSprite:loadImage(color)
	local images = Images:getInstance()
	self.image = images:getKing(color)
end

return KingSprite