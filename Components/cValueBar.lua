CValueBar = Core.class(CBase)

function CValueBar:init(maxValue, value)
	self.maxValue = maxValue or 100
	self.value = clamp(value, 0, self.maxValue) or self.maxValue
end

function CValueBar:set(value)
	self.value = clamp(value, 0, self.maxValue)
end

function CValueBar:add(value)
	self:set(self.value + value)
end

function CValueBar:sub(value)
	self:set(self.value - value)
end

function CValueBar:getPercentages()
	return self.value / self.maxValue
end