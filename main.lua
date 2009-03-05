
love.filesystem.require 'mouse_velocity.lua'
love.filesystem.require 'scene.lua'
pieces = {}

function load()
  -- Load images.
	loveImg = love.graphics.newImage("love_ball.png", love.image_pad_and_optimize)
  -- load the world
	scene:load()
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
  scene:draw()
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