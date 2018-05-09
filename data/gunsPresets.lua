local wdst = 25
local textures = {projectiles = {}, guns = {}}

-- load projectiles
for i = 1, 12 do 
	textures.projectiles[i] = Texture.new("gfx/gun_projectiles/"..i..".png")
end

-- load guns
for i = 1, 11 do 
	textures.guns[i] = Texture.new("gfx/guns/"..i..".png")
end

local function getAsset(type, name)
	return Bitmap.new(textures[type][name])
end

return {
	["pistol"] = {
		gfx = function() return getAsset("guns", 7) end, 
		projectile = function() return getAsset("projectiles", 8) end,
		bodyW = 18, bodyH = 10, -- size of the body (default: size of gfx)
		bodyOffsetX = 2, bodyOffsetY = 0, -- displacement of the body relative to the entity (default: [0, 0])
		projectileSpeed = 700, -- how fast the projectile is moving
		ammo = 12, -- the current amount of bullets in magazine
		total = 60, -- the remaining number of bullets
		maxTotal = 120, -- maximum amount of bullets that the gun can store (default: -1 (infinite))
		fireRate = 0.2, -- in seconds
		reloadTime = 1, -- in seconds
		damage = 5, -- damage ("transferred" to the bullet)
		dist = wdst -- how far away is the weapon from it's owner
	},
	["auto"] = {
		gfx = function() return getAsset("guns", 1) end, 
		projectile = function() return getAsset("projectiles", 1) end,
		projectileSpeed = 800, ammo = 30, total = 70, fireRate = 0.1, reloadTime = 1.5, damage = 5,
		dist = wdst
	},
	["falcon"] = {
		gfx = function() return getAsset("guns", 8) end, 
		projectile = function() return getAsset("projectiles", 8) end,
		projectileSpeed = 1000, ammo = 60, total = 27000, fireRate = 0.05, reloadTime = 1, damage = 2.5,
		dist = wdst
	},
	["rpg"] = {
		gfx = function() return getAsset("guns", 4) end, 
		projectile = function() return getAsset("projectiles", 4) end,
		projectileSpeed = 500, ammo = 1, total = 6, fireRate = 1.2, reloadTime = 2, damage = 25,
		dist = wdst
	},
	["test"] = {
		gfx = function() return getAsset("guns", 2) end, 
		projectile = function() return getAsset("projectiles", 2) end,
		projectileSpeed = 1000, ammo = 10000, total = 1000, maxTotal = 1010, fireRate = 0.15, reloadTime = 10, damage = 25,
		dist = wdst
	},
}