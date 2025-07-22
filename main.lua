Object = require "lib.classic"
require "classes.player"
require "classes.block"

function love.load()
    ww, wh = love.graphics.getDimensions()

    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 627)

    player = Player()
    block = Block()

    block:newBlock(1, ww, wh/2, 10, wh)
    block:newBlock(2, 0, wh/2, 10, wh)
    block:newBlock(3, ww/2, wh, ww, 10)
    block:newBlock(4, ww/2, 0, ww, 10)
end

function love.update(dt)
    world:update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
    block:draw()
end
