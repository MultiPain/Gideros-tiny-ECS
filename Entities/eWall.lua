EWall = Core.class(EBase)

function EWall:init(x, y, w, h, color)
	self.isWall = true
	
	-- components
	self.pos = Vec2.new(x, y)
	
	self.body = CBody.new(w, h)
	self.body.isStatic = true
	
	self.drawable = CDrawable.new("main")
	self.drawable:add(Pixel.new(color or BLACK, 1, w, h))
	self.drawable:setPosition(self.pos:unpack())
end