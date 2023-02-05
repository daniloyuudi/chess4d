local PieceSprite = require("PieceSprite")
local Images = require("Images")

local QueenSprite = PieceSprite:new()

function QueenSprite:new(color, x, y)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:super(x, y)
	o:loadImage(color)
	return o
end

function QueenSprite:loadImage(color)
	local images = Images:getInstance()
	self.image = images:getQueen(color)
end

return QueenSprite