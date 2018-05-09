DrawableSystem = Core.class()

function DrawableSystem:init()
	self.system = tiny.system(self)
	self.system.filter = tiny.requireAll("drawable")
end

function DrawableSystem:onAdd(ent)
	local comp = ent.drawable
	camera:add(comp.layerName, comp)
end

function DrawableSystem:onRemove(ent)
	local comp = ent.drawable
	camera:remove(comp.layerName, comp)
end

--[[
function DrawableSystem:preWrap(dt)
	print("preWrap", dt)
end

function DrawableSystem:postWrap(dt)
	print("postWrap", dt)
end

function DrawableSystem:onAddToWorld(w)
	print("onAddToWorld", w)
end

function DrawableSystem:onModify(dt)
	print("onModify", dt)
end
]]