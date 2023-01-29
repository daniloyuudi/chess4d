local Images = require("Images")
local Piece = require("Piece")
local Board = require("Board")

function love.load()
	love.graphics.setBackgroundColor(0.5, 0.5, 0.5, 1)
	love.window.setMode(600, 600)

	board = Board:new()
	king = Piece:new("white", "king")
	bishop = Piece:new("black", "bishop")
end

function love.draw()
	board:draw()
	king:draw(75, 75)
	bishop:draw(75*4, 75*1)
end