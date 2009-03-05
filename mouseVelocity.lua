mouseVelocity = {}

-- clear all but the current mouse coordinates
function mouseVelocity.reset()
  recentMouseCoords = {x = love.mouse.getX(), y = love.mouse.getY()}
end

function mouseVelocity:update(dt)
  if love.mouse.isDown(love.mouse_left) then
    pieces.collection[#pieces.collection].body:setPosition(love.mouse.getX(), love.mouse.getY())
    vx, vy = mouseVelocity:calculate(dt)
    pieces.collection[#pieces.collection].body:setVelocity(vx, vy)
  end
end

function mouseVelocity:calculate(dt)
  currentMouseCoords = {x = love.mouse.getX(), y = love.mouse.getY()}
  if not recentMouseCoords then recentMouseCoords = currentMouseCoords end
  
  local vx = currentMouseCoords.x - recentMouseCoords.x
  local vy = currentMouseCoords.y - recentMouseCoords.y

  return (vx * math.abs(vx)) * dt * 100,
         (vy * math.abs(vy)) * dt * 100
end