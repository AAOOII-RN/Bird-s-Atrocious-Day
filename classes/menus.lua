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
    player.loopInWindow = false

    if self.atMenu == "intro" then
        player.loopInWindow = true
        for i = 1, 4 do
            btnui:editButton("menu" .. i, i*ww/5 - 125, 5*wh/6 - 62.5, 250, 125, true) -- Play
        end
        bg_color = lerp_colors(bg_color, rgba(245, 171, 160), 0.1)

    elseif self.atMenu == "store" then
        for i = 1, 5 do
            btnui:editButton("store" .. i, ww/5 - 125, i*wh/6 - 62.5, 250, 125, true) -- Store items
        end
        btnui:editButton("menu1", 9*ww/10 - 62.5, wh/10 - 62.5, 125, 125, true) -- Back btn
        bg_color = lerp_colors(bg_color, rgba(255, 163, 125), 0.1)

    elseif self.atMenu == "play" then
        btnui:editButton("menu1", 9*ww/10 - 62.5, wh/10 - 62.5, 125, 125, true) -- Pause btn
        bg_color = lerp_colors(bg_color, rgba(137, 107, 214), 0.1)

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
        elseif btnui:isHovered("menu2") then
            btnui:refresh()
            self.atMenu = "store"
        elseif btnui:isHovered("menu4") then -- Exit
            love.event.quit()
        end

    elseif self.atMenu == "store" then
        if btnui:isHovered("menu1") then
            btnui:refresh()
            self.atMenu = "intro"
        end

    elseif self.atMenu == "play" then
        if btnui:isHovered("menu1") then -- Pause
            self.atMenu = "paused"
        end

    elseif self.atMenu == "paused" then
        if btnui:isHovered("menu1") then -- Resume
            btnui:refresh()
            self.atMenu = "play"
        elseif btnui:isHovered("menu2") then
            self.atMenu = "intro"
        end

    elseif self.atMenu == "lose" then
        if btnui:isHovered("menu1") then -- Retry
            btnui:refresh()
            self.atMenu = "play"
        elseif btnui:isHovered("menu2") then -- Main Menu
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