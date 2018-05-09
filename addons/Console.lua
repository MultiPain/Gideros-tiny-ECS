Console = Core.class(Sprite)

local function update(self)
	for i = self.h, 2, -1 do 
		local lc = self.lines[i]
		local lp = self.lines[i-1]
		
		lc:setText(lp:getText())
	end
end

function Console:init(height, font)
	self.lines = {}
	self.w = width
	self.h = height
	self.color = WHITE
	self.gap = 4
	
	local mx = 0
	for i = 1, self.h do
		local tf = TextField.new(font, "q| ololol |p")
		local h = tf:getHeight()
		mx = math.max(mx, h)
		tf:setText("")
		tf:setTextColor(self.color)
		tf:setY((i-1) * (h + self.gap))
		self.lines[i] = tf
		self:addChild(tf)
	end
	self:setAnchorPosition(0, -mx)
end

function Console:print(...)
	local line = self.lines[1]
	update(self)
	line:setTextColor(color or self.color)
	local t = {...}
	local str = ""
	for i = 1, #t do
		str = str .. " " .. tostring(t[i])
	end
	line:setText(str)
end

function Console:setColor(color)
	self.color = color
end