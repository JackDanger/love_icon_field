
mouse = {}

function mouse.draw()
  if love.mouse.isDown(love.mouse_left) then
    local closest = pieces.held:closest()
    if closest then
      love.graphics.line(
        closest.body:getX(),
        closest.body:getY(),
        love.mouse.getX(),
        love.mouse.getY()
      )
    end
  end
end

mouse.velocity = {}
-- clear all but the current mouse coordinates
function mouse.velocity:reset()
  recentMouseCoords = {x = love.mouse.getX(), y = love.mouse.getY()}
end

function mouse.velocity:update(dt)
  if love.mouse.isDown(love.mouse_left) then
    pieces.collection[#pieces.collection].body:setPosition(love.mouse.getX(), love.mouse.getY())
    vx, vy = mouse.velocity:calculate(dt)
    pieces.collection[#pieces.collection].body:setVelocity(vx, vy)
  end
end

function mouse.velocity:calculate(dt)
  currentMouseCoords = {x = love.mouse.getX(), y = love.mouse.getY()}
  if not recentMouseCoords then recentMouseCoords = currentMouseCoords end
  
  local vx = currentMouseCoords.x - recentMouseCoords.x
  local vy = currentMouseCoords.y - recentMouseCoords.y

  return (vx * math.abs(vx)) * dt * 100,
         (vy * math.abs(vy)) * dt * 100
end