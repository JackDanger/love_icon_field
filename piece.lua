
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

function piece:closest()
end

function piece:draw()
  love.graphics.draw(self.image, self.body:getX(), self.body:getY(), self.body:getAngle(), pieces.scale)
end