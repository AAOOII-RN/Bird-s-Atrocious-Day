Menus = Object:extend()

function Menus:new()
    -- List of Menus
    -- 1. Intro 

    self.atMenu = "intro"
    for i = 1, 3 do
        btnui:createButton("menu" .. i) -- What if I use pooling?
    end
end

function Menus:update(dt)
    if self.atMenu == "intro" then
        for i = 1, 3 do
            btnui:editButton("menu" .. i, ww/7, i*wh/5 - 47.5, 150, 75, true) -- Play
        end
    end

    if self.atMenu == "play" then
        btnui:editButton("menu1", 9*ww/10, wh/10, 50, 50, true)
    end
end

function Menus:mousepressed()
    if self.atMenu == "intro" then
        if btnui:isHovered("menu1") then
            self.atMenu = "play"
            for i = 1, 3 do
                btnui:editButton("menu" .. i, 0, 0, 0, 0, false)
            end
            player.obj.body:setX(ww/2)
            player.obj.body:setY(wh/2)
            player.obj.body:setLinearVelocity(0,0)
        end
    end

    if self.atMenu == "play" then
        if btnui:isHovered("menu1") then
            print("click")
        end
    end
end