userX, userY = 0
dynamicBoxID = 1
-- Adds a cube.
function addCube(x, y, x2, y2, name)
    local t = {}
    t.body = love.physics.newBody(world, x, y)
    t.shape = love.physics.newRectangleShape(t.body, x, y, x2, y2)
    t.shape:setRestitution( 0.0 ) --bouncyness
    
    t.body:setMass(x,y, 11, 1) --weight
    
    t.keyCharge = 0
    t.maxCharge = 65
    t.state = "falling"
    
    data = {}
          posX, posY = t.body:getPosition( )
          data.x = posX
          data.y = posY
          data.width = 30 -- this was established in the load function
          data.height = 30 -- this was established in the load function
          data.name = name
          data.uId = dynamicBoxID
          dynamicBoxID = dynamicBoxID + 1
    t.shape:setData( data )
    
    table.insert(cube, t)
end

function userPosition()
    vX1, vY1, vX2, vY2, vX3, vY3, vX4, vY4 = cube[1].shape:getPoints()
    centerValueX = vX1 - vX3
    centerValueX = math.abs(centerValueX)
    centerPointX = centerValueX/2

    centerValueY = vY2 - vY4
    centerValueY = math.abs(centerValueY)
    centerPointY = centerValueY/2

    centerAppendX = math.min(vX1, vX2, vX3, vX4)
    centerAppendY = math.min(vY1, vY2, vY3, vY4)

    userX = centerAppendX + centerPointX
    userY = centerAppendY + centerPointY
end

function updateCubeState(newState)
    cube[1].state = newState
end
--states are:
--push
--falling
