lastColidded = 0

function persistedCollision(object1, object2, collision)
    persistingCollisionData.object1 = object1
    persistingCollisionData.object2 = object2

    player, wall = nil

    if  collisionData.object1.name == "player" then
        player = collisionData.object1
        wall = collisionData.object2
    else
        player = collisionData.object2
        wall = collisionData.object1
    end
    
    -- updateCubeStatecubeStateSolver(player, wall)
    
    -- print(cubeStateSolver(player, wall))
    
    print("colisionX: " .. collisionData.x .. "  collisoinY: " .. collisionData.y);
    print(" object2X: " .. collisionData.object2.x .. "  object2Y: " .. collisionData.object2.y .. " object2W: " .. collisionData.object2.width .. " object2H: " .. collisionData.object2.height)
    
    -- check if the user block is collidding
    if  collisionData.object1.name == "player" or  collisionData.object2.name == "player" then
        -- check if the first object is the static object
        if collisionData.object1.name == "staticBox" then
            -- check if the box collided with the top of the static box
            if round( collisionData.y) ==  collisionData.object1.y then
                updateCubeState(collisionData.object1.top)
            end
            
            -- check if the box collided with the bottom of the static box
            if round( collisionData.y) == (collisionData.object1.y+collisionData.object1.height) then
                updateCubeState(collisionData.object1.bottom)
            end
            
            -- check if the box collided with the left of the static box
            if round( collisionData.x) ==  collisionData.object1.x then
                updateCubeState(collisionData.object1.left)
            end
            
            -- check if the box collided with the right of the static box
            if round( collisionData.x) == (collisionData.object1.x+collisionData.object1.width) then
                updateCubeState(collisionData.object1.right)
            end
        end
        
        -- check if the second object is the static object
        if collisionData.object2.name == "staticBox" then
            -- check if the box collided with the top of the static box
            if round( collisionData.y) ==  collisionData.object2.y then
                updateCubeState(collisionData.object2.top)
            end
            
            -- check if the box collided with the bottom of the static box
            if round( collisionData.y) == (collisionData.object2.y+collisionData.object2.height ) then
                updateCubeState(collisionData.object2.bottom)
            end
            
            -- check if the box collided with the left of the static box
            if round( collisionData.x) ==  collisionData.object2.x then
                updateCubeState(collisionData.object2.left)
            end
            
            -- check if the box collided with the right of the static box
            if round( collisionData.x) == (collisionData.object2.x+collisionData.object2.width ) then
                updateCubeState(collisionData.object2.right)
            end
        end
        
    end
    
   directionSwitcher()

end

function removedCollision(object1, object2, collision)
    removedCollisionData.object1 = object1
    removedCollisionData.object2 = object2
    
    --if the cube has stopped colliding
    if  collisionData.object1.name == "player" or collisionData.object2.name == "player" then
        updateCubeState("falling")
    end
end

function addedCollision(object1, object2, collision)
    collisionData.object1 = object1
    collisionData.object2 = object2

    colX, colY = collision:getPosition()
    collisionData.x = colX
    collisionData.y = colY
end

function directionSwitcher()
    -- check if the user block is collidding
    if  collisionData.object1.name == "player" or  collisionData.object2.name == "player" then
        -- check if hte cube is on a switch state
        if cube[1].state == "switch" then
            --check to see if object 1 is NOT the player (that is to say, the static object)
            if collisionData.object1.name ~= "player" then
                -- check that the object you are colliding with isn't the same one you _just_ collided with
                if collisionData.object1.uId ~= lastColidded then
                    print("switching direction")
                    direction = direction * -1
                    lastColidded = collisionData.object1.uId
                end
            end
            
            --check to see if object 2 is NOT the player (that is to say, the static object)
            if collisionData.object2.name ~= "player" then
                -- check that the object you are colliding with isn't the same one you _just_ collided with
                if collisionData.object2.uId ~= lastColidded then
                    print("switching direction")
                    print("last UID: " .. lastColidded .. "current UID: " .. collisionData.object2.uId)
                    direction = direction * -1
                    lastColidded = collisionData.object2.uId
                end
            end
        end
    end
end

function applySlide()
    if cube[1].state == "push" then
        linearVx, linearVy = cube[1].body:getLinearVelocity( )
        posX, posY = cube[1].body:getPosition()
        cube[1].body:setLinearVelocity(150*direction, linearVy)
    end
end

function cubeStateSolver(player, wall)
    --check for top
    if player.y < wall.y and player.x >= wall.x and player.x <= (wall.x+wall.width) then
        return wall.top
    end
    
    --check for right
    if player.x > wall.x and player.y >= wall.y and player.y <= (wall.y+wall.height) then
        return wall.right
    end
    
    --check for bottom
    if player.y > wall.y and player.x >= wall.x and player.x <= (wall.x+wall.width) then
        return wall.bottom
    end
    
    --check for left
    if player.x < wall.x and player.y >= wall.y and player.y <= (wall.y+wall.height) then
        return wall.left
    end
end
