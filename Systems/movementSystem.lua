MovementSystem = Core.class()

function MovementSystem:init()
	self.system = tiny.processingSystem(self)
end

function MovementSystem:filter(e)
	return e.movement and e.body
end

function MovementSystem:process(e, dt)
	local body = e.body
	if (e.flagLeft) then body:applyForceXY(-e.movement.speed, 0, e.movement.maxSpeed) end
	if (e.flagRight) then body:applyForceXY(e.movement.speed, 0, e.movement.maxSpeed) end
	if (e.flagUp) then body:applyForceXY(0, -e.movement.speed, e.movement.maxSpeed) end
	if (e.flagDown) then body:applyForceXY(0, e.movement.speed, e.movement.maxSpeed) end
end