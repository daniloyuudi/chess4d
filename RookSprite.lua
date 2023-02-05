local PieceSprite = require("PieceSprite")
local Images = require("Images")

local RookSprite = PieceSprite:new()

function RookSprite:new(color, x, y)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:super(x, y)
	o:loadImage(color)
	return o
end

function RookSprite:loadImage(color)
	local images = Images:getInstance()
	self.image = images:getRook(color)
end

return RookSprite