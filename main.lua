require "animation.lua"
require "sprite.lua"

-- global variables
animations = {}
sprites = {}
bear = nil
speed = 100

direction = nil

MAXFPS = 60

function love.load()
  -- load animations
  animations["bear_idle"]    = Animation:new("images/bear_idle.png", 64, {0.5, 0.5, 0.5, 0.5})
  animations["bear_walking"] = Animation:new("images/bear_walk.png", 64, {0.166, 0.333, 0.166, 0.333})
  animations["bear_walking_left"] = Animation:new("images/bear_walk_left.png", 64, {0.166, 0.333, 0.166, 0.333})

  sprites["bear"] = Sprite:new(0, 0, {
    idle = animations["bear_idle"],
    walking = animations["bear_walking"],
    walking_left = animations["bear_walking_left"]
  })

  sprites["bear"]:setAnimation("walking")

  -- Create the world.
  world = love.physics.newWorld(2000, 2000)
  world:setGravity(0, 115)
  world:setCallbacks( addedCollision, persistedCollision, removedCollision, nil ) --this is important for state machines

  -- Create ground body.
  ground = love.physics.newBody(world, 0, 0, 0)

  -- create the bear
  bear = love.physics.newBody(world, 100, 200, 11, 1)
  bearShape = love.physics.newRectangleShape(bear, 100, 200, sprites["bear"]:getWidth(), sprites["bear"]:getHeight())
end

function love.update(dt)
  -- adjust frame rate
  local ms = (1000 / MAXFPS) - (dt * 1000)
  if ms > 0 then
    love.timer.sleep(ms)
  end

  -- Update the world.
  world:update(dt)

  bear = sprites["bear"]

  if direction == "up" then
    bear:setAnimation("idle")
    bear:move(0, -dt * speed)
  elseif direction == "down" then
    bear:setAnimation("idle")
    bear:move(0, dt * speed)
  elseif direction == "left" then
    bear:setAnimation("walking_left")
    bear:move(-dt * speed, 0)
  elseif direction == "right" then
    bear:setAnimation("walking")
    bear:move(dt * speed, 0)
  end

  -- Update the sprites
  bear:update()
end

function love.draw()
  sprites["bear"]:draw()
end

function love.keypressed(key)
  if key == "up" then
    direction = "up"
  elseif key == "down" then
    direction = "down"
  elseif key == "left" then
    direction = "left"
  elseif key == "right" then
    direction = "right"
  end
end

function love.keyreleased(key)
  -- just make any of them clear direction for now
  if key == direction then
    direction = nil
    sprites["bear"]:setAnimation("idle")
  end
end
