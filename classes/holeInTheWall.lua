HITW = Object:extend()
-- RIP holeInTheWall_OLD.lua, you will be missed despite of your hideous flaws...

function HITW:new()
    self.ticker = 0
    self.coins = {}

    self.img = love.graphics.newImage("img/zero.png")

    self.speed = math.random(200, 500)
    self.space = math.random(38, 100)
    self.spacePos = math.random(self.space, wh-self.space)

    self.hitw_score = 0

    self.obsTop = block:newBlock("obstacle_top", -100, wh, 100, wh)
    self.obsDown = block:newBlock("obstacle_bottom", -100, 0, 100, wh)
    self.obsTop.body:setFixedRotation(true)
    self.obsDown.body:setFixedRotation(true)
end

function HITW:update(dt)
    self.ticker = self.ticker + 1 * dt

    if menus.atMenu == "intro" then
        self.obsTop.body:setX(-self.obsTop.width)
        self.obsDown.body:setX(-self.obsDown.width)
    end
    if menus.atMenu == "play" then
        self.obsTop.body:setType("dynamic")
        self.obsDown.body:setType("dynamic")
        self.obsTop.body:setLinearVelocity(self.speed, 0)
        self.obsDown.body:setLinearVelocity(self.speed, 0)
        self.obsTop.body:setY(self.spacePos - self.obsTop.height/2 - self.space)
        self.obsDown.body:setY(self.spacePos + self.obsDown.height/2 + self.space)
    
        if self.obsTop.body:getX() - self.obsTop.width/2 >= ww then
            self.speed = -math.random(400, 800)
            self.space = math.random(38, 100)
            self.spacePos = math.random(0, wh)
        elseif self.obsTop.body:getX() + self.obsTop.width/2 <= 0 then
            self.speed = math.random(400, 800)
            self.space = math.random(38, 100)
            self.spacePos = math.random(self.space, wh-self.space)
        end

        -- PLAYER
        if player.obj.body:getX() - player.obj.width/2 >= ww or player.obj.body:getX() + player.obj.width/2 <= 0 then
            player.lost = true
            player.obj.body:setType("static")
            menus.atMenu = "lose"
        end
    end
    if menus.atMenu == "lose" then
        self.obsTop.body:setType("static")
        self.obsDown.body:setType("static")
    end

    if player.obj.body:getY() + player.obj.width/2 <= 0 then
        player.obj.body:setY(wh-player.obj.height)
    elseif player.obj.body:getY() - player.obj.width/2 >= wh then
        player.obj.body:setY(player.obj.width)
    end
end

function HITW:mousepressed()
    if menus.atMenu == "play" then
        if btnui:isHovered("menu1") then -- Pause
            self.obsTop.body:setType("static")
            self.obsDown.body:setType("static")
        end
    elseif menus.atMenu == "paused" then
        if btnui:isHovered("menu1") then -- Resume
            self.obsTop.body:setType("dynamic")
            self.obsDown.body:setType("dynamic")
        end
    elseif menus.atMenu == "lose" then
        if btnui:isHovered("menu1") then -- Retry
            self.obsTop.body:setX(-self.obsTop.width)
            self.obsDown.body:setX(-self.obsDown.width)
        end
    end
end

function HITW:draw()
    for id, object in pairs(block.blocks) do
        if string.match(id, "obstacle") then
            if not object.body:isDestroyed() then
                love.graphics.setColor(187/255, 52/255, 77/255)
                love.graphics.draw(self.img, object.body:getX(), object.body:getY(), object.body:getAngle(), object.width, object.height, self.img:getWidth()/2, self.img:getHeight()/2)
                love.graphics.draw(self.img, self.obsTop.body:getX(), self.obsTop.body:getY()+self.obsTop.height/2-12.5, self.obsTop.body:getAngle(), self.obsTop.width*1.25, 25, self.img:getWidth()/2, self.img:getHeight()/2)
                love.graphics.draw(self.img, self.obsDown.body:getX(), self.obsDown.body:getY()-self.obsDown.height/2+12.5, self.obsDown.body:getAngle(), self.obsDown.width*1.25, 25, self.img:getWidth()/2, self.img:getHeight()/2)
            end
        end
    end

    for id, object in pairs(self.coins) do
        love.graphics.setColor(1, 163/255, 125/255)
        love.graphics.circle("fill", object.x, object.y, object.r)
    end

    love.graphics.setColor(1, 1, 1)
end