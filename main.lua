Object = require "lib.classic"
require "classes.player"
require "classes.block"
require "classes.holeInTheWall"
require "classes.buttonUI"
require "classes.menus"

function love.load()
    math.randomseed(os.clock())
    ticker = 0 -- Don't trust love.timer.getTime()
    ww, wh = love.graphics.getDimensions()

    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 627)

    btnui = ButtonUI()
    block = Block()
    
    menus = Menus()
    player = Player()
    --hitw = HITW()

    menus:intro()
end

function LERP(from, to, t)
    return from+(to - from)*t
end

function love.update(dt)
    ticker = ticker + 1 * dt

    world:update(dt)
    btnui:update(dt)
    player:update(dt)
    --hitw:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(0, 194/255, 1)
    btnui:draw()
    player:draw()
    --hitw:draw()
end
