Menus = Object:extend()

function Menus:new()
    -- List of Menus
    -- 1. Intro 

    self.atMenu = "intro"
    for i = 1, 3 do
        btnui:createButton(i) -- What if I use pooling?
    end
end

function Menus:update(dt)
    if self.atMenu == "intro" then
        for i = 1, 3 do
            btnui:editButton(i, ww/7, i*wh/5 - 47.5, 150, 75, true) -- Play
        end
    end
end

function Menus:mousepressed()
    if btnui:isHovered(1) then
        print("clicked!")
        self.atMenu = "play"
        for i = 1, 3 do
            btnui:editButton(i, 0, 0, 0, 0, false)
        end
    end
end