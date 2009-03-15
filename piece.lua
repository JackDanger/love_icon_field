
piece = {}

function piece:new(x, y)
  local instance = {}
  setmetatable(instance, self)
  self.__index = self

	instance.body  = love.physics.newBody(scene.world, x, y)
	instance.image = pieces:randomImage()
	instance.shape = love.physics.newCircleShape(instance.body, instance.image:getWidth()/2 * pieces.scale)
	instance.shape:setFriction(0) -- very slick surface

  return instance
end

function piece:align(other)
  self.aligned = other
  if not other.aligned then other.aligned = self end
end

function piece:unalign()
  if self.aligned then
    self.aligned.aligned = nil
    self.aligned = nil
  end
end

function piece:closest()
  if #pieces.collection == 0 then
    return
  end

  local closestFound = nil
  for i,piece in ipairs(pieces.collection) do
    if piece ~= self then
      local distance = math.sqrt(
        (piece.body:getX() - self.body:getX())^2 +
        (piece.body:getY() - self.body:getY())^2
      )
      if distance < pieces.maxDistance
         and (not closestFound or
              distance < closestFound.distance) then
        closestFound = {piece = piece, distance = distance}
      end
    end
  end
  return closestFound
end

function piece:draw()
  love.graphics.draw(self.image, self.body:getX(), self.body:getY(), self.body:getAngle(), pieces.scale)
end