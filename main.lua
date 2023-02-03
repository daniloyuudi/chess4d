local Images = require("Images")
local Game = require("Game")
local Menu = require("Menu")

function love.load()
	love.graphics.setBackgroundColor(0.5, 0.5, 0.5, 1)
	love.window.setMode(600, 600)
	love.window.setTitle("Chess 4D")

	math.randomseed(2)

	-- load all images at once
	local images = Images:getInstance()
	images:loadAll()

	local menu = Menu:new()
	game = Game:new(menu)
end

function love.update()
	game:update()
end

function love.draw()
	game:draw()
end