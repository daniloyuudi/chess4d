local Images = require("Images")
local Piece = require("Piece")
local Board = require("Board")
local Match = require("Match")

function love.load()
	love.graphics.setBackgroundColor(0.5, 0.5, 0.5, 1)
	love.window.setMode(600, 600)

	match = Match:new()
end

function love.update()
	match:update()
end

function love.draw()
	match:draw()
end