Object = require "lib.classic"
require "classes.player"
require "classes.block"

function love.load()
    ticker = 0 -- Don't trust love.timer.getTime()
    ww, wh = love.graphics.getDimensions()

    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 627)

    player = Player()
    block = Block()

    block:newBlock(1, 0, 0, 50, wh)
    block:newBlock(2, 0, 0, 50, wh)
end

function LERP(a, b, t)
    return a+(b - a)*t
end

function love.update(dt)
    ticker = ticker + 1 * dt
    world:update(dt)
    player:update(dt)

    block.blocks[1].body:setX(LERP(ww+block.blocks[1].width/2, -block.blocks[1].width/2, (math.sin(ticker-math.pi/2)+1)/2))
    block.blocks[2].body:setX(block.blocks[1].body:getX()) -- Imagine relying on someone else LMAOOOO

    if math.floor((block.blocks[1].body:getX() + block.blocks[1].width/2)*36) == 0 or math.floor((ww+block.blocks[1].width/2 - block.blocks[1].body:getX())*36) == 0 then --  the "*36" the code will execute 9 times, idfk why I multiplied it to 4, but hey--- atleast it works right!
        block.blocks[1].body:setY(math.random(0, wh))
        block.blocks[2].body:setY(math.random(0, wh)) -- Someone ship blocks[1] and blocks[2]
    end
end

function love.draw()
    player:draw()
    block:draw()
end
