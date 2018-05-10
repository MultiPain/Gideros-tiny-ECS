Camera = Core.class(Sprite)

-- params is set of names
--
-- NOTE: camera's postion in centered
function Camera:init(width, height, ...)
	self.x = 0
	self.y = 0
	self.scale = 1
	self.width = width
	self.height = height
	
	self.hw = self.width / 2
	self.hh = self.height / 2
	
	self.shaking = false
	self.haveBounds = false
	self.bounds = {}
	self.layers = {}
	self.layersNames = {}
	
	self:addLayers(...)
	
	-- SHAKER
	self.shakeData = {
		time = 0,
		amount = 1,
		growth = 5,
		amplitude = 10,
		frequency = 100
	}
	
	self:setPosition(self.hw, self.hh)
end
-- CAMERA +
function Camera:zoom(factor)
	self.scale = factor or 1
	self:setScale(factor, factor)
	--self:setPosition(self.x, self.y)
end
-- add layer on top
function Camera:addLayer(name)
	local lr = Layer.new(name)
	local i = #self.layers+1
	self.layers[i] = lr
	self.layersNames[name] = i 
	self:addChild(lr)
end
-- add multiple layers on top
function Camera:addLayers(...)
	local t = {...}
	for i = 1, #t do
		self:addLayer(t[i])
	end
end
-- t is set of Layers
function Camera:loadLayers(t)
	self:clearLayers()
	
	for i = 1, #t do
		local layer = t[i]
		self.layers[i] = layer
		self.layersNames[layer.name] = i
		self:addChild(layer)
	end
end
-- used only for shake update
function Camera:update(dt)
	if (self.shaking) then
		self.shakeData.amount = 1 <> self.shakeData.amount ^ 0.9
		local t = self.shakeData.time
		t += dt
		
		local shakeFactor = self.shakeData.amplitude * math.log(self.shakeData.amount)
		local waveX = math.sin(t * self.shakeData.frequency)
		local waveY = math.cos(t * self.shakeData.frequency)
		self.shakeData.time = t
		self:move(shakeFactor * waveX, shakeFactor * waveY)
		self.shaking = not(self.shakeData.amount <= 1.001)
	end
end
--
function Camera:shake() 
	self.shaking = true
	self.shakeData.amount += self.shakeData.growth
end
--
function Camera:resetShake() 
	self.shaking = false
	self.shakeData.amount = 1
	self.shakeData.time = 0
end
--
function Camera:setShake(growth, amplitude, frequency)
	self.shakeData.growth = growth
	self.shakeData.amplitude = amplitude or 10
	self.shakeData.frequency = frequency or 100
end
--
function Camera:move(dx, dy) self:setPosition(self.x + dx, self.y + dy) end

function Camera:focus(sprite) self:setPosition(sprite:getPosition()) end

function Camera:toWorld(x, y)
	x = (x + (self.x * self.scale - self.hw)) / self.scale
	y = (y + (self.y * self.scale - self.hh)) / self.scale	
	return x, y
end
-- TODO
function Camera:toScreen(x,y)
	return x, y
end
--
function Camera:setX(x) 
	local sx = x * self.scale
	sx = self.haveBounds and clamp(sx, self.bounds.x, self.bounds.x + self.bounds.w) or x
	self.x = x
	Sprite.setX(self, self.hw - sx)
end
--
function Camera:setY(y) 
	local sy = y * self.scale
	sy = self.haveBounds and clamp(sy, self.bounds.y, self.bounds.y + self.bounds.h) or y
	self.y = y
	Sprite.setY(self, self.hh - sy)
end
-- set camera CENTER

function Camera:setPosition(x, y) 
	local sx = x * self.scale
	local sy = y * self.scale
	if (self.haveBounds) then 
		sx = clamp(sx, self.bounds.x, self.bounds.x + self.bounds.w ) 
		sy = clamp(sy, self.bounds.y, self.bounds.y + self.bounds.h ) 
	end
	self.x = x
	self.y = y
	
	Sprite.setPosition(self, self.hw - sx, self.hh - sy)
end
--
function Camera:getPosition() return self.x, self.y end

function Camera:getX() return self.x end

function Camera:getY() return self.y end

function Camera:setBounds(x, y, width, height) 
	x *= self.scale
	y *= self.scale
	self.haveBounds = true
	self.bounds.x = x + self.hw
	self.bounds.y = y + self.hh
	self.bounds.w = width / self.scale
	self.bounds.h = height / self.scale
end
-- CAMERA - 

-- LAYERS +
function Camera:clearLayers()
	local l = #self.layers
	for i = l,1,-1 do
		local lr = table.remove(self.layers, i)
		self:removeChild(lr)
		self.layersNames[lr.name] = nil
	end
end
--
function Camera:add(name, sprite) self:getLayer(name):add(sprite) end

function Camera:remove(name, sprite) self:getLayer(name):remove(sprite) end

function Camera:setLayerParalax(name, paralax) self:getLayer(name):setParalax(paralax) end
	
function Camera:moveLayer(name, dx, dy) self:getLayer(name):move(dx, dy) end

function Camera:setLayerVisible(name, flag) self:getLayer(name):setVisible(flag) end

function Camera:getLayerParalax(name) return self:getLayer(name).paralax end

function Camera:getLayer(name) return self.layers[self.layersNames[name]] end
-- LAYERS -
