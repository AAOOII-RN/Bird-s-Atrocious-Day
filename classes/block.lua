Block = Object:extend()

function Block:new()
    self.img = love.graphics.newImage("img/zero.png")
    self.blocks = {}
    self.obstaclesMap = {
        {1, 1, 0, 0, 1, 1, 1, 1},
        {1, 1, 1, 0, 1, 1, 1, 0},
        {1, 0, 1, 1, 1, 0, 1, 1},
        {0, 1, 0, 1, 1, 1, 0, 1},
        {1, 1, 1, 1, 0, 1, 0, 1},
        {1, 0, 1, 0, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 0, 1, 1},
        {1, 0, 1, 0, 1, 0, 1, 1},
        {1, 0, 1, 1, 1, 1, 0, 1},
    }
    self.obstacles = self.obstaclesMap[math.random(1, #self.obstaclesMap)]
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

function Block:update(dt)
    for i, box in ipairs(self.obstacles) do
        if box == 1 then
            self.blocks[i].body:setY(i * self.blocks[i].height - self.blocks[i].height/2)
        else
            self.blocks[i].body:setY(1024) -- arbitrary number
        end

        self.blocks[i].body:setX(LERP(ww+self.blocks[i].width, -self.blocks[i].width,   (math.sin(ticker-math.pi/2)+1)/2))

        if math.floor((self.blocks[i].body:getX() + self.blocks[i].width)*64) == 0 or math.floor((ww+self.blocks[i].width - self.blocks[i].body:getX())*64) == 0 then -- Idfk how this works again
            self.obstacles = self.obstaclesMap[math.random(1, #self.obstaclesMap)]
        end 
    end
end

function Block:draw()
    for i = 1, #self.blocks do
        if not self.blocks[i].invisible then
            love.graphics.setColor(1, 72/255, 101/255)
            love.graphics.draw(self.img, self.blocks[i].body:getX(), self.blocks[i].body:getY(), self.blocks[i].body:getAngle(), self.blocks[i].width, self.blocks[i].height, self.img:getWidth()/2, self.img:getHeight()/2)
        end
    end
end