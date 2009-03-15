
pieces = {}
pieces.collection = {}
pieces.scale = 1/10
-- how close two pieces have to be until the line appears
pieces.maxDistance = 120

function pieces.addHeld(x, y)
	pieces.held = {}
	pieces.held.body  = love.physics.newBody(scene.world, x, y)
	pieces.held.image = pieces:randomImage()
	pieces.held.shape = love.physics.newCircleShape(pieces.held.body, pieces.held.image:getWidth()/2 * pieces.scale)
	pieces.held.shape:setFriction(0) -- very slick surface
  -- reset mouse velocity because this piece hasn't moved yet
  mouse.velocity:reset()
end

function pieces:draw()
  for i,piece in ipairs(pieces.collection) do
    love.graphics.draw(piece.image, piece.body:getX(), piece.body:getY(), piece.body:getAngle(), pieces.scale)
  end
end

function pieces:randomImage()
  if not pieces.images then pieces:getImages() end
  return pieces.images[math.random(1, #pieces.images)]
end

function pieces:getImages()
  pieces.images = {}
	for i,file in ipairs(love.filesystem.enumerate('icons')) do
	  if string.find(file, "%.png") then
			table.insert(pieces.images, love.graphics.newImage("icons/"..file, love.image_pad_and_optimize))
		end
	end
end
