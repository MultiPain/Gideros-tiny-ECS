local assets = require "data/gunsPresets"
local cos,sin=math.cos,math.sin

EGun = Core.class(EBase)

function EGun:init(x, y, name, owner)
	self.isGun = true
	local asset = assets[name]
	
	self.pin = owner
	self.dist = asset.dist
	
	self.projectile = asset.projectile
	
	-- components
	self.pos = Vec2.new(x, y)
	
	local spr = asset.gfx()
	local sw, sh = spr:getSize()
	local w = asset.bodyW or sw or 16
	local h = asset.bodyH or sh or 16
	
	self.drawable = CDrawable.new("main")
	self.drawable:add(spr)
	self.drawable:setAnchorPosition(sw / 2, sh / 2)
	self.drawable:setPosition(self.pos:unpack())
	self.drawable.owner = self
	
	self.body = CBody.new(w, h)
	self.body.owner = self
	self.body.offsetX = asset.bodyOffsetX or 0
	self.body.offsetY = asset.bodyOffsetY or 0
	
	self.gun = CGun.new(asset.ammo, asset.total, asset.maxTotal, asset.fireRate, asset.reloadTime, asset.projectileSpeed, asset.damage)
	self.gun.name = name
	self.gun.owner = self
end

function EGun:pinTo(entity)
	self.pin = entity
end

function EGun:update(dt)
	if (self.pin) then
		local pos = self.pin.pos
		local r = 0
		if (self.pin.rotation) then
			r = self.pin.rotation
			local rad = ^<r
			self.pos:setXY(pos.x + self.dist * cos(rad), pos.y + self.dist * sin(rad))
		else
			self.pos:setXY(self.pin.pos.x + self.dist, self.pin.pos.y)
		end
		if (self.drawable) then
			self.drawable:setPosition(self.pos.x, self.pos.y)
			self.drawable:setRotation(r)
		end
	end
end

function EGun:onShoot()
	local force = self.gun.projectileSpeed
	local b = EBullet.new(self.pos.x, self.pos.y, self.projectile())
	
	if (b.drawable and self.drawable) then b.drawable:setRotation(self.drawable:getRotation()) end
	
	b.damage = self.gun.damage
	if (self.pin and self.pin.body) then
		local dir = self.pin.watchingDir:copy()
		b.body:applyForce(dir:mult(force), force)
	else
		b.body:applyForceXY(force, 0, force)
	end
	world:addEntity(b)
end

function EGun:throw()
	
	-- mark to remove from gun system
	self.gun.active = false
	self.gun.shooting = false
	self.gun.reloading = false
	self.gun.timer = 0
	
	-- mark to add to physics system
	self.body.active = true
	if (self.pin and self.pin.body) then
		local vel = self.pin.watchingDir:copy()
										:mult(800)
		self.body.vel:set(vel)
	end
	self.body:setFriction(6)
	
	self:pinTo(nil)
	-- set flag to READD entity to the world
	self:updateInSystem()
end