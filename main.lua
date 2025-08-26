love.graphics.setDefaultFilter("nearest")

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

    font = love.graphics.newFont("GameFont.ttf", 100, "light")
    love.graphics.setFont(font)
    
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 627) -- 627
    
    bg_color =  rgba(0, 194, 255)

    btnui = ButtonUI()
    block = Block()
    menus = Menus()
    player = Player()
    hitw = HITW()
end

function rgba(a, b, c, d) -- Im so tired of translating RGB to 0-1
    local t = {a/255, b/255, c/255, d}
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

function love.mousepressed() -- The menu func should be the last to call :DD
    player:mousepressed()
    hitw:mousepressed()
    menus:mousepressed()
end

function love.keypressed(key)
    player:keypressed(key)
end

function love.draw()
    love.graphics.setBackgroundColor(bg_color)
    --love.graphics.draw(bg_test)
    --block:draw()
    --btnui:draw()
    player:draw()
    hitw:draw()
    menus:draw()
end
