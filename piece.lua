
piece = {}

function piece:new(x, y)
  local instance = {}
  instance.id = math.random()
  setmetatable(instance, self)
  self.__index = self

	instance.body  = love.physics.newBody(scene.world, x, y)
	instance.image = pieces:randomImage()
	instance.shape = love.physics.newCircleShape(instance.body, instance.image:getWidth()/2 * pieces.scale)
	instance.shape:setFriction(0) -- very slick surface

  return instance
end

function piece:alignClosest()
  self.aligned = piece.closestTo(self)
  if self.aligned and not self.aligned.aligned then
    print(self.aligned.id)
    self.aligned.aligned = self
  end
end

function piece:unalign()
  if self.aligned then
    self.aligned.aligned = nil
    self.aligned = nil
  end
end

function piece.closestTo(other)
  local closestFound = nil
  for i,piece in ipairs(pieces.collection) do
    if piece ~= other then
      local distance = math.sqrt(
        (piece.body:getX() - other.body:getX())^2 +
        (piece.body:getY() - other.body:getY())^2
      )
      if distance < pieces.maxDistance
         and (not closestFound or
              distance < closestFound.distance) then
        closestFound = {piece = piece, distance = distance}
      end
    end
  end
  if closestFound then
    return closestFound.piece
  end
end

function piece:draw()
  love.graphics.draw(self.image, self.body:getX(), self.body:getY(), self.body:getAngle(), pieces.scale)
end