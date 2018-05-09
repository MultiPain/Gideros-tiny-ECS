application:setKeepAwake(true)
application:setBackgroundColor(DARK_GRAY)

local timer = 0
function update(e)
	local dt = e.deltaTime
	dt *= timeScale
	timer += dt
	
	if (timer >= 1) then
		timer = 0
		DM:setText("FPS", 1//dt)
	end
	
	if (world) then
		world:update(dt)
	end
end

function appExit(e)	
	local t = os.clock()
	print("Clearing app...")
	world:clearEntities()
	world:clearSystems()
	world:refresh()
	
	stage:removeEventListener(Event.ENTER_FRAME, update)
	stage:removeEventListener(Event.APPLICATION_EXIT, appExit)
	print(string.format("Done in %f s.", os.clock() - t))
end

function Load()
	local t = os.clock()
	
	local dx, dy, w, h = application:getDeviceSafeArea(true)
	
	tiny = require("Libs/tiny-ecs")
	screenW = w + dx
	screenH = h + dy
	timeScale = 1
	require("Scenes/GameScene")
	
	
	-- debug --
	local font = TTFont.new("data/cour.ttf", 22)
	DM = Monitor.new(font)
	DM:add("FPS")
	DM:add("Scale")
	DM:add("Dir")
	DM:add("Ammo")
	DM:add("Left")
	
	Log = Console.new(22, font)
	Log:setAlpha(0.3)
	Log:setX(screenW - 450)
	--
	
	sceneManager = SceneManager.new{
		["Game"] = GameScene
	}
	sceneManager:changeScene("Game")
	stage:addChild(sceneManager)
	
	stage:addEventListener(Event.ENTER_FRAME, update)
	stage:addEventListener(Event.APPLICATION_EXIT, appExit)
	
	--stage:addChild(Log)
	stage:addChild(DM)
	
	print(string.format("Loading time %fs.", os.clock() - t))
end

Core.asyncCall(Load)
--for i = 1, 10 do print(math.random() * (1 << 24) | 0) end