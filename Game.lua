local Match = require("Match")
local Menu = require("Menu")
local ResultScreen = require("ResultScreen")

local Game = {}

function Game:new(initialScreen)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:changeScreen(initialScreen)
	return o
end

function Game:update()
	self.screen:update()
end

function Game:draw()
	self.screen:draw()
end

function Game:changeScreen(screen)
	self.screen = screen
	self.screen:setContext(self)
end

return Game