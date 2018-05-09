UpdateSystem = Core.class()

function UpdateSystem:init()
	self.system = tiny.processingSystem(self)
	self.system.filter = tiny.requireAll("update")
end

function UpdateSystem:process(ent, dt)
	ent:update(dt)
	
	if (ent.needToUpdate) then
		ent.needToUpdate = false
		self.system.world:addEntity(ent)
	end	
end