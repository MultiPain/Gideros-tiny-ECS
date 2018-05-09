StaticPhysicsBodies = Core.class()

function StaticPhysicsBodies:init(bumpWorld)
	self.system = tiny.system(self)
	self.bumpWorld = bumpWorld
end

function StaticPhysicsBodies:filter(ent)
	return ent.body and ent.pos and ent.body.isStatic and ent.body.active
end

function StaticPhysicsBodies:onAdd(ent)
	local body, drawable, pos = ent.body, ent.drawable, ent.pos
	self.bumpWorld:add(ent, pos.x, pos.y, body.w, body.h)
end

function StaticPhysicsBodies:onRemove(ent)
    self.bumpWorld:remove(ent)
end