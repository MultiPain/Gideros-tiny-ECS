DebugDrawSystem = Core.class()

function DebugDrawSystem:init()
	self.system = tiny.processingSystem(self)
end

function DebugDrawSystem:filter(e)
	return e.body and e.pos and e.body.active
end

function DebugDrawSystem:onAdd(ent)
	local body, drawable, pos = ent.body, ent.drawable, ent.pos
	-- drawing bodies
	if (pos) then
		local w, h = body:getSize()
		local b = Pixel.new(randomColor(), 0.5, w, h)
		local t = {drawable = CDrawable.new("debug")} -- simple entity
		t.drawable:add(b)
		if (drawable) then
			t.drawable:setAnchorPosition(drawable:getAnchorPosition())
		end
		ent.bodyDraw = t
		self.system.world:addEntity(t)
	end
end
function DebugDrawSystem:onRemove(ent)
	if (ent.bodyDraw) then
		self.system.world:remove(ent.bodyDraw)
	end
end

function DebugDrawSystem:process(ent, dt)
	local body = ent.body
	local pos = ent.pos
	ent.bodyDraw.drawable:setPosition(pos.x + body.offsetX, pos.y + body.offsetY)
end