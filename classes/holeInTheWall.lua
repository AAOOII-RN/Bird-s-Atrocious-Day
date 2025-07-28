HITW = Object:extend()

function HITW:new()
    self.ticker = 0
    self.img = love.graphics.newImage("img/zero.png")
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

    for i = 1, #self.obstacles do
        block:newBlock(i, ww/3, 1024, wh/#self.obstacles, wh/#self.obstacles)
    end
end

function HITW:update(dt)
    self.ticker = self.ticker + 1 * dt
    -- OBSTACLES
    for i, box in ipairs(self.obstacles) do
        if box == 1 then
            block.blocks[i].body:setY(i * block.blocks[i].height - block.blocks[i].height/2)
        else
            block.blocks[i].body:setY(1024) -- arbitrary number
        end

        block.blocks[i].body:setX(LERP(ww+block.blocks[i].width, -block.blocks[i].width,   (math.sin(self.ticker-math.pi/2)+1)/2))

        if math.floor((block.blocks[i].body:getX() + block.blocks[i].width)*64) == 0 or math.floor((ww+block.blocks[i].width - block.blocks[i].body:getX())*64) == 0 then -- Idfk how this works again
            self.obstacles = self.obstaclesMap[math.random(1, #self.obstaclesMap)]
        end 
    end

    -- PLAYER
    if player.body:getX() - player.size/2 >= ww or player.body:getX() + player.size/2 <= 0 then
        player.lost = true
        player.body:setType("static")
    end

    if player.body:getY() + player.size/2 <= 0 then
        player.body:setY(wh-player.size)
    elseif player.body:getY() - player.size/2 >= wh then
        player.body:setY(player.size)
    end
end

function HITW:draw()
    for id, object in pairs(block.blocks) do
        if not object.body:isDestroyed() then
            love.graphics.setColor(1, 72/255, 101/255)
            love.graphics.draw(self.img, object.body:getX(), object.body:getY(), object.body:getAngle(), object.width, object.height, self.img:getWidth()/2, self.img:getHeight()/2)
        end
    end
end