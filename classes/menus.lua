Menus = Object:extend()

function Menus:new()
    -- List of Menus
    -- 1. Intro     
    -- 2. Play
    -- 3. Paused
    -- 4. Lose
    self.img = love.graphics.newImage("img/zero.png")
    self.atMenu = "intro"
    for i = 1, 3 do
        btnui:createButton("menu" .. i) -- What if I use pooling?
    end
end

function Menus:update(dt)
    if self.atMenu == "intro" then
        for i = 1, 3 do
                btnui:editButton("menu" .. i, ww/2 - 125, i*wh/4 - 62.5, 250, 125, true) -- Play
            end
            player.obj.body:setType("dynamic")
            hitw.obsTop.body:setX(-hitw.obsTop.width)
            hitw.obsDown.body:setX(-hitw.obsDown.width)
    end

    if self.atMenu == "play" then
        btnui:editButton("menu1", 9*ww/10 - 62.5, wh/10 - 62.5, 125, 125, true) -- Pause btn
        player.obj.body:setType("dynamic")
        hitw.obsTop.body:setType("dynamic")
        hitw.obsDown.body:setType("dynamic")
    end

    if self.atMenu == "paused" then
        btnui:editButton("menu1", ww/2-125, wh/3-62.5, 250, 125, true) -- Resume
        btnui:editButton("menu2", ww/2-125, 2*wh/3-62.5, 250, 125, true) -- Main Menu
    end

    if self.atMenu == "lose" then
        btnui:editButton("menu1", ww/2 - 125, wh/3 - 62.5, 250, 125, true) -- Retry
        btnui:editButton("menu2", ww/2 - 125, 2*wh/3 - 62.5, 250, 125, true) -- Main Menu
        hitw.obsTop.body:setType("static")
        hitw.obsDown.body:setType("static")
    end
end

function Menus:mousepressed()
    if self.atMenu == "intro" then
        if btnui:isHovered("menu1") then -- Play
            self.atMenu = "play"
            for i = 1, 3 do
                btnui:editButton("menu" .. i, 0, 0, 0, 0, false)
            end
            player.obj.body:setPosition(ww/2, wh/2)
            player.obj.body:setAngle(0)
            player.obj.body:setAngularVelocity(0)
            player.obj.body:setLinearVelocity(0,0)
        elseif btnui:isHovered("menu3") then -- Exit
            love.event.quit()
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
            self.atMenu = "play"
            btnui:editButton("menu2", 0, 0, 0, 0, false)
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
            btnui:editButton("menu2", 0, 0, 0, 0, false)
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
end