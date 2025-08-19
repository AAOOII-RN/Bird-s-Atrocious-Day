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
    pvx, pvy = self.obj.body:getLinearVelocity()
    if menus.atMenu == "intro" then
        self.loopInWindow = true
        self.obj.body:setType("dynamic")
    end
    if menus.atMenu == "pause" then
        self.obj.body:setType("static")
    end
    if menus.atMenu == "play" then
        player.obj.body:setType("dynamic")
    end
    if self.loopInWindow then
        if self.obj.body:getX() + self.obj.width/2 <= 0 then
            self.obj.body:setX(ww-self.obj.height)
        elseif self.obj.body:getX() - self.obj.width/2 >= ww then
            self.obj.body:setX(self.obj.width)
        end
    end

    if pvy >= 3100 then
        self.obj.body:setLinearVelocity(pvx, 3100)
    end
end

function Player:keypressed(key) -- MOVEMENT
    if key == "space" then
        self.obj.body:setLinearVelocity(0, 0) -- STOP!
        self.obj.body:setAngularVelocity(0)
        self.obj.body:applyLinearImpulse(0, -110)
        if pvx < 0 then
            self.obj.body:applyLinearImpulse(105, 0)
            self.obj.body:applyAngularImpulse(180)
        elseif pvx > 0 then
            self.obj.body:applyLinearImpulse(-105, 0)
            self.obj.body:applyAngularImpulse(-180)
        elseif pvx == 0 then
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
    love.graphics.setColor(1, 205/255, 0)
    love.graphics.draw(self.img, self.obj.body:getX(), self.obj.body:getY(), self.obj.body:getAngle(), self.obj.width, self.obj.height, self.img:getWidth()/2, self.img:getHeight()/2)

    love.graphics.setColor(1, 1, 1)
end