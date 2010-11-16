require "functions.lua"
require "user.lua"
require "controls.lua"
require "levels.lua"
require "collision.lua"
require "camera.lua"
require "debugger.lua"

boxes = {} -- Contains all the boxes. (Terrain)
cube = {} --Contains Characters, 1 being the main one
frameCount = 1
stickyPositionXY = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

-- global variables
collisionData = {}
direction = 1
collideTime = 0
MAXFPS = 60
--state = "falling"
lastKey = ""
keyCharge = 0

persistingCollisionData = {}
removedCollisionData = {}

animations = {}
sprites = {}
bear = nil

function love.load()
  -- load animations
  animations["bear_idle"]    = Animation:new("bear_idle", 1, 10)
  animations["bear_walking"] = Animation:new("bear_walking", 1, 10)

  sprites["bear"] = Sprite:new(0, 0, {
    idle = animations["bear_idle"],
    walking = animations["bear_walking"]
  })

  -- Fat lines.
  love.graphics.setLineWidth(2)

  -- Create the world.
  world = love.physics.newWorld(2000, 2000)
  world:setGravity(0, 115)
  world:setCallbacks( addedCollision, persistedCollision, removedCollision, nil ) --this is important for state machines

  -- Create ground body.
  ground = love.physics.newBody(world, 0, 0, 0)

  -- add cube
  --addCube(100, 200, 30, 30, "player")
  bear = love.physics.newBody(world, 100, 200, 11, 1)
  bearShape = love.physics.newRectangleShape(bear, 100, 200, sprites["bear"]:getWidth(), sprites["bear"]:getHeight)

  -- make the level
  makelevelOne()

  getCamera():setScreenOrigin(0.5, 0.5)
  setMouseCamera(camera.new())
end

function love.update(dt)
  -- adjust frame rate
  local ms = (1000 / MAXFPS) - (dt * 1000)
  if ms > 0 then
    love.timer.sleep(ms)
  end

  -- apply slide
  applySlide()

  -- Update the world.
  world:update(dt)

  -- key stuff
  getKeyPress()
  -- getKeyRelease()

  userPosition()
  getCamera():setOrigin(userX,  userY) --Camera tracks the player :)

  -- unsticker stuff
  stickyPositionXY[frameCount] = round( userX )
  stickyPositionXY[frameCount+1] = round( userY )

  if stickyPositionXY[1] == stickyPositionXY[3] and stickyPositionXY[3] == stickyPositionXY[5] and stickyPositionXY[5] == stickyPositionXY[7] and stickyPositionXY[7] == stickyPositionXY[9] and
    stickyPositionXY[2] == stickyPositionXY[4] and stickyPositionXY[4] == stickyPositionXY[6] and stickyPositionXY[6] == stickyPositionXY[8] and stickyPositionXY[8] == stickyPositionXY[10] then
    print ("#######################UNSTUCK!############################")
    cube[1].body:applyImpulse(0, -1)
    direction = direction*1
    updateCubeState("push")
  end



  frameCount = frameCount+2
  if frameCount == 11 then 
    frameCount = 1 
  end

  print("framecount: " .. frameCount .. " stickyPositionX: " .. stickyPositionXY[frameCount] .. " stickyPositionY: " .. stickyPositionXY[frameCount+1])
end

function love.draw()
  printStuff()

  -- Draw all the cube.
  --tempShape = cube[1].shape.vertices[1].Set(50, 50)
  for i,data in ipairs(cube) do
    love.graphics.polygon("line", data.shape:getPoints())
  end

  -- Draw all the boxes.
  for i,data in ipairs(boxes) do
    love.graphics.polygon("line", data.shape:getPoints())
  end
end
