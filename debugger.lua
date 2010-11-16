-- print stuff to screen
function printStuff()
    -- use print("bla") to print to terminal
    love.graphics.print("poor man's debugger", 20, 20)
    love.graphics.print("MOUSE", 700, 20)
        mouseX, mouseY = love.mouse.getPosition( )
        love.graphics.print("X: " .. mouseX, 700, 40)
        love.graphics.print("Y: " .. mouseY, 700, 60)

    love.graphics.print("LINEAR VELOCITY", 20, 50)
        linearVx, linearVy = cube[1].body:getLinearVelocity( )
        speed = linearVx * (10/linearVx ) 
        love.graphics.print("Linear Velocity X: " .. linearVx, 40, 70)
        love.graphics.print("Linear Velocity Y: " .. linearVy, 40, 90)
        love.graphics.print("speed: " .. speed, 40, 110)

    love.graphics.print("FRICTION", 20, 120)
        love.graphics.print("friction: " .. cube[1].shape:getFriction( ), 40, 140)

    love.graphics.print("DATA", 20, 170)
        data = cube[1].shape:getData( )
        love.graphics.print("position X: " .. userX, 40, 190)
        love.graphics.print("position Y: " .. userY, 40, 210)

    love.graphics.print("COLLISION", 20, 240)
    if collisionData.object1 then
        love.graphics.print("object1 x: " .. collisionData.object1.x, 40, 260)
        love.graphics.print("object1 y: " .. collisionData.object1.y, 40, 280)
        love.graphics.print("object1 width: " .. collisionData.object1.width, 40, 300)
        love.graphics.print("object1 height: " .. collisionData.object1.height, 40, 320)
        love.graphics.print("object2 x: " .. collisionData.object2.x, 40, 340)
        love.graphics.print("object2 y: " .. collisionData.object2.y, 40, 360)
        love.graphics.print("object2 width: " .. collisionData.object2.width, 40, 380)
        love.graphics.print("object2 height: " .. collisionData.object2.height, 40, 400)
        love.graphics.print("collision position x: " .. collisionData.x, 40, 420)
        love.graphics.print("collision position y: " .. collisionData.y, 40, 440)
    end
    
    love.graphics.print("DIRECTION", 20, 470)
    love.graphics.print("direction variable is set to " .. direction, 40, 490)
    love.graphics.print("Angle " .. cube[1].body:getAngle( ), 40, 510)
    
    if persistingCollisionData.object1 then
        love.graphics.print("persist1 x:" .. persistingCollisionData.object1.x, 400, 260)
        love.graphics.print("persist1 y:" .. persistingCollisionData.object1.y, 400, 280)
        
        love.graphics.print("persist2 x:" .. persistingCollisionData.object2.x, 400, 300)
        love.graphics.print("persist2 y:" .. persistingCollisionData.object2.y, 400, 320)
    else
        love.graphics.print("persist1 x: none", 400, 260)
        love.graphics.print("persist1 y: none", 400, 280)
        
        love.graphics.print("persist2 x: none", 400, 300)
        love.graphics.print("persist2 y: none", 400, 320)
    end
    
    love.graphics.print("spacebar charge: " .. cube[1].keyCharge, 400, 340)
    love.graphics.print("cube state: " .. cube[1].state, 400, 360)
    
    vX1, vY1, vX2, vY2, vX3, vY3, vX4, vY4 = cube[1].shape:getPoints()
    love.graphics.print("x1: " .. vX1 .. "  y1: " .. vY1 .. "  x2: " .. vX2 .. "  y2: " .. vY2, 400, 380)
    love.graphics.print("x3: " .. vX3 .. "  y3: " .. vY3 .. "  x4: " .. vX4 .. "  y4: " .. vY4, 400, 400)
    
    camX, camY = getCamera():pos()
    love.graphics.print("Camera x: " .. camX .. "  y: " .. camY, 400, 430)
end
