Menus = Object:extend()

function Menus:new()
    -- List of Menus
    -- 1. Intro     
    -- 2. Play
    -- 3. Paused

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
    end
    if self.atMenu == "play" then
        btnui:editButton("menu1", 9*ww/10 - 62.5, wh/10 - 62.5, 125, 125, true)
        player.obj.body:setType("dynamic")
    end
    if self.atMenu == "paused" then
        btnui:editButton("menu1", ww/2-125, wh/2-62.5, 250, 125, true)
    end
    if self.atMenu == "lose" then
        btnui:editButton("menu1", ww/2 - 125, wh/3 - 62.5, 250, 125, true)
        btnui:editButton("menu2", ww/2 - 125, 2*wh/3 - 62.5, 250, 125, true)
    end
end

function Menus:mousepressed()
    if self.atMenu == "intro" then
        if btnui:isHovered("menu1") then
            self.atMenu = "play"
            for i = 1, 3 do
                btnui:editButton("menu" .. i, 0, 0, 0, 0, false)
            end
            player.obj.body:setPosition(ww/2, wh/2)
            player.obj.body:setLinearVelocity(0,0)
        end
        if btnui:isHovered("menu3") then
            love.event.quit()
        end
    elseif self.atMenu == "play" then
        if btnui:isHovered("menu1") then
            self.atMenu = "paused"
        end
    elseif self.atMenu == "paused" then
        if btnui:isHovered("menu1") then
            self.atMenu = "play"
        end
    elseif self.atMenu == "lose" then
        if btnui:isHovered("menu1") then
            btnui:editButton("menu2", 0, 0, 0, 0, false)
            player.lost = false
            player.obj.body:setPosition(ww/2, wh/2)
            hitw.ticker = 0
            self.atMenu = "play"
        end
        if btnui:isHovered("menu2") then
            player.lost = true
            player.obj.body:setPosition(ww/2, wh/2)
            hitw.obstacles = {0, 0, 0, 0, 0, 0, 0, 0}
            self.atMenu = "intro"
        end
    end
end