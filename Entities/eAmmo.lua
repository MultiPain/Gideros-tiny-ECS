local tex = Texture.new("gfx/items/ammo-pack.png")

EAmmo = Core.class(EBase)

function EAmmo:init(x, y, amount)
	self.isPickup = true
	self.isAmmo = true
	
	self.amount = amount
	-- components
	self.pos = Vec2.new(x, y)
	
	self.body = CBody.new(14, 14)
	self.body:setFriction(0)
	
	local w, h = self.body:getSize()
	self.drawable = CDrawable.new("main")
	self.drawable:add(Bitmap.new(tex))
	self.drawable:setAnchorPosition(w / 2, h / 2)
	self.drawable:setPosition(self.pos:unpack())
	
	local tf = TextField.new(nil, tostring(amount))
	self.drawable:add(tf)
end