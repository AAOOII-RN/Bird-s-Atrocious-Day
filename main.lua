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

    bg_color = rgb(0,194,255)
    gradient_color = rgb(171,134,255)
    sun_color = {1, 108/255, 80/255}
    cloud_pos = math.random(-512, 512)
end

function rgb(a, b, c) -- Im so tired of translating RGB to 0-1
    local t = {a/255, b/255, c/255}
    return t
end

function lerp_colors(t1, t2, t)
    local r1, g1, b1 = unpack(t1)
    local r2, g2, b2 = unpack(t2)
    local h = {}
    table.insert(h, r1 + t*(r2-r1))
    table.insert(h, g1 + t*(g2-g1))
    table.insert(h, b1 + t*(b2-b1))
    return h
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

function love.keypressed(key)
    player:keypressed(key)
end

function love.draw()
    love.graphics.setBackgroundColor(bg_color)
    local gradient_size = 16
    for i = 0, wh/gradient_size do -- Background
        gradient_color[4] = i/(wh/gradient_size)
        love.graphics.setColor(gradient_color)
        love.graphics.rectangle("fill", 0, i*gradient_size, ww, gradient_size) 
    end

    local size = 128
    for x = 0, size do
        for y = 0, size do
            local wl = 0.01
            local n1_high = love.math.noise((wl/3)*x+(ticker+cloud_pos)/20, (wl*3)*y)
            local n1_low = love.math.noise((wl/3)*x+(ticker*2)/20, wl*y) * 0.1
            local n1 = n1_high + n1_low

            local n2_high = love.math.noise((wl/3)*x+(ticker+512+cloud_pos)/15, (wl*3)*y)
            local n2_low = love.math.noise((wl/3)*x+(ticker*1.5)/15, wl*y) * 0.25
            local n2 = n2_high + n2_low

            if n1 > 0.9 then
                love.graphics.setColor(1,1,1, 0.125)
                love.graphics.rectangle("fill", x*(ww/size), y*(wh/size), ww/size, wh/size)
            end
            if n2 > 0.9 then
                love.graphics.setColor(1,1,1, 0.0625)
                love.graphics.rectangle("fill", x*(ww/size), y*(wh/size), ww/size, wh/size)
            end
        end
    end

    sun_color[4] = 0.5
    love.graphics.setColor(sun_color)
    love.graphics.circle("fill", 4*ww/5, wh/5, 100)
    
    --block:draw()
    --btnui:draw()
    player:draw()
    hitw:draw()
    menus:draw()

end
