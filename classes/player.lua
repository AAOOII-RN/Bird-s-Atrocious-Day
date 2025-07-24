Player = Object:extend()

function Player:new()
    -- PLAYER PROPERTIES
    self.img = love.graphics.newImage("img/zero.png")

    -- PLAYER PHYSICS BODY
    self.size = 22
    self.shape = love.physics.newRectangleShape(self.size, self.size)
    self.body = love.physics.newBody(world, ww/2, wh/2, "dynamic")
    self.fixture = love.physics.newFixture(self.body, self.shape)

    self.fixture:setFriction(1)
    self.goRight = true
    self.lost = false
end

function Player:update(dt)
    function love.keypressed(key) -- Are stacked functions illegal? I feel like they are.
        if key == "space" then
            self.body:setLinearVelocity(0, 0) -- STOP!
            self.body:setAngularVelocity(0)
            self.body:applyLinearImpulse(0, -40)

            if self.goRight then
                self.body:applyLinearImpulse(30, 0)
                self.body:applyAngularImpulse(45)
                self.goRight = false
            elseif not self.goRight then
                self.body:applyLinearImpulse(-30, 0)
                self.body:applyAngularImpulse(-45)
                self.goRight = true
            end
        end
    end

    if self.body:getX() - self.size/2 >= ww or self.body:getX() + self.size/2 <= 0 then
        self.lost = true
        self.body:setType("static")
    end

    if self.body:getY() + self.size/2 <= 0 then
        self.body:setY(wh-self.size)
    elseif self.body:getY() - self.size/2 >= wh then
        self.body:setY(self.size)
    end

    local px, py = self.body:getLinearVelocity()
    print(py)
    if py >= 3100 then
        self.body:setLinearVelocity(px, 3100)
    end
end

function Player:draw()
    love.graphics.setColor(1, 205/255, 0)
    love.graphics.draw(self.img, self.body:getX(), self.body:getY(), self.body:getAngle(), self.size, self.size, self.img:getWidth()/2, self.img:getHeight()/2)

    love.graphics.setColor(1, 1, 1)
end