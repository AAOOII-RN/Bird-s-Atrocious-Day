Block = Object:extend()

function Block:new()
    self.blocks = {}
end

function Block:newBlock(id, x, y, w, h, inv, type)
    self.blocks[id] = {}
    self.blocks[id].body = love.physics.newBody(world, x, y, type)
    self.blocks[id].width = w -- Do tables decrease performance?
    self.blocks[id].height = h -- Let's pretend this function exists in Love2d :sob: :sob:
    self.blocks[id].shape = love.physics.newRectangleShape(self.blocks[id].width, self.blocks[id].height)
    self.blocks[id].fixture = love.physics.newFixture(self.blocks[id].body, self.blocks[id].shape)
    self.blocks[id].invisible = inv
end

function Block:show(t)
    table.insert(self.inv, t)
end

function Block:draw()
    for i = 1, #self.blocks do
        if not self.blocks[i].invisible then
            love.graphics.polygon("fill", self.blocks[i].body:getWorldPoints(self.blocks[i].shape:getPoints()))
        end
    end
end