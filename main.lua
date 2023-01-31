local Images = require("Images")
local Piece = require("Piece")
local Board = require("Board")
local Match = require("Match")
local GameState = require("GameState")

function love.load()
	love.graphics.setBackgroundColor(0.5, 0.5, 0.5, 1)
	love.window.setMode(600, 600)
	love.window.setTitle("Chess 4D")

	math.randomseed(2)

	-- load all images at once
	local images = Images:getInstance()
	images:loadAll()

	gameState = GameState:new()
end

function love.update()
	gameState:update()
end

function love.draw()
	gameState:draw()
end