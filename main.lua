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
    world = love.physics.newWorld(0, 627) -- 627

    btnui = ButtonUI()
    block = Block()
    
    menus = Menus()
    player = Player()
    hitw = HITW()
end

function LERP(from, to, t)
    return from+(to - from)*t
end

function INV_LERP(from, to, dist)
    return (dist-from)/(to-from)
end

function FLOOR(a, p) -- idk how to name this
    return math.floor(p*a)/p
end

function love.update(dt)
    ticker = ticker + 1 * dt
    
    world:update(dt)
    btnui:update(dt)
    menus:update(dt)
    player:update(dt)
    hitw:update(dt)
end

function love.mousepressed()
    menus:mousepressed()
end

function love.draw()
    love.graphics.setBackgroundColor(0, 140/255, 1)
    local gradient_size = 16
    for i = 0, wh/gradient_size do -- Background
        love.graphics.setColor(171/255, 134/255, 1, i/(wh/gradient_size))
        love.graphics.rectangle("fill", 0, i*gradient_size, ww, gradient_size) 
    end

    local size = 128
    for x = 0, size do
        for y = 0, size do
            wl = 0.01
            n1 = love.math.noise((wl/3)*x+ticker/20, (wl*3)*y)
            n2 = love.math.noise((wl/3)*x+(ticker-512)/15, (wl*3)*y)
            if n1 > 0.9 then
                love.graphics.setColor(1,1,1, 0.25)
                love.graphics.rectangle("fill", x*(ww/size), y*(wh/size), ww/size, wh/size)
            end
            if n2 > 0.9 then
                love.graphics.setColor(1,1,1, 0.125)
                love.graphics.rectangle("fill", x*(ww/size), y*(wh/size), ww/size, wh/size)
            end
        end
    end

    love.graphics.setColor(1, 108/255, 80/255, 0.5)
    love.graphics.circle("fill", 4*ww/5, wh/5, 100)
    
    --block:draw()
    --btnui:draw()
    player:draw()
    hitw:draw()
    menus:draw()

end
