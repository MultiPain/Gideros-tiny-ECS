local tex = Texture.new("gfx/player2.png")
local _world

EPlayer = Core.class(EBase)

function EPlayer:init(x, y)
	if (not _world) then _world = world end
	self.isPlayer = true
	self.locked = false
	self.watchingDir = Vec2.new(1, 0)
	
	-- components
	self.pos = Vec2.new(x, y)
	self.rotation = 0
	
	self.movement = {
		speed = 250,
		maxSpeed = 1600
	}
	
	self.body = CBody.new(22, 22)
	self.body:setFriction(20)
	self.body.offsetX = 8
	self.body.offsetY = 8
	
	local sprite = Bitmap.new(tex)
	local sw, sh = sprite:getSize()
	self.drawable = CDrawable.new("main")
	self.drawable:add(sprite)
	self.drawable:setAnchorPosition(sw / 2, sh / 2)
	self.drawable:setPosition(self.pos:unpack())
	
	self.hasGun = false
end

function EPlayer:lock(flag)
	self.locked = flag
end

function EPlayer:onCollsion(col)
	local ent = col.other
	if (ent.isGun and ent.gun and not self.hasGun and not col.overlap) then
		self.hasGun = true
		self.eGun = ent.gun
		-- mark to add to the gun system
		ent.gun.active = true
		-- mark to remove from the physics system
		ent.body.active = false
		-- set flag to READD entity to the world
		ent:updateInSystem()
		ent:pinTo(self)
	elseif (ent.isPickup and ent.isAmmo and self.hasGun) then
		if (self.eGun:addAmmo(ent.amount)) then
			_world:remove(ent)
		end
	end
end