
mouse = {}

function mouse.draw()
  if love.mouse.isDown(love.mouse_left) then
    local closest = pieces.held:closest()
    if closest then
      local lw = love.graphics.getLineWidth()
      love.graphics.setLineWidth(11)
      love.graphics.line(
        closest.piece.body:getX(),
        closest.piece.body:getY(),
        love.mouse.getX(),
        love.mouse.getY()
      )
      love.graphics.setLineWidth(lw)

      pieces.held:align(closest)
    else
      pieces.held:unalign()
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