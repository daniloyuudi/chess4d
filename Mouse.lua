local Mouse = {}

function Mouse:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.mouseDownFirst = true
	return o
end

function Mouse:checkPressed()
	if love.mouse.isDown(1) then
		if self.mouseDownFirst then
			self.mouseDownFirst = false
			return true
		end
		return false
	end

	self.mouseDownFirst = true
	return false
end

return Mouse