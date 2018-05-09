CDrawable = Core.class(Sprite)

function CDrawable:init(layerName)
	self.layerName = layerName
end

function CDrawable:add(sprite)
	self:addChild(sprite)
	return self
end

function CDrawable:remove(sprite)
	self:removeChild(sprite)
	return self
end