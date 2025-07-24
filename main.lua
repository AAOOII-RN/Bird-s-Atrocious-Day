Object = require "lib.classic"
require "classes.player"
require "classes.block"

function love.load()
    math.randomseed(os.clock())
    ticker = 0 -- Don't trust love.timer.getTime()
    ww, wh = love.graphics.getDimensions()

    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 627)

    player = Player()
    block = Block()

    for i = 1, #block.obstacles do
        block:newBlock(i, ww/3, 0, wh/#block.obstacles, wh/#block.obstacles)
    end
end

function LERP(from, to, t)
    return from+(to - from)*t
end

function love.update(dt)
    ticker = ticker + 1 * dt

    world:update(dt)
    player:update(dt)
    block:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(0, 194/255, 1)
    player:draw()
    block:draw()
end
