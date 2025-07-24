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

    for i = 1, 8 do
        block:newBlock(i, ww/3, 0, 50, 50)
    end
end

function LERP(a, b, t)
    return a+(b - a)*t
end

function love.update(dt)
    ticker = ticker + 1 * dt
    world:update(dt)
    player:update(dt)

    for i, show in ipairs(block.obstacles) do
        if show == 1 then
            block.blocks[i].body:setY(i * block.blocks[i].height)
        end
    end
end

function love.draw()
    player:draw()
    block:draw()
end
