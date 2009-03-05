
love.filesystem.require 'mouse_velocity.lua'
pieces = {}

function load()
  -- video modes - use the second-to-last one
  local modes = love.graphics.getModes()
  videoMode = modes[6]
  print(videoMode.width, videoMode.height)
  love.graphics.setMode(videoMode.width, videoMode.height, false, false, 0)
  -- Load images.
	loveImg = love.graphics.newImage("love_ball.png", love.image_pad_and_optimize)
  -- Create the world.
  world = love.physics.newWorld(videoMode.width, videoMode.height)
  world:setGravity(0, 100)

  -- Create ground body.
  ground = love.physics.newBody(world, 0, 0, 0)
  ground_shape = love.physics.newRectangleShape(ground, videoMode.width/2, videoMode.height-20, videoMode.width -10, 10)
  -- add walls that go along the edge but also lean out really high to catch stray particles
  wall_left    = love.physics.newPolygonShape(ground,
                                                0, 0,
                                                0, videoMode.height,
                                                -50, videoMode.height,
                                                -50, -500)
  wall_right   = love.physics.newPolygonShape(ground,
                                                videoMode.width, 0,
                                                videoMode.width, videoMode.height,
                                                videoMode.width + 50, videoMode.height,
                                                videoMode.width + 50, videoMode.height + 500)
end

function update(dt)
  if love.mouse.isDown(love.mouse_left) then
    pieces[#pieces].body:setPosition(love.mouse.getX(), love.mouse.getY())
    vx, vy = mouseVelocity:update()
    pieces[#pieces].body:setVelocity(vx, vy)
  end
  -- Update the world.
  world:update(dt)
end

function draw()
  love.graphics.polygon(love.draw_line, ground_shape:getPoints())
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
    mouseVelocity:reset()
  end
end


function keypressed(key)
  if key == love.key_escape then
    love.system.exit()
  end
end