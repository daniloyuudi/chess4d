local EventManager = {}

function EventManager:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.listeners = {}
	return o
end

function EventManager:subscribe(event, observer)
	local pointer = self.listeners[event]
	if pointer ~= nil then
		while pointer:getNext() ~= nil do
			pointer = pointer:getNext()
		end
		pointer:setNext(observer)
	else
		self.listeners[event] = observer
	end
end

function EventManager:unsubscribe(event, observer)
	local pointer = self.listeners[event]
	if pointer ~= observer then
		while pointer:getNext() ~= observer do
			pointer = pointer:getNext()
		end
		local next = pointer:getNext():getNext()
		pointer:setNext(next)
	else
		self.listeners[event] = nil
	end
end

function EventManager:dispatch(event, data)
	local pointer = self.listeners[event]
	while pointer ~= nil do
		pointer:update(data)
		pointer = pointer:getNext()
	end
end

return EventManager