Layer = Core.class(Sprite)

function Layer:init(name)
	self.name = name
end
--
function Layer:move(dx, dy)
	local x, y = self:getPosition()
	x += dx
	y += dy
	self:setPosition(x, y)
end
--
function Layer:remove(sprite)
	if (self:contains(sprite)) then self:removeChild(sprite) end
end
--
function Layer:add(sprite)
	self:addChild(sprite)
end
--
function Layer:setX(x)
	Sprite.setX(self, x)
end
--
function Layer:setY(y)
	Sprite.setY(self, y)
end
--
function Layer:setPosition(x, y)
	Sprite.setPosition(self, x, y)
end