
love.filesystem.require 'scene.lua'
love.filesystem.require 'mouseVelocity.lua'
love.filesystem.require 'pieces.lua'

function load()
  -- Load images.
	loveImg = love.graphics.newImage("love_ball.png", love.image_pad_and_optimize)
  -- load the world
	scene.load()
end

function update(dt)
  -- recalculate mouse velocity
  mouseVelocity.update()
  -- Update the world.
  scene.world:update(dt)
end

function draw()
  scene.draw()
  pieces.draw()
end

function mousepressed(x, y, button)
  if button == love.mouse_left then
    pieces.addHeld(x, y)
  end
end

function keypressed(key)
  if key == love.key_escape then
    love.system.exit()
  end
end