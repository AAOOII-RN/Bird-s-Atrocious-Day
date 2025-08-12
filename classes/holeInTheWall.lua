HITW = Object:extend()
-- RIP holeInTheWall_OLD.lua, you will be missed despite of your hideous flaws...

function HITW:new()
    self.img = love.graphics.newImage("img/zero.png")

    self.speed = math.random(300, 600)
    self.space = math.random(38, 100)
    self.spacePos = math.random(self.space, wh-self.space)

    self.obsTop = block:newBlock("obstacle_top", -100, wh, 100, wh)
    self.obsDown = block:newBlock("obstacle_bottom", -100, 0, 100, wh)
    self.obsTop.body:setFixedRotation(true)
    self.obsDown.body:setFixedRotation(true)
end

function HITW:update(dt)
    if menus.atMenu == "play" then
        self.obsTop.body:setLinearVelocity(self.speed, 0)
        self.obsDown.body:setLinearVelocity(self.speed, 0)
        self.obsTop.body:setY(self.spacePos - self.obsTop.height/2 - self.space)
        self.obsDown.body:setY(self.spacePos + self.obsDown.height/2 + self.space)
    
        if self.obsTop.body:getX() - self.obsTop.width/2 >= ww then
            self.speed = -math.random(300, 500)
            self.space = math.random(38, 100)
            self.spacePos = math.random(0, wh)
        elseif self.obsTop.body:getX() + self.obsTop.width/2 <= 0 then
            self.speed = math.random(300, 500)
            self.space = math.random(38, 100)
            self.spacePos = math.random(self.space, wh-self.space)
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
        if string.match(id, "obstacle") then
            if not object.body:isDestroyed() then
                love.graphics.setColor(62/255, 186/255, 73/255)
                love.graphics.draw(self.img, object.body:getX(), object.body:getY(), object.body:getAngle(), object.width, object.height, self.img:getWidth()/2, self.img:getHeight()/2)
                love.graphics.draw(self.img, self.obsTop.body:getX(), self.obsTop.body:getY()+self.obsTop.height/2-25, self.obsTop.body:getAngle(), self.obsTop.width*1.5, 50, self.img:getWidth()/2, self.img:getHeight()/2)
                love.graphics.draw(self.img, self.obsDown.body:getX(), self.obsDown.body:getY()-self.obsDown.height/2+25, self.obsDown.body:getAngle(), self.obsDown.width*1.5, 50, self.img:getWidth()/2, self.img:getHeight()/2)
            end
        end
    end
    love.graphics.setColor(1, 1, 1)
end