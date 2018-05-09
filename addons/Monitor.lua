local insert,remove=table.insert,table.remove

Monitor = Core.class(Sprite)

local function update(self)
	for i = 1, #self.ind do
		local tf = self.props[self.ind[i]]
		local tmp = tf:getText()
		tf:setText("q|")
		local h = tf:getHeight()
		tf:setText(tmp)
		tf:setY((i-1) * (self.gap + h))
	end
end

function Monitor:init(font)
	self.props = {}
	self.font = font
	self.gap = 4
	self.color = WHITE
	
	self.ind = {}
end

function Monitor:add(name, text, color)
	local mx = 0
	if (self.props[name] == nil) then
		local len = #self.ind
		local tf = TextField.new(self.font, "q|")
		local h = tf:getHeight()
		mx = math.max(mx, h)
		--tf:setText(text or "")
		tf:setTextColor(self.color)
		tf:setText(string.format("%s: %s", name, tostring(text or "")))
		tf:setY(len + len * (h + self.gap))
		self.ind[len + 1] = name
		self.props[name] = tf
		self:addChild(tf)
	end
	
	self:setAnchorPosition(0, -mx)
end

function Monitor:remove(name)
	for i = #self.ind, 1, -1 do 
		if (self.ind[i] == name) then remove(self.ind, i) break end
	end
	
	update(self)
	
	self:removeChild(self.props[name])
	self.props[name] = nil
end

function Monitor:setText(name, text, color)
	local tf = self.props[name]
	assert(tf ~= nil, "No filed '"..name.."'")
	tf:setText(string.format("%s: %s", name, tostring(text)))
	tf:setTextColor(self.color)
end

function Console:setColor(color)
	self.color = color
end