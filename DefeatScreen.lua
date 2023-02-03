local ResultScreen = require("ResultScreen")

local DefeatScreen = ResultScreen:new()

function DefeatScreen:draw()
	love.graphics.setBackgroundColor(0, 0, 0, 1)
	love.graphics.print("You lost", 200, 200)
end

return DefeatScreen