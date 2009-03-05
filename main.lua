
pieces = {}

function load()
  -- Load images.
	loveImg = love.graphics.newImage("love_ball.png", love.image_pad_and_optimize)
  -- Create the world.
  world = love.physics.newWorld(2000, 2000)
  world:setGravity(0, 50)

  -- Create ground body.
  ground = love.physics.newBody(world, 0, 0, 0)
  wall_left   = love.physics.newPolygonShape(ground, -50, -50, -50, 650, 0, 650, 0, -50)
  wall_right  = love.physics.newPolygonShape(ground, 800, -50, 800, 650, 850, 650, 850, -50)
  wall_bottom = love.physics.newPolygonShape(ground, 0, 650, 800, 650, 800, 600, 0, 600)
end

function update(dt)
  if love.mouse.isDown(love.mouse_left) then
    pieces[#pieces].body:setPosition(love.mouse.getX(), love.mouse.getY())
    vx, vy = mouseVelocity()
    pieces[#pieces].body:setVelocity(vx, vy)
  end
  -- Update the world.
  world:update(dt)
end

function draw()
  for i,piece in ipairs(pieces) do
      love.graphics.draw(loveImg, piece.body:getX(), piece.body:getY(), piece.body:getAngle())
  end
end

function mousepressed(x, y, button)
  if button == love.mouse_left then
  	local grabbed = {}
  	grabbed.body  = love.physics.newBody(world, x, y)
  	grabbed.shape = love.physics.newCircleShape(grabbed.body, loveImg:getWidth()/2)
  	grabbed.shape:setFriction(0) -- very slick surface
    table.insert(pieces, grabbed)
    -- reset mouse velocity because this piece hasn't moved yet
    mouseVelocity('reset')
  end
end

function mouseVelocity(...)
  currentMouseCoords = {x = love.mouse.getX(), y = love.mouse.getY()}
  -- if recentMouseCoords is blank or if an argument was passed to this function
  -- the reset the saved coordinates
  if not recentMouseCoords or arg[1] then recentMouseCoords = {currentMouseCoords} end
  
  local vx = currentMouseCoords.x - recentMouseCoords[#recentMouseCoords].x
  local vy = currentMouseCoords.y - recentMouseCoords[#recentMouseCoords].y
  -- only save a certain number
  if #recentMouseCoords >= 5 then
    table.remove(recentMouseCoords, #recentMouseCoords)
  end
  -- add the currentMouseCoords to the front of the table.  They'll
  -- be used in 5 frames
  table.insert(recentMouseCoords, 1, currentMouseCoords)

  return vx, vy
end