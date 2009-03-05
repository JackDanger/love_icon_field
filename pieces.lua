
pieces = {}
pieces.collection = {}

function pieces.addHeld(x, y)
	local grabbed = {}
	grabbed.body  = love.physics.newBody(scene.world, x, y)
	grabbed.shape = love.physics.newCircleShape(grabbed.body, loveImg:getWidth()/2)
	grabbed.shape:setFriction(0) -- very slick surface
  table.insert(pieces.collection, grabbed)
  -- reset mouse velocity because this piece hasn't moved yet
  mouseVelocity:reset()
end

function pieces:draw()
  for i,piece in ipairs(pieces.collection) do
    love.graphics.draw(loveImg, piece.body:getX(), piece.body:getY(), piece.body:getAngle())
  end
end