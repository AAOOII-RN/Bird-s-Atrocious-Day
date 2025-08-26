Graphics = Object:extend()

function Graphics:new()
    -- Background Canvas ----------------------------
    self.bgstuff_circles_color = rgba(26, 26, 37)
    self.bgstuff_circles = love.graphics.newCanvas(ww*2, wh*2)
    local bgfx_d = 64

    love.graphics.setCanvas(self.bgstuff_circles)
    love.graphics.clear()
    love.graphics.setBlendMode("alpha")
    for fx = 0, self.bgstuff_circles:getWidth()/bgfx_d, 2 do
        for fy = 0, self.bgstuff_circles:getHeight()/bgfx_d, 2 do
            love.graphics.setColor(
            rgba(254, 255, 255, 
            roundtobase(love.math.noise(fx/5, fy/5), 0.33)*0.5+0.13)
        ) -- Sometimes I can't see
            love.graphics.circle("fill", fx*bgfx_d, fy*bgfx_d, bgfx_d/2)
        end
    end
    --------------------------------------------------
    love.graphics.setCanvas()
end

function Graphics:update(dt)
    if menus.atMenu == "intro" then
        graphics.bgstuff_circles_color = lerp_colors(graphics.bgstuff_circles_color, rgba(144, 79, 90), 0.025)
    elseif menus.atMenu == "play" then
        graphics.bgstuff_circles_color = lerp_colors(graphics.bgstuff_circles_color, rgba(60, 60, 80), 0.025)
    elseif menus.atMenu == "store" then
        graphics.bgstuff_circles_color = lerp_colors(graphics.bgstuff_circles_color, rgba(187, 52, 77), 0.025)
    end
end

function Graphics:draw()
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.setColor(self.bgstuff_circles_color)
    love.graphics.draw(self.bgstuff_circles,
    lerp(0, ww, love.math.noise(os.clock()/50)),
    lerp(0, wh, love.math.noise(os.clock()/37)),
    0, 1, 1,
    self.bgstuff_circles:getWidth()/2,
    self.bgstuff_circles:getHeight()/2
)
    love.graphics.setBlendMode("alpha")
end