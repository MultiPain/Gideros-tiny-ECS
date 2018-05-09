EBase = Core.class()

function EBase:init()
	self.active = true
	self.needToUpdate = false
end

function EBase:updateInSystem()
	self.needToUpdate = true
end

function EBase:getComponent(name)
	return self[name]
end

function EBase:hasComponent(name)
	return self[name] ~= nil
end