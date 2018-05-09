local random=math.random

GameScene = Core.class(Sprite)

function GameScene:init()
	local bump = require "cbump"
	bumpWorld = bump.newWorld(32)
	
	camera = Camera.new(screenW, screenH)
	camera:addLayers("floor", "blood", "main", "bullets", "guns", "debug", "ui")
	camera:zoom(1)
	self:addChild(camera)
	
	DM:setText("Scale", camera.scale)
	
	self.world = tiny.world(
		-- displaying sprites
		DrawableSystem.new(),
		-- adding static bodies to the physics world
		StaticPhysicsBodies.new(bumpWorld),
		-- player controll system
		PlayerControlSystem.new(),
		-- main physics system (where we need all NON STATIC bodies)
		BumpPhysicsSystem.new(bumpWorld),
		-- draw collision rectangles
		DebugDrawSystem.new(),
		-- apply force to body 
		MovementSystem.new(),
		-- reloading and shooting system
		GunSystem.new(),
		-- calls update method of entity
		UpdateSystem.new()
	)
	_G.world = self.world
	
	local pl = EPlayer.new(100, 100)
	self.world:addEntity(pl)
	
	self:createLevel()
	
	self:addEventListener(Event.KEY_UP, self.keyUp, self)
	self:addEventListener(Event.KEY_DOWN, self.keyDown, self)
	self:addEventListener(Event.MOUSE_DOWN, self.mouseDown, self)	
	self:addEventListener(Event.MOUSE_WHEEL, self.mouseWheel, self)
end

function GameScene:createLevel()
	local s = 16
	
	local tex = Texture.new("gfx/floor.png", false, {wrap = Texture.REPEAT})
	local bg = Pixel.new(tex, screenW - s * 2, screenH - s * 2)
	bg:setPosition(s, s)
	bg:setAlpha(0.25)
	camera:add("floor", bg)
	
	local l = EWall.new(0, 0, s, screenH)
	local r = EWall.new(screenW - s, 0, s, screenH)
	local t = EWall.new(0, 0, screenW, s)
	local b = EWall.new(0, screenH - s, screenW, s)
	
	self.world:addEntity(l)
	self.world:addEntity(r)
	self.world:addEntity(t)
	self.world:addEntity(b)
end

function GameScene:keyUp(e)
	if (e.keyCode == KeyCode.S) then
		timeScale = 1
	end
end

function GameScene:keyDown(e)
	if (e.keyCode == KeyCode.Q) then
		local lr = camera:getLayer("debug")
		lr:setVisible(not lr:isVisible())
	end
	if (e.keyCode == KeyCode.S) then
		timeScale = 0.1
	end
end

function GameScene:mouseDown(e)
	local x, y = e.x, e.y
	x, y = camera:toWorld(x, y)
	
	if (e.button == 1) then
		local gun = EGun.new(x, y, choose("pistol", "auto", "falcon", "rpg", "test"))
		self.world:addEntity(gun)
	elseif (e.button == 2) then
		local ammo = EAmmo.new(x, y, math.random(10, 50))
		self.world:addEntity(ammo)
	end
end

function GameScene:mouseWheel(e)
	-- down
	local step = 0.1
	if (e.wheel < 0) then
		camera:zoom(camera.scale - step)
	else
		camera:zoom(camera.scale + step)
	end
	DM:setText("Scale", camera.scale)
end