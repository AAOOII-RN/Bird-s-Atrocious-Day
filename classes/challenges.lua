Challenges = Object:extend()
-- Here lies holeInTheWall_OLD.lua, you will be missed despite of your hideous flaws...
-- RIP holeInTheWall.lua, you'll be replaced, but your legacy will live on...

function Challenges:new()
    self.img = love.graphics.newImage("img/zero.png")
    self.listofChallenge = {
        "Rest",
        "Pushers",
        "Meteorite",
        "Stove",
        "Beam",
    }
    self.currentChallenge = "Rest"

    self.marginY = wh/10
    for i = 0, 2 do
        block:newBlock("margin" .. i, i*ww, -512, 20, 20)
    end

    stored_velocity = {}
    restInterval = 5
    challengeInterval = 0
    pushersVelocityLerp = 0

    self.stoveCircles = {} -- {x, y, r, time}
end

function Challenges:update(dt)
    if menus.atMenu == "intro" then
        for i = 0, 2 do
            block.blocks["margin" .. i].body:setY(-512)
        end
        self.marginY = lerp(self.marginY, wh/10, 0.1)

    elseif menus.atMenu == "play" then
        self.marginY = lerp(self.marginY, 0, 0.1)
        if self.currentChallenge == "Rest" then
            restInterval = restInterval - 1 * dt
            if restInterval <= 0 then
                self:prepareChallenge()
            end
        elseif self.currentChallenge == "Pushers" then
            challengeInterval = challengeInterval - 1 * dt
            for i = 0, 2 do
                block.blocks["margin" .. i].body:setY(2*wh/30)

                pushersVelocityLerp = math.fmod(pushersVelocityLerp + 0.1 * dt, 1)
                if block.blocks["obstacle" .. i].body:getX() <= ww/2 then -- ignore flexibility, i suppose this would make it faster than getting their widths
                    block.blocks["obstacle" .. i].body:setLinearVelocity(0,0) -- even nothing (0) can contribute to the better
                    block.blocks["obstacle" .. i].body:setX(ww/2)
                    block.blocks["obstacle" .. i].body:setType("static")
                else
                    block.blocks["obstacle" .. i].body:setType("dynamic")
                    block.blocks["obstacle" .. i].body:setFixedRotation(true)
                    block.blocks["obstacle" .. i].body:setLinearVelocity(lerp(-ww-(i*100), ww/3+(i*100), funnystep(pushersVelocityLerp)),0)
                end
            end
            block.blocks["obstacle0"].body:setY(wh/10 + (2+4*self.obstacle0y)*(wh/5)/4)
            block.blocks["obstacle1"].body:setY(wh/10 + (2+4*self.obstacle1y)*(wh/5)/4)
            block.blocks["obstacle2"].body:setY(wh/10 + (2+4*self.obstacle2y)*(wh/5)/4)

            if challengeInterval <= 0 then
                self:resetChallenge()
            end

        elseif self.currentChallenge == "Meteorite" then
            challengeInterval = challengeInterval - 1 * dt
            for i = 0, 8 do
                if block.blocks["obstacle" .. i].body:getY() >= wh + block.blocks["obstacle" .. i].width/2 then
                    block.blocks["obstacle" .. i].body:setLinearVelocity((math.fmod(i,2)*2-1)*1800, -1200)
                    block.blocks["obstacle" .. i].body:setAngularVelocity((math.fmod(i,2)*2-1)*math.pi*8)
                elseif block.blocks["obstacle" .. i].body:getY() <= -block.blocks["obstacle" .. i].width/2 then
                    block.blocks["obstacle" .. i].body:setLinearVelocity(0, 0)
                end

                if block.blocks["obstacle" .. i].body:getX() <= -block.blocks["obstacle" .. i].width/2 then
                    block.blocks["obstacle" .. i].body:setX(ww + block.blocks["obstacle" .. i].width/2)
                elseif block.blocks["obstacle" .. i].body:getX() >= ww + block.blocks["obstacle" .. i].width/2 then
                    block.blocks["obstacle" .. i].body:setX(-block.blocks["obstacle" .. i].width/2)
                end
            end
            if challengeInterval <= 0 then
                self:resetChallenge()
            end
        elseif self.currentChallenge == "Stove" then
            challengeInterval = challengeInterval - 1 * dt
            if math.random() >= 0.99 then
                self.stoveCircles[#self.stoveCircles+1] = {
                    math.min(math.max(player.obj.body:getX() + player.pvx/2, 50), ww-50), 
                    math.min(math.max(player.obj.body:getY() + player.pvy/2, wh/10+50), 9*wh/10-50),
                    50, 1}
            end
            for i, circle in pairs(self.stoveCircles) do
                circle[3] = circle[3] + 75 * dt
                circle[4] = circle[4] - 1 * dt
                if circle[4] <= 0 then
                    table.remove(self.stoveCircles, i)
                    if insideCircle(circle[1], circle[2], circle[3], player.obj.body:getX(), player.obj.body:getY()) then
                        menus.atMenu = "lose"
                    end
                end
            end
        end

    elseif menus.atMenu == "paused" then
        --

    elseif menus.atMenu == "lose" then
        for id, obj in pairs(block.blocks) do
            if string.match(id, "obstacle") then
                obj.body:setType("static")
            end
        end
    end

