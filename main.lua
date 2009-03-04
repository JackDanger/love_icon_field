
pieces = {}

function load()
  -- Load images.
	loveImg = love.graphics.newImage("love_ball.png")
  -- Create the world.
  world = love.physics.newWorld(2000, 2000)
  world:setGravity(0, 50)

  -- Create ground body.
  ground = love.physics.newBody(world, 0, 0, 0)
end

function update(dt)
  if love.mouse.isDown(love.mouse_left) then
    pieces[#pieces]:setPosition(love.mouse.getX(), love.mouse.getY())
  end
  -- Update the world.
  world:update(dt)
end

function draw()
  for i,piece in ipairs(pieces) do
      love.graphics.draw(loveImg, piece:getX(), piece:getY(), piece:getAngle())
  end
end

function mousepressed(x, y, button)
	local grabbed = love.physics.newBody(world, x, y)
	love.physics.newCircleShape(grabbed, 4)
  table.insert(pieces, grabbed)
end

function add(x, y)
	local b = love.physics.newBody(world, math.random(100, 700), 50)
	b:setMassFromShapes()
end