--[[
HITW = Object:extend()

function HITW:new()
    self.img = love.graphics.newImage("img/zero.png")
    self.obstaclesMap = {
        {1, 1, 0, 0, 1, 1, 1, 1},
        {1, 1, 1, 0, 1, 1, 1, 0},
        {1, 0, 1, 1, 1, 0, 1, 1},
        {0, 1, 0, 1, 1, 1, 0, 1},
        {1, 1, 1, 1, 0, 1, 0, 1},
        {1, 0, 1, 0, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 0, 1, 1},
        {1, 0, 1, 0, 1, 0, 1, 1},
        {1, 0, 1, 1, 1, 1, 0, 1},
    }
    
    self.obstacles = self.obstaclesMap[math.random(1, #self.obstaclesMap)]

    for i = 1, #self.obstacles do
        block:newBlock("hitw_obs" .. i, ww/3, 1024, wh/#self.obstacles, wh/#self.obstacles, "dynamic")
        block.blocks["hitw_obs" .. i].body:setFixedRotation(true)
    end
end

function HITW:update(dt)
    if menus.atMenu == "play" then 
        -- OBSTACLES
        for i, box in ipairs(self.obstacles) do
            local hitw_obs = block.blocks["hitw_obs" .. i]
            if not hitw_obs.body:isDestroyed() then
                if box == 1 then
                    hitw_obs.body:setY(i * hitw_obs.height - hitw_obs.height/2)
                else
                    hitw_obs.body:setY(1024) -- arbitrary number, pooling method
                end
        
                hitw_obs.body:setLinearVelocity(600, 0)
        
                if math.floor((hitw_obs.body:getX() + hitw_obs.width)*64) == 0 or math.floor((ww+hitw_obs.width - hitw_obs.body:getX())*64) == 0 then -- Idfk how this works again
                    self.obstacles = self.obstaclesMap[math.random(1, #self.obstaclesMap)]
                    self.speedTicker = math.random(50, 300)/100 
                end 
            end
    end
    
    end

    -- PLAYER
    if menus.atMenu == "play" or menus.atMenu == "lose" then
        if player.obj.body:getX() - player.obj.width/2 >= ww or player.obj.body:getX() + player.obj.width/2 <= 0 then
            player.lost = true
            player.obj.body:setType("static")
            menus.atMenu = "lose"
        end
    else
        if player.obj.body:getX() + player.obj.width/2 <= 0 then
            player.obj.body:setX(ww-player.obj.height)
        elseif player.obj.body:getX() - player.obj.width/2 >= ww then
            player.obj.body:setX(player.obj.width)
        end
    end

    if player.obj.body:getY() + player.obj.width/2 <= 0 then
        player.obj.body:setY(wh-player.obj.height)
    elseif player.obj.body:getY() - player.obj.width/2 >= wh then
        player.obj.body:setY(player.obj.width)
    end
end

function HITW:draw()
    for id, object in pairs(block.blocks) do
        if string.match(id, "hitw_obs") then
            if not object.body:isDestroyed() then
                love.graphics.setColor(1, 72/255, 101/255)
                love.graphics.draw(self.img, object.body:getX(), object.body:getY(), object.body:getAngle(), object.width, object.height, self.img:getWidth()/2, self.img:getHeight()/2)
            end
        end
    end
    love.graphics.setColor(1, 1, 1)
end
]]