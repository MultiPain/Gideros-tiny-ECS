local max=math.max

CGun = Core.class(CBase)

-- ammo - amount of bullets in magazine
-- total - total amount of bullets
-- maxTotal - maximum amount of bullets
function CGun:init(ammo, total, maxTotal, fireRate, reloadTime, projectileSpeed, damage)
	self.isGun = true
	self.active = false
	
	self.ammo = ammo
	self.magazine = ammo
	self.total = total
	self.maxTotal = maxTotal or -1
	if (self.maxTotal > 0) then
		self.total = clamp(self.total, 0, self.maxTotal)
	end
	
	self.fireRate = fireRate
	self.reloadTime = reloadTime
	self.damage = damage
	self.projectileSpeed = projectileSpeed
	
	self.reloading = false
	self.canShoot = false
	self.shooting = false
	self.timer = 0
end

function CGun:shoot(flag) 
	self.shooting = flag
end

function CGun:addAmmo(amount)
	assert(type(amount) == 'number', "Ammo must be a number")
	if (self.maxTotal == -1) then
		self.total += amount
		return true
	end
	
	if (self.total < self.maxTotal) then
		self.total += amount
		self.total = clamp(self.total, 0, self.maxTotal)
		return true
	end
	return false
end

function CGun:reload()
	self.reloading = true
end