Sprite = {}
Sprite_mt = { __index = Sprite }

function Sprite:new(x, y, animations)
  local hash = {}

  hash.x          = x
  hash.y          = y
  hash.animations = animations

  hash.current_anim = hash.animations.idle
  hash.current_anim_name = "idle"

  hash.current_frame = 0
  hash.last_update = 0

  hash.quad = hash.current_anim:createQuad()

  return setmetatable(hash, Sprite_mt)
end

function Sprite:setAnimation(which)
  if which ~= self.current_anim_name then
    self.current_anim_name = which
    self.current_anim = self.animations[which]
    self.current_frame = 0
    self.current_anim:updateQuad(self.quad, self.current_frame)
  end
end

function Sprite:update()
  time = love.timer.getMicroTime()

  if time > self.last_update + self.current_anim:getTiming(self.current_frame) then
    self.current_frame = (self.current_frame + 1) % self.current_anim.num_frames
    self.quad = self.current_anim:updateQuad(self.quad, self.current_frame)
    self.last_update = time
  end
end

function Sprite:getQuad()
  return self.quad
end

function Sprite:getImage()
  return self.current_anim:getImage()
end

function Sprite:getWidth()
  return self.current_anim:getWidth()
end

function Sprite:getHeight()
  return self.current_anim:getHeight()
end

function Sprite:draw(options)
  love.graphics.push()
  options = options or {}
  
  if options["flip"] == true then
    love.graphics.scale(0.5, 1)
  end

  love.graphics.drawq(self.current_anim:getImage(), self.quad, self.x, self.y)
  love.graphics.pop()
end

function Sprite:move(dx, dy)
  self.x = self.x + dx
  self.y = self.y + dy
end
