Player = Object:extend()

function Player:new()
    -- PLAYER PROPERTIES
    self.speed = 250
    self.img = love.graphics.newImage("img/zero.png")

    -- PLAYER PHYSICS BODY
    self.size = 22
    self.shape = love.physics.newRectangleShape(self.size, self.size)
    self.body = love.physics.newBody(world, ww/2, wh/2, "dynamic")
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.goRight = true
end

function Player:update(dt)
    function love.keypressed(key) -- Are stacked functions illegal? I feel like they are.
        if key == "space" then
            self.body:setLinearVelocity(0, 0) -- STOP!
            self.body:setAngularVelocity(0)
            self.body:applyLinearImpulse(0, -30)

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
end

function Player:draw()
    love.graphics.setColor(0, 0.5, 0.5)
    love.graphics.draw(self.img, self.body:getX(), self.body:getY(), self.body:getAngle(), self.size, self.size, self.img:getWidth()/2, self.img:getHeight()/2)

    love.graphics.setColor(1, 1, 1)
end