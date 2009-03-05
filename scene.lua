scene = {}

function scene.draw()
  love.graphics.polygon(love.draw_line, ground_shape:getPoints())
end

function scene.load()
  -- video modes
  local modes = love.graphics.getModes()
  -- use (arbitrarily #6)
  videoMode = modes[6]
  print(videoMode.width, videoMode.height)
  love.graphics.setMode(videoMode.width, videoMode.height, false, false, 0)
  -- Create the world.
  scene.world = love.physics.newWorld(videoMode.width, videoMode.height)
  scene.world:setGravity(0, 100)

  -- Create ground body.
  ground = love.physics.newBody(scene.world, 0, 0, 0)
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