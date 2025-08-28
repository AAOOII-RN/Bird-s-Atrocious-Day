Block = Object:extend()

function Block:new()
    self.blocks = {}
end

function Block:newBlock(id, x, y, w, h, type)
    self.blocks[id] = {}
    self.blocks[id].body = love.physics.newBody(world, x, y, type)
    self.blocks[id].width = w -- Do tables decrease performance?
    self.blocks[id].height = h -- Let's pretend this function exists in Love2d :sob: :sob:
    self.blocks[id].shape = love.physics.newRectangleShape(self.blocks[id].width, self.blocks[id].height)
    self.blocks[id].fixture = love.physics.newFixture(self.blocks[id].body, self.blocks[id].shape)
    return self.blocks[id]
end

function Block:deleteBlock(id)
    if not self.blocks[id].body:isDestroyed() then
        self.blocks[id].body:destroy()
    end
end

function Block:refresh(filter)
    filter = filter or {0}
    for id, _ in pairs(self.blocks) do
        for _, avoid in pairs(filter) do
            if string.match(id, avoid) then
                self:newBlock(id, 0, 0, 0, 0)
            end
        end
    end
end

function Block:draw()
    for _, object in pairs(self.blocks) do
        love.graphics.setColor(0, 1, 0)
        if not object.body:isDestroyed() then      
            love.graphics.polygon("line", object.body:getWorldPoints(object.shape:getPoints()))
        end
    end
end