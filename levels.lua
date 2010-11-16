staticShapeID = 1

-- Adds a static box.
function addStaticBox(x, y, x2, y2, topProperty, rightProperty, bottomProperty, leftProperty)
    local t = {}
    t.body = ground
    t.shape = love.physics.newRectangleShape(t.body, (x+(x2/2)), (y+(y2/2)), x2, y2)
    t.shape:setRestitution( 0.0 ) --bouncyness
    data = {}
      data.x = x
      data.y = y
      data.width = x2
      data.height = y2
      data.name = "staticBox"
      data.top = topProperty
      data.bottom = bottomProperty
      data.left = leftProperty
      data.right = rightProperty
      data.uId = staticShapeID
      staticShapeID = staticShapeID + 1--increment the staticShape ID
    t.shape:setData( data )
    table.insert(boxes, t)
end


--[[
none - do nothing, only gravity will be applied
push - move in a direction
switch - switch directions
static - stick on the wall until you jump
]]--

function makelevelOne()
    -- patter is up right down left!!

    -- add floor
    addStaticBox(0, 500, love.graphics.getWidth( ) , love.graphics.getHeight( ), "push", "none", "none", "none")

    -- right wall
    addStaticBox(790, 0, 10 , 470, "static", "none", "static", "static") --this is a walljump wall

    --left wall
    --addStaticBox(0, 0, 10 , 500, "none", "switch", "none", "switch")
    addStaticBox(10, 5, 7, 490, "none", "switch", "none", "none");

    -- bounce box
    addStaticBox(790, 470, 10, 30, "none", "none", "none", "switch")
    
    -- second wall
    addStaticBox(700, 200, 20, 250, "push", "none", "switch", "static")
    
    --second floor
    addStaticBox(200, 180, 520, 20, "push", "none", "none", "none")
end