end

function Challenges:prepareChallenge()
    restInterval = 5
    for id, _ in pairs(block.blocks) do
        if string.match(id, "obstacle") then
            block:deleteBlock(id)
        end
    end

    --self.currentChallenge = self.listofChallenge[math.random(2, #self.listofChallenge)]
    self.currentChallenge = self.listofChallenge[4]

    if self.currentChallenge == "Pushers" then
        challengeInterval = 8
        pushersVelocityLerp = 0
        self.obstacle0y = math.random(0, 3)
        repeat
            self.obstacle1y = math.random(0, 3)
            self.obstacle2y = math.random(0, 3)
        until self.obstacle0y ~= self.obstacle1y and self.obstacle1y ~= self.obstacle2y and self.obstacle2y ~= self.obstacle0y -- love triangle <3
        block:newBlock("obstacle0", ww+ww/2, wh/10 + (2+4*self.obstacle0y)*(wh/5)/4, ww, (wh-wh/5)/4) -- did this with trial and error (no critical thinking ;-;) (I hate meself)
        block:newBlock("obstacle1", ww+ww/2, wh/10 + (2+4*self.obstacle1y)*(wh/5)/4, ww, (wh-wh/5)/4) -- "If it works, don't touch it" ;-;
        block:newBlock("obstacle2", ww+ww/2, wh/10 + (2+4*self.obstacle2y)*(wh/5)/4, ww, (wh-wh/5)/4)

    elseif self.currentChallenge == "Meteorite" then
        challengeInterval = 30
        for i = 0, 8 do
            block:newBlock("obstacle" .. i, (i+1)*ww/10, -50, 175, 25, "dynamic")
        end
    elseif self.currentChallenge == "Stove" then
        challengeInterval = 30 
    elseif self.currentChallenge == "Beam" then
        -- to be implemented
    end
end

function Challenges:resetChallenge()
    challenges.currentChallenge = "Rest"
    for id, _ in pairs(block.blocks) do
        if string.match(id, "obstacle") then
            block:deleteBlock(id)
        end
    end
    for id, obj in pairs(self.stoveCircles) do
        self.stoveCircles[id] = nil
    end
end

function Challenges:mousepressed()
    if menus.atMenu == "paused" then
        if btnui:isHovered("menu1") then
            for id, obj in pairs(block.blocks) do
                if string.match(id, "obstacle") then
                    obj.body:setType("dynamic")
                    if stored_velocity[id] then
                        obj.body:setLinearVelocity(stored_velocity[id][1], stored_velocity[id][2])
                        obj.body:setAngularVelocity(stored_velocity[id][3])
                    end
                    stored_velocity[id] = nil
                end
            end
        elseif btnui:isHovered("menu2") then
            self:resetChallenge()
        end
    elseif menus.atMenu == "lose" then
        if btnui:isHovered("menu1") then
            self:resetChallenge()
        elseif btnui:isHovered("menu2") then
            self:resetChallenge()
        end
    elseif menus.atMenu == "intro" then
        if btnui:isHovered("menu1") then
            self:resetChallenge()
        end
    elseif menus.atMenu == "play" then
        if btnui:isHovered("menu1") then
            for id, obj in pairs(block.blocks) do
                if string.match(id, "obstacle") then
                    stored_velocity[id] = {obj.body:getLinearVelocity()}
                    stored_velocity[id][3] = obj.body:getAngularVelocity()
                    obj.body:setType("static")
                end
            end
        end
    end
end

function Challenges:draw()
    love.graphics.setColor(rgba(26, 26, 37))
    love.graphics.draw(self.img, 0, -self.marginY, 0, ww, wh/10)
    love.graphics.draw(self.img, 0, 9*wh/10+self.marginY, 0, ww, wh/10)
    for id, object in pairs(block.blocks) do
        if string.match(id, "obstacle") then
            if not object.body:isDestroyed() then
                love.graphics.draw(
                self.img, 
                object.body:getX(), object.body:getY(), 
                object.body:getAngle(), 
                object.width, object.height, 
                self.img:getWidth()/2, self.img:getHeight()/2
            )
            end
        end
    end
    for i, circle in ipairs(self.stoveCircles) do
        if circle then
            love.graphics.setColor(rgba(26, 26, 37, (3-circle[4])*0.33))
            love.graphics.circle("fill", circle[1], circle[2], circle[3])
        end
    end

    love.graphics.setColor(1, 1, 1)
end