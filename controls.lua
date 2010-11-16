function applyJump(force)
    posX, posY = cube[1].body:getPosition()
    cube[1].body:applyImpulse( 0, -(math.abs(force))) 
end

function getKeyPress()
    space = love.keyboard.isDown(" ")

    if (space ~= lastKey) then
        lastKey = space -- this construct detect 1 key down at a time!
        if (space) then
            --nothing happens here, for now
        else 
            if (space == false) then
                --space got released
                applyJump(cube[1].keyCharge)
                cube[1].keyCharge = 0
            end
        end
    end
    
    if space and cube[1].keyCharge < cube[1].maxCharge and cube[1].state == "push" then
        cube[1].keyCharge = cube[1].keyCharge+1
    end
end
