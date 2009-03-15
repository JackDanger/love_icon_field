
mouse = {}

function mouse.draw()
  if love.mouse.isDown(love.mouse_left) then
    -- try to find the closest piece to the one the mouse is holding
    local closestPiece = {distance = 10000000}
    for i,piece in ipairs(pieces.collection) do
      local distance = math.sqrt(
                        (piece.body:getX() - love.mouse.getX())^2
                      + (piece.body:getY() - love.mouse.getY())^2
                       )
      if distance < closestPiece.distance then
        closestPiece.piece = piece
        closestPiece.distance = distance
      end
    end
    if closestPiece.piece then
      love.graphics.line(
        closestPiece.piece.body:getX(),
        closestPiece.piece.body:getY(),
        love.mouse.getX(),
        love.mouse.getY())
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