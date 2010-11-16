Animation = {}
Animation_mt = { __index = Animation }

function Animation:new(filename, frame_width, timing)
  local hash = {}

  hash.image        = love.graphics.newImage(filename)
  hash.frame_width  = frame_width
  hash.frame_height = hash.image:getHeight()
  hash.num_frames   = hash.image:getWidth() / frame_width
  hash.timing       = timing

  return setmetatable(hash, Animation_mt)
end

function Animation:getImage()
  return self.image
end

function Animation:createQuad()
  return love.graphics.newQuad(0, 0, self.frame_width, self.frame_height,
    self.image:getWidth(), self.image:getHeight())
end

function Animation:updateQuad(quad, frame_no)
  quad:setViewport(frame_no * self.frame_width, 0, self.frame_width, self.frame_height)
  return quad
end

function Animation:getWidth()
  return self.image:getWidth()
end

function Animation:getHeight()
  return self.image:getHeight()
end

function Animation:getTiming(frame)
  return self.timing[frame + 1]
end
