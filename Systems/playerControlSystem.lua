local floor=math.floor

PlayerControlSystem = Core.class()

function PlayerControlSystem:init()
	self.system = tiny.processingSystem(self)
	self.system.filter = tiny.requireAll("isPlayer")
end

function PlayerControlSystem:onAdd(ent)
	self.player = ent
	stage:addEventListener(Event.KEY_UP, self.keyUp, self)
	stage:addEventListener(Event.KEY_DOWN, self.keyDown, self)
end

function PlayerControlSystem:process(ent, dt)
	
	-- cam movement
	--camera:setPosition(self.player.pos:unpack()) -- old
	local x, y = camera:getPosition()
	local sx, sy = self.player.pos:unpack()
	x = lerp(x, sx, 0.07)
	y = lerp(y, sy, 0.07)
	camera:setPosition(x, y)
	
	-- update ui
	if (self.player.hasGun) then
		DM:setText("Ammo", self.player.eGun.ammo)
		DM:setText("Left", self.player.eGun.total)
	end
	
	-- rotation logic
	if (not self.player.locked and self.player.rotation) then
		local left = self.player.flagLeft
		local right = self.player.flagRight
		local up = self.player.flagUp
		local down = self.player.flagDown
		
		if (left or right) then
			local x = right and 1 or -1
			self.player.rotation = (x * 90 - 90)
			self.player.watchingDir:setXY(x, 0)
		end
		
		if (up or down) then
			local y = down and 1 or -1
			self.player.rotation = y * 90
			self.player.watchingDir:setXY(0, y)
		end
		
		if (left and (up or down)) then 
			local y = up and -1 or 1
			self.player.rotation = (180 - 45  * y)
			self.player.watchingDir:setXY(-1, y)
		end
		
		if (right and (up or down)) then 
			local y = up and -1 or 1
			self.player.rotation = (45 * y)
			self.player.watchingDir:setXY(1, y)
		end
		
		local d = self.player.drawable
		if (d) then d:setRotation(self.player.rotation) end
	end
	DM:setText("Dir", self.player.watchingDir)
end

function PlayerControlSystem:keyUp(e)
	-- shoot
	if (e.keyCode == KeyCode.Z and self.player.hasGun) then
		self.player.eGun:shoot(false)
	end
	
	-- lock
	if (e.keyCode == KeyCode.X and self.player.hasGun) then
		self.player:lock(false)
	end
	
	-- move
	if (e.keyCode == KeyCode.LEFT) then
		self.player.flagLeft = false
	end
	if (e.keyCode == KeyCode.RIGHT) then
		self.player.flagRight = false
	end
	if (e.keyCode == KeyCode.UP) then
		self.player.flagUp = false
	end
	if (e.keyCode == KeyCode.DOWN) then
		self.player.flagDown = false
	end
end

function PlayerControlSystem:keyDown(e)
	-- throw gun
	if (e.keyCode == KeyCode.D and self.player.hasGun) then
		self.player.eGun.owner:throw()
		self.player.hasGun = false
		self.player.eGun = nil
		self.player:lock(false)
	end
	
	-- lock
	if (e.keyCode == KeyCode.X and self.player.hasGun) then
		self.player:lock(true)
	end	
	
	-- reload
	if (e.keyCode == KeyCode.R and self.player.hasGun) then
		self.player.eGun:reload()
	end
	
	-- shoot
	if (e.keyCode == KeyCode.Z and self.player.hasGun) then
		self.player.eGun:shoot(true)
	end
	
	-- move
	if (e.keyCode == KeyCode.LEFT) then
		self.player.flagLeft = true
	end
	if (e.keyCode == KeyCode.RIGHT) then
		self.player.flagRight = true
	end
	if (e.keyCode == KeyCode.UP) then
		self.player.flagUp = true
	end
	if (e.keyCode == KeyCode.DOWN) then
		self.player.flagDown = true
	end
end
