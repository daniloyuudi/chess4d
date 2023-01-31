local Match = require("Match")
local Menu = require("Menu")
local ResultScreen = require("ResultScreen")

local GameState = {}

function GameState:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.screen = "menu"
	o.match = Match:new()
	o.menu = Menu:new()
	o.result = ResultScreen:new()
	return o
end

function GameState:update()
	if self.screen == "menu" then
		self.menu:update()
		if self.menu:getBeginGame() then
			self.screen = "match"
		end
	elseif self.screen == "match" then
		self.match:update()
		if self.match:gameEnded() then
			self.screen = "result"
			local winner = self.match:getWinner()
			if winner == "white" then
				self.result:setResult("victory")
			elseif winner == "black" then
				self.result:setResult("defeat")
			end
		end
	elseif self.screen == "result" then
		self.result:update()
		if self.result:restartGame() then
			self.screen = "match"
			self.match = Match:new()
		end
	end
end

function GameState:draw()
	if self.screen == "menu" then
		self.menu:draw()
	elseif self.screen == "match" then
		self.match:draw()
	elseif self.screen == "result" then
		self.result:draw()
	end
end

return GameState