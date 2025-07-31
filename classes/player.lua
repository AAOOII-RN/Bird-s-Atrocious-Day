Player = Object:extend()

function Player:new()
    -- PLAYER PROPERTIES
    self.img = love.graphics.newImage("img/zero.png")

    -- PLAYER PHYSICS BODY
    block:newBlock("Player", ww/2, wh/2, 22, 22, "dynamic")
    self.obj = block.blocks["Player"]

    self.goRight = true
    self.lost = false
end

function Player:update(dt)
    -- MOVEMENT
    function love.keypressed(key) -- Are stacked functions illegal? I feel like they are.
        if key == "space" then
            self.obj.body:setLinearVelocity(0, 0) -- STOP!
            self.obj.body:setAngularVelocity(0)
            self.obj.body:applyLinearImpulse(0, -40)

            if self.goRight then
                self.obj.body:applyLinearImpulse(30, 0)
                self.obj.body:applyAngularImpulse(45)
                self.goRight = false
            elseif not self.goRight then
                self.obj.body:applyLinearImpulse(-30, 0)
                self.obj.body:applyAngularImpulse(-45)
                self.goRight = true
            end
        end
    end

    local px, py = self.obj.body:getLinearVelocity()
    if py >= 3100 then
        self.obj.body:setLinearVelocity(px, 3100)
    end
end

function Player:draw()
    love.graphics.setColor(1, 205/255, 0)
    love.graphics.draw(self.img, self.obj.body:getX(), self.obj.body:getY(), self.obj.body:getAngle(), self.obj.width, self.obj.height, self.img:getWidth()/2, self.img:getHeight()/2)

    love.graphics.setColor(1, 1, 1)
end