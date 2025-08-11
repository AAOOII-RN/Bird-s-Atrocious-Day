Menus = Object:extend()

function Menus:new()
    -- List of Menus
    -- 1. Intro     
    -- 2. Play
    -- 3. Paused
    -- 4. Lose

    self.atMenu = "intro"
    for i = 1, 3 do
        btnui:createButton("menu" .. i) -- What if I use pooling?
    end
end

function Menus:update(dt)
    if self.atMenu == "intro" then
        self:intro(true)
    end
    if self.atMenu == "play" then
        self:play(true)
    end
    if self.atMenu == "paused" then
        self:paused(true)
    end
    if self.atMenu == "lose" then
        self:lose(true)
    end
end

function Menus:mousepressed()
    if self.atMenu == "intro" then
        self:intro(false)
    elseif self.atMenu == "play" then
        self:play(false)
    elseif self.atMenu == "paused" then
        self:paused(false)
    elseif self.atMenu == "lose" then
        
    end
end

function Menus:intro(i)
    if i then
        for i = 1, 3 do
                btnui:editButton("menu" .. i, ww/2 - 125, i*wh/4 - 62.5, 250, 125, true) -- Play
            end
            player.obj.body:setType("dynamic")
    else
        if btnui:isHovered("menu1") then -- Play
            self.atMenu = "play"
            for i = 1, 3 do
                btnui:editButton("menu" .. i, 0, 0, 0, 0, false)
            end
            player.obj.body:setPosition(ww/2, wh/2)
            player.obj.body:setLinearVelocity(0,0)
        end
        if btnui:isHovered("menu3") then -- Exit
            love.event.quit()
        end
    end
end

function Menus:play(i)
    if i then
        btnui:editButton("menu1", 9*ww/10 - 62.5, wh/10 - 62.5, 125, 125, true) -- Pause btn
        player.obj.body:setType("dynamic")
    else
        if btnui:isHovered("menu1") then -- Pause
            self.atMenu = "paused"
        end
    end
end

function Menus:paused(i)
    if i then
        btnui:editButton("menu1", ww/2-125, wh/2-62.5, 250, 125, true) -- Resume
    else
        if btnui:isHovered("menu1") then -- Resume
            self.atMenu = "play"
        end
    end
end

function Menus:lose(i)
    if i then
        btnui:editButton("menu1", ww/2 - 125, wh/3 - 62.5, 250, 125, true) -- Retry
        btnui:editButton("menu2", ww/2 - 125, 2*wh/3 - 62.5, 250, 125, true) -- Main Menu
    else
        if btnui:isHovered("menu1") then -- Retry
            btnui:editButton("menu2", 0, 0, 0, 0, false)
            player.lost = false
            player.obj.body:setPosition(ww/2, wh/2)
            hitw.ticker = 0
            self.atMenu = "play"
        end
        if btnui:isHovered("menu2") then -- Main Menu
            player.lost = true
            player.obj.body:setPosition(ww/2, wh/2)
            self.atMenu = "intro"
        end
    end
end