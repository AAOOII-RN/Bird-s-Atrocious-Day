Player = Object:extend()

function Player:new()
    -- PLAYER PROPERTIES
    self.speed = 250

    -- PLAYER PHYSICS BODY
    self.shape = love.physics.newRectangleShape(50, 50)
    self.body = love.physics.newBody(world, ww/2, wh/2, "dynamic")
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.goRight = true
end

function Player:update(dt)
    local pvx, pvy = self.body:getLinearVelocity()
    function love.keypressed(key) -- Are stacked functions illegal? I feel like they are.
        if key == "w" then
            self.body:setLinearVelocity(0, 0) -- STOP!
            self.body:applyLinearImpulse(0, -240)

            if self.goRight then
                self.body:applyLinearImpulse(120, 0)
                self.goRight = false
            elseif not self.goRight then
                self.body:applyLinearImpulse(-120, 0)
                self.goRight = true
            end
        end
    end
end

function Player:draw()
    love.graphics.setColor(0, 0.5, 0.5)
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))

    love.graphics.setColor(1, 1, 1)
end