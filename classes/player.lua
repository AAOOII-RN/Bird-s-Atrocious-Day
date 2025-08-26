Player = Object:extend()

function Player:new()
    -- PLAYER PROPERTIES
    self.img = love.graphics.newImage("img/zero.png")

    -- PLAYER PHYSICS BODY
    self.obj = block:newBlock("Player", ww/2, wh/2, 33, 33, "dynamic")

    self.lost = false
    self.loopInWindow = false
end

function Player:update(dt)
    self.pvx, self.pvy = self.obj.body:getLinearVelocity()
    if menus.atMenu == "intro" then
        self.loopInWindow = true
        self.obj.body:setType("dynamic")
        if self.obj.body:getY() + self.obj.width/2 <= 0 then
            self.obj.body:setY(wh-self.obj.height)
        elseif self.obj.body:getY() - self.obj.width/2 >= wh then
            self.obj.body:setY(self.obj.height)
        end
    end
    if menus.atMenu == "pause" then
        self.obj.body:setType("static")
    end
    if menus.atMenu == "play" then
        self.obj.body:setType("dynamic")

        if self.obj.body:getX() - self.obj.width/2 >= ww or self.obj.body:getX() + self.obj.width/2 <= 0 then
            self.lost = true
            self.obj.body:setType("static")
            menus.atMenu = "lose"
        end
        if self.obj.body:getY() + self.obj.width/2 <= wh/10 then
            self.obj.body:setY(9*wh/10-self.obj.height)
        elseif self.obj.body:getY() - self.obj.width/2 >= 9*wh/10 then
            self.obj.body:setY(wh/10 + self.obj.height)
        end
    end
    if self.loopInWindow then
        if self.obj.body:getX() + self.obj.width/2 <= 0 then
            self.obj.body:setX(ww-self.obj.height)
        elseif self.obj.body:getX() - self.obj.width/2 >= ww then
            self.obj.body:setX(self.obj.width)
        end
    end

    if self.pvy >= 3100 then
        self.obj.body:setLinearVelocity(self.pvx, 3100)
    end
end

function Player:mousepressed()
    if menus.atMenu == "intro" then
        if btnui:isHovered("menu1") then -- Play
            self.obj.body:setPosition(ww/2, wh/2)
            self.obj.body:setAngle(0)
            self.obj.body:setAngularVelocity(0)
            self.obj.body:setLinearVelocity(0,0)
        elseif btnui:isHovered("menu2") then
            self.obj.body:setType("static")
            self.obj.body:setPosition(ww+512, wh+512)
        end

    elseif menus.atMenu == "store" then
        if btnui:isHovered("menu1") then
            self.obj.body:setType("dynamic")
            self.obj.body:setPosition(ww/2, wh/2)
        end

    elseif menus.atMenu == "play" then
        if btnui:isHovered("menu1") then -- Pause
            stored_pvx, stored_pvy = self.pvx, self.pvy
            stored_pvr = self.obj.body:getAngularVelocity()
            self.obj.body:setType("static")
        end

    elseif menus.atMenu == "paused" then
        if btnui:isHovered("menu1") then -- Resume
            self.obj.body:setType("dynamic")
            self.obj.body:setLinearVelocity(stored_pvx, stored_pvy)
            self.obj.body:setAngularVelocity(stored_pvr)

        elseif btnui:isHovered("menu2") then
            self.obj.body:setPosition(ww/2, wh/2)
        end

    elseif menus.atMenu == "lose" then
        if btnui:isHovered("menu1") then -- Retry
            self.lost = false
            self.obj.body:setAngle(0)
            self.obj.body:setAngularVelocity(0)
            self.obj.body:setPosition(ww/2, wh/2)
        elseif btnui:isHovered("menu2") then -- Main Menu
            self.obj.body:setPosition(ww/2, wh/2)
        end
    end
end

function Player:keypressed(key) -- MOVEMENT
    if key == "space" then
        self.obj.body:setLinearVelocity(0, 0) -- STOP!
        self.obj.body:setAngularVelocity(0)
        self.obj.body:applyLinearImpulse(0, -110 + math.min(self.pvy/6, 0))
        if self.pvx < 0 then
            self.obj.body:applyLinearImpulse(105, 0)
            self.obj.body:applyAngularImpulse(180)
        elseif self.pvx > 0 then
            self.obj.body:applyLinearImpulse(-105, 0)
            self.obj.body:applyAngularImpulse(-180)
        elseif self.pvx == 0 then
            if self.obj.body:getX() > ww/2 then
                self.obj.body:applyLinearImpulse(105, 0)
                self.obj.body:applyAngularImpulse(180)
            else
                self.obj.body:applyLinearImpulse(-105, 0)
                self.obj.body:applyAngularImpulse(-180)
            end
        end
    end
end

function Player:draw()
    love.graphics.setColor(rgba(221, 224, 240))
    love.graphics.draw(self.img, self.obj.body:getX(), self.obj.body:getY(), self.obj.body:getAngle(), self.obj.width, self.obj.height, self.img:getWidth()/2, self.img:getHeight()/2)

    love.graphics.setColor(1, 1, 1)
end