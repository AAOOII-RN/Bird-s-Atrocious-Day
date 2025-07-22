Block = Object:extend()

function Block:new()
    self.blocks = {}
end

function Block:newBlock(id, x, y, w, h)
    self.blocks[id] = {}
    self.blocks[id].body = love.physics.newBody(world, x, y, "static")
    self.blocks[id].shape = love.physics.newRectangleShape(w, h)
    self.blocks[id].fixture = love.physics.newFixture(self.blocks[id].body, self.blocks[id].shape)
end

function Block:draw()
    for i = 1, #self.blocks do
        love.graphics.polygon("fill", self.blocks[i].body:getWorldPoints(self.blocks[i].shape:getPoints()))
    end
end