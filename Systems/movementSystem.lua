MovementSystem = Core.class()

function MovementSystem:init()
	self.system = tiny.processingSystem(self)
end

function MovementSystem:filter(e)
	return e.movement and e.body
end

function MovementSystem:process(e, dt)
	local body = e.body
	local speed = e.movement.speed
	
	if (e.flagLeft) then 
		body:applyForceXY(-speed, 0)		
	end
	
	if (e.flagRight) then 
		body:applyForceXY(speed, 0)
	end
	
	if (e.flagUp) then 
		body:applyForceXY(0, -speed)
	end
	
	if (e.flagDown) then
		body:applyForceXY(0, speed)
	end
	
	-- limit movement vector
	body.vel:limit(e.movement.maxSpeed)
end
