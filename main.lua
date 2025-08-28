love.graphics.setDefaultFilter("nearest")

Object = require "lib.classic"
require "classes.player"
require "classes.block"
require "classes.challenges"
require "classes.buttonUI"
require "classes.menus"
require "classes.graphics"

function love.load()
    math.randomseed(os.clock())
    love.mouse.setVisible(false)
    ticker = 0 -- Don't trust love.timer.getTime()
    
    ww, wh = love.graphics.getDimensions()

    font = love.graphics.newFont("GameFont.ttf", 100, "light")
    love.graphics.setFont(font)
    
    bg_color =  rgba(26, 26, 37)

    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 627) -- 627
    graphics = Graphics()
    btnui = ButtonUI()
    block = Block()
    menus = Menus()
    player = Player()
    challenges = Challenges()
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

function lerp(from, to, t)
    return from+t*(to-from)
end

function roundtobase(num, base)
    return math.floor(num/base)*base
end

function love.update(dt)
    ticker = ticker + 1 * dt
    
    world:update(dt)
    graphics:update(dt)
    btnui:update(dt)
    menus:update(dt)
    player:update(dt)
    challenges:update(dt)
end

function love.mousepressed() -- The menu func should be the last to call :DD
    player:mousepressed()
    challenges:mousepressed()
    menus:mousepressed()
end

function love.keypressed(key)
    player:keypressed(key)
end

function love.draw()
    love.graphics.setBackgroundColor(bg_color)
    
    graphics:draw()
    block:draw()
    --btnui:draw()
    player:draw()
    challenges:draw()
    menus:draw()
    love.graphics.circle("fill", love.mouse.getX(), love.mouse.getY(), 10)
end
