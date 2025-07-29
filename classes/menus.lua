Menus = Object:extend()

function Menus:new()
    -- List of Menus
    -- 1. Intro

    -- What if I use pooling?
    btnui:writeButton(1)
end

function Menus:intro()
    btnui:writeButton(1, ww/2 - 100, wh/2 - 100, 100, 100)
end