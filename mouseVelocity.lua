mouseVelocity = {}

-- clear all but the current mouse coordinates
function mouseVelocity.reset()
  recentMouseCoords = {
    {x = love.mouse.getX(), y = love.mouse.getY()}
  }
end

function mouseVelocity.update()
  if love.mouse.isDown(love.mouse_left) then
    pieces.collection[#pieces.collection].body:setPosition(love.mouse.getX(), love.mouse.getY())
    vx, vy = mouseVelocity:calculate()
    pieces.collection[#pieces.collection].body:setVelocity(vx, vy)
  end
end

function mouseVelocity.calculate()
  currentMouseCoords = {x = love.mouse.getX(), y = love.mouse.getY()}
  -- if recentMouseCoords is blank or if an argument was passed to this function
  -- the reset the saved coordinates
  if not recentMouseCoords then recentMouseCoords = {currentMouseCoords} end
  
  local vx = currentMouseCoords.x - recentMouseCoords[#recentMouseCoords].x
  local vy = currentMouseCoords.y - recentMouseCoords[#recentMouseCoords].y

  -- only save a certain number
  if #recentMouseCoords >= 50 then
    table.remove(recentMouseCoords, #recentMouseCoords)
  end
  -- add the currentMouseCoords to the front of the table.
  -- They'll be used in 50 frames
  table.insert(recentMouseCoords, 1, currentMouseCoords)
  return vx*5, vy*5
end