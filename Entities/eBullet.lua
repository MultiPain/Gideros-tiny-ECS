EBullet = Core.class(EBase)

function EBullet:init(x, y, sprite, layerName)
	self.isBullet = true
	
	-- components
	self.pos = Vec2.new(x, y)
	
	local w, h = sprite:getSize()	
	self.drawable = CDrawable.new(layerName or "bullets")
	self.drawable:add(sprite)
	self.drawable:setAnchorPosition(w / 2, h / 2)
	self.drawable:setPosition(self.pos:unpack())
	
	self.body = CBody.new(w, h)
	self.body:setFriction(0)
	self.body.bounce = 0.8
end

function EBullet:onDelete()
	world:removeEntity(self)
end

function EBullet:onCollsion(col)
	if (col.other.isWall) then
		self:onDelete()
	end
end