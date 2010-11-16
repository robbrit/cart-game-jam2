Sprite = {}
Sprite_mt = { __index = Sprite }

function Sprite:new(x, y, animations)
  local hash = {}

  hash.x          = x
  hash.y          = y
  hash.animations = animations

  hash.current_anim = hash.animations.idle

  hash.current_frame = 0
  hash.last_update

  hash.quad = hash.current_anim:getQuad()

  return setmetatable(hash, Sprite_mt)
end

function Sprite:setAnimation(which)
  self.current_anim = self.animations[which]
  self.current_frame = 0
  self.current_anim:updateQuad(self.quad, self.current_frame)
end

function Sprite:update()
  time = love.timer.getMicroTime()

  if time > self.last_update + self.current_anim.frame_rate then
    self.current_frame = (self.current_frame + 1) % self.current_anim.num_frames
    self.current_anim:updateQuad(self.quad, self.current_frame)
    last_update = time
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
