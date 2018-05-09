local acos,sin,cos,sqrt,abs,atan2,random=math.acos,math.sin,math.cos,math.sqrt,math.abs,math.atan2,math.random

Vec2 = Core.class()

function Vec2:init(x, y) self.x = x or 0 self.y = y or 0 end
function Vec2:set(other) self.x = other.x self.y = other.y return self end
function Vec2:setXY(x, y) self.x = x or 0 self.y = y or 0 return self end
function Vec2:copy() return Vec2.new(self.x, self.y) end

function Vec2:add(other) self.x += other.x self.y += other.y return self end
function Vec2:addXY(x, y) self.x += x self.y += y return self end
function Vec2:sub(other) self.x -= other.x self.y -= other.y return self end
function Vec2:subXY(x, y) self.x -= x self.y -= y return self end
function Vec2:div(value) self.x /= value self.y /= value return self end
function Vec2:mult(value) self.x *= value;self.y *= value return self end

function Vec2:multVec(other) self.x *= other.x;self.y *= other.y return self end

function Vec2:rotate(angle) local t, cosa, sina = self.x, cos(angle), sin(angle) self.x =  t * cosa + self.y * sina self.y = -t * sina + self.y * cosa return self end
function Vec2:rotateAround(angle, point) local t,cosa,sina = self.x,cos(angle),sin(angle) self.x = cosa * ( t - point.x ) - sina * ( self.y - point.y ) + point.x self.y = sina * ( t - point.x ) + cosa * ( self.y - point.y ) + point.y return self end
function Vec2:dot(other) return self.x * other.x + self.y * other.y end
function Vec2:distSq(other) local dx = abs(self.x - other.x) local dy = abs(self.y - other.y) return ((dx*dx)+(dy*dy)) end
function Vec2:dist(other) return self:distSq(other)^.5 end
function Vec2:lengthSq() return (self.x*self.x+self.y*self.y) end
function Vec2:length() return self:lengthSq()^.5 end
function Vec2:angle(other) return ^>atan2(other.y - self.y, other.x - self.x) end
function Vec2:angleXY(x, y) return ^>atan2(y - self.y, x - self.x) end
function Vec2:unpack() return self.x, self.y end
function Vec2:getRotation() return atan2(self.y, self.x) end
function Vec2:normolize()
	local l=self:length()
	if l==0 then self.x,self.y = 0,0 else self.x /= l self.y /= l end
	return self 
end
function Vec2:limit(max)
	local lSq = self:lengthSq()
	if (lSq > max * max) then
		self:div(lSq^.5)
		self:mult(max)
	end
	return self 
end
function Vec2:setLength(len)
	self:normolize()
	self:mult(len)
	return self 
end
function Vec2:fromAngle(angle, length)
	angle = ^<angle
	length = length or 1
	self.x = cos(angle) * length
	self.y = sin(angle) * length
	return self 
end

function Vec2:random(maxLen)
	maxLen = maxLen or 100
	self.x = random(maxLen)
	self.y = random(maxLen)
	return self 
end
function Vec2:toString() return string.format("[%.2f, %.2f]", self.x, self.y) end