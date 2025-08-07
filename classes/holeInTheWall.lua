HITW = Object:extend()

function HITW:new()
    self.img = love.graphics.newImage("img/zero.png")
    self.ticker = 0
    self.space = 50
    self.spacePos = wh/2
    self.obsTop = block:newBlock("obstacle_top", 100, wh/2, 100, wh)
    self.obsDown = block:newBlock("obstacle_bottom", 100, wh/2, 100, wh)
end

function HITW:update(dt)
    self.ticker = self.ticker + 1 * dt
    self.spacePos = LERP(self.space, wh-self.space, math.sin(self.ticker)*math.sin(self.ticker))
    self.obsTop.body:setY(self.spacePos - self.obsTop.height/2 - self.space)
    self.obsDown.body:setY(self.spacePos + self.obsDown.height/2 + self.space)
end

function HITW:draw()
    
end