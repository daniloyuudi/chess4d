local Images = require("Images")

function love.load()
	love.graphics.setBackgroundColor(0.5, 0.5, 0.5, 1)
	love.window.setMode(600, 600)

	images = Images:new()
	king = images:getKing("white")
	bishop = images:getBishop("black")
end

function love.draw()
	love.graphics.draw(king, 75, 75)
	love.graphics.draw(bishop, 75*3, 75*4)
end