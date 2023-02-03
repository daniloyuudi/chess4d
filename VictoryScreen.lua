local ResultScreen = require("ResultScreen")

local VictoryScreen = ResultScreen:new()

function VictoryScreen:draw()
	love.graphics.setBackgroundColor(0, 0, 0, 1)
	love.graphics.print("You won", 200, 200)
end

return VictoryScreen