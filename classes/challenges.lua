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
    restInterval = 5
    pushersVelocityLerp = 0
end

function Challenges:update(dt)
    if menus.atMenu == "intro" then
        for i = 0, 2 do
            block.blocks["margin" .. i].body:setY(-512)
        end
        self.marginY = lerp(self.marginY, wh/10, 0.1)
    elseif menus.atMenu == "play" then
        for i = 0, 2 do
            block.blocks["margin" .. i].body:setY(2*wh/30)
        end
        self.marginY = lerp(self.marginY, 0, 0.1)

        if self.currentChallenge == "Rest" then
            restInterval = restInterval - 1 * dt
            if restInterval <= 0 then
                self:prepareChallenge()
            end
        elseif self.currentChallenge == "Pushers" then
            for i = 0, 2 do
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
        end
    elseif menus.atMenu == "paused" then
        for i = 0, 2 do
            if block.blocks["obstacle" .. i] then
                block.blocks["obstacle" .. i].body:setType("static")
                block.blocks["obstacle0"].body:setY(wh/10 + (2+4*self.obstacle0y)*(wh/5)/4)
                block.blocks["obstacle1"].body:setY(wh/10 + (2+4*self.obstacle1y)*(wh/5)/4)
                block.blocks["obstacle2"].body:setY(wh/10 + (2+4*self.obstacle2y)*(wh/5)/4)
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
    self.currentChallenge = self.listofChallenge[2]
    if self.currentChallenge == "Pushers" then
        pushersVelocityLerp = 0
        self.obstacle0y = math.random(0, 3)
        repeat
            self.obstacle1y = math.random(0, 3)
            self.obstacle2y = math.random(0, 3)
        until self.obstacle0y ~= self.obstacle1y and self.obstacle1y ~= self.obstacle2y and self.obstacle2y ~= self.obstacle0y -- love triangle <3
        block:newBlock("obstacle0", ww+ww/2, wh/10 + (2+4*self.obstacle0y)*(wh/5)/4, ww, (wh-wh/5)/4) -- did this with trial and error (no critical thinking ;-;) (I hate meself)
        block:newBlock("obstacle1", ww+ww/2, wh/10 + (2+4*self.obstacle1y)*(wh/5)/4, ww, (wh-wh/5)/4) -- "If it works, don't touch it" ;-;
        block:newBlock("obstacle2", ww+ww/2, wh/10 + (2+4*self.obstacle2y)*(wh/5)/4, ww, (wh-wh/5)/4)
    end
end

local function resetChallenge()
    challenges.currentChallenge = "Rest"
    for id, _ in pairs(block.blocks) do
        if string.match(id, "obstacle") then
            block:deleteBlock(id)
        end
    end
end
function Challenges:mousepressed()
    if menus.atMenu == "paused" then
        if btnui:isHovered("menu2") then
            resetChallenge()
        end
    elseif menus.atMenu == "lose" then
        if btnui:isHovered("menu1") then
            resetChallenge()
        elseif btnui:isHovered("menu2") then
            resetChallenge()
        end
    elseif menus.atMenu == "intro" then
        if btnui:isHovered("menu1") then
            resetChallenge()
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

    love.graphics.setColor(1, 1, 1)
end