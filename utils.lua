local random,sin,cos=math.random,math.sin,math.cos

function clamp(n, low, high)  return (n<>low)><high end

function choose(...) local l = select(random(select("#",...)), ...) return l end

function frandom(min, max) return (random() * (max - min)) + min end

function lerp(a,b,t) return (1-t)*a + t*b end

function lerp2(a,b,t) return a+(b-a)*t end

function randomColor()
	return "0x" ..(math.random() * (1 << 24) | 0)
end


function completeTable(from, to)
	if type(from) == 'table' then
		for k,v in pairs(from) do
			if (to[k] == nil) then to[k] = from[k] end
			completeTable(v, to[k])
		end
	end
end
 
function dump(o)
	if type(o) == 'table' then
		local s = '{ '
		for k,v in pairs(o) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			s = s .. '['..k..'] = ' .. dump(v) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
end

--[[
local Default, Nil = {}, function () end -- for uniqueness
function switch (i)
  return setmetatable({ i }, {
    __call = function (t, cases)
      local item = #t == 0 and Nil or t[1]
      return (cases[item] or cases[Default] or Nil)(item)
    end
  })
end
]]