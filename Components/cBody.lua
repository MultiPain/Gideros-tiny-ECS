CBody = Core.class(CBase)

function CBody:init(w, h)	
	self.w = w
	self.h = h
	
	self.vel = Vec2.new()
	
	self.friction = 0
	self.bounce = 2
	self.offsetX = 0
	self.offsetY = 0
	
	self.active = true
	self.isStatic = false
end

function CBody:getSize() return self.w, self.h end

function CBody:setFriction(value)
	assert(type(value) == 'number', "Friction must be a number")
	self.friction = value
end

function CBody:applyForce(vec, len)
	len = len or 1
	self.vel:add(vec):limit(len)
end

function CBody:applyForceXY(fx, fy, len)
	len = len or 1
	self.vel:addXY(fx, fy):limit(len)
end