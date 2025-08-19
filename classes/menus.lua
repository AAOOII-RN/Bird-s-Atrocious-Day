Menus = Object:extend()

function Menus:new()
    --[[
    List of Menus
    1. Intro     
    2. Play
    3. Paused
    4. Lose
    5. Store
    6. Settings
    ]]

    self.img = love.graphics.newImage("img/zero.png")
    self.atMenu = "intro"
    for i = 1, 4 do
        btnui:createButton("menu" .. i) -- What if I use pooling?
    end
    for i = 1, 5 do
        btnui:createButton("store" .. i)
    end
end

function Menus:update(dt)
    local lerp_speed = 0.25
    player.loopInWindow = false

    if self.atMenu == "intro" then
        player.loopInWindow = true
        for i = 1, 4 do
            btnui:editButton("menu" .. i, i*ww/5 - 125, 5*wh/6 - 62.5, 250, 125, true) -- Play
        end
        player.obj.body:setType("dynamic")
        bg_color = lerp_colors(bg_color, rgb(0, 195, 255), lerp_speed)
        gradient_color = lerp_colors(gradient_color, rgb(171,134,255), lerp_speed)
        sun_color = lerp_colors(sun_color, rgb(255, 255, 117), lerp_speed)

    elseif self.atMenu == "store" then
        for i = 1, 5 do
            btnui:editButton("store" .. i, ww/5 - 125, i*wh/6 - 62.5, 250, 125, true) -- Store items
        end
        btnui:editButton("menu1", 9*ww/10 - 62.5, wh/10 - 62.5, 125, 125, true) -- Back btn
        bg_color = lerp_colors(bg_color, rgb(255,255,117), lerp_speed)
        gradient_color = lerp_colors(gradient_color, rgb(0,194,255), lerp_speed)
        sun_color = lerp_colors(sun_color, rgb(171,134,255), lerp_speed)

    elseif self.atMenu == "play" then
        btnui:editButton("menu1", 9*ww/10 - 62.5, wh/10 - 62.5, 125, 125, true) -- Pause btn
        player.obj.body:setType("dynamic")
        bg_color = lerp_colors(bg_color, rgb(171,134,255), lerp_speed)
        gradient_color = lerp_colors(gradient_color, rgb(255,150,150), lerp_speed)
        sun_color = lerp_colors(sun_color, rgb(255,72,101), lerp_speed)

    elseif self.atMenu == "paused" then
        btnui:editButton("menu1", ww/2-125, wh/3-62.5, 250, 125, true) -- Resume
        btnui:editButton("menu2", ww/2-125, 2*wh/3-62.5, 250, 125, true) -- Main Menu

    elseif self.atMenu == "lose" then
        btnui:editButton("menu1", ww/2 - 125, wh/3 - 62.5, 250, 125, true) -- Retry
        btnui:editButton("menu2", ww/2 - 125, 2*wh/3 - 62.5, 250, 125, true) -- Main Menu
    end
end

function Menus:mousepressed()
    if self.atMenu == "intro" then
        if btnui:isHovered("menu1") then -- Play
            btnui:refresh()
            self.atMenu = "play"
            player.obj.body:setPosition(ww/2, wh/2)
            player.obj.body:setAngle(0)
            player.obj.body:setAngularVelocity(0)
            player.obj.body:setLinearVelocity(0,0)
        elseif btnui:isHovered("menu2") then
            btnui:refresh()
            self.atMenu = "store"
            player.obj.body:setType("static")
            player.obj.body:setPosition(ww+512, wh+512)
        elseif btnui:isHovered("menu4") then -- Exit
            love.event.quit()
        end

    elseif self.atMenu == "store" then
        if btnui:isHovered("menu1") then
            btnui:refresh()
            self.atMenu = "intro"
            player.obj.body:setType("dynamic")
            player.obj.body:setPosition(ww/2, wh/2)
        end

    elseif self.atMenu == "play" then
        if btnui:isHovered("menu1") then -- Pause
            self.atMenu = "paused"
            stored_pvx, stored_pvy = player.obj.body:getLinearVelocity()
            stored_pvr = player.obj.body:getAngularVelocity()
            player.obj.body:setType("static")
            hitw.obsTop.body:setType("static")
            hitw.obsDown.body:setType("static")
        end

    elseif self.atMenu == "paused" then
        if btnui:isHovered("menu1") then -- Resume
            btnui:refresh()
            self.atMenu = "play"
            player.obj.body:setType("dynamic")
            player.obj.body:setLinearVelocity(stored_pvx, stored_pvy)
            player.obj.body:setAngularVelocity(stored_pvr)
            hitw.obsTop.body:setType("dynamic")
            hitw.obsDown.body:setType("dynamic")

        elseif btnui:isHovered("menu2") then
            player.obj.body:setPosition(ww/2, wh/2)
            self.atMenu = "intro"
        end

    elseif self.atMenu == "lose" then
        if btnui:isHovered("menu1") then -- Retry
            btnui:refresh()
            player.lost = false
            player.obj.body:setAngle(0)
            player.obj.body:setAngularVelocity(0)
            player.obj.body:setPosition(ww/2, wh/2)
            hitw.obsTop.body:setX(-hitw.obsTop.width)
            hitw.obsDown.body:setX(-hitw.obsDown.width)

            self.atMenu = "play"
        elseif btnui:isHovered("menu2") then -- Main Menu
            player.obj.body:setPosition(ww/2, wh/2)
            self.atMenu = "intro"
        end
    end

end

function Menus:draw()
    for id, object in pairs(btnui.buttons) do
        love.graphics.setColor(254, 1, 1, 0.5)
        love.graphics.draw(self.img, object.x, object.y, 0, object.width, object.height)
    end
    love.graphics.setColor(1, 1, 1)

    if self.atMenu == "store" then
        love.graphics.draw(self.img, 7*ww/10, wh/2, math.sin(ticker*2)*0.3, 250, 250, self.img:getWidth()/2, self.img:getHeight()/2)
    end
end