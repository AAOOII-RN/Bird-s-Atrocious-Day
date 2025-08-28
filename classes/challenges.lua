Challenges = Object:extend()
-- Here lies holeInTheWall_OLD.lua, you will be missed despite of your hideous flaws...
-- RIP holeInTheWall.lua, you'll be replaced, but your legacy will live on...

function Challenges:new()
    self.img = love.graphics.newImage("img/zero.png")
    self.listofChallenge = {
        "Rest",
        "Pushers",
        "Meteorite",
        "Stove",
        "Beam",
    }
    self.currentChallenge = "Rest"

    self.marginY = wh/10
    
    for i = 0, 15 do
        block:newBlock("obstacle" .. i, 0, 0, 100, 100)
    end
end

function Challenges:update(dt)
    if menus.atMenu == "intro" then
        self.marginY = lerp(self.marginY, wh/10, 0.1)
    elseif menus.atMenu == "play" then
        self.marginY = lerp(self.marginY, 0, 0.1)

        if self.currentChallenge == "Rest" then
            self:prepareChallenge()
        elseif self.currentChallenge == "Pushers" then
            -- Hi
        end
    end

end

function Challenges:prepareChallenge()
    self.currentChallenge = self.listofChallenge[2]
    if self.currentChallenge == "Pushers" then
        local a = math.random(0, 3)
        local b
        repeat
            b = math.random(0, 3)
        until b ~= a
        block:newBlock("obstacle0", ww, wh/10 + (2+4*a)*wh/20, ww, (wh-wh/5)/4) -- did this with trial and error (no critical thinking ;-;) (I hate meself)
        block:newBlock("obstacle1", ww, wh/10 + (2+4*b)*wh/20, ww, (wh-wh/5)/4)
    end
end

function Challenges:mousepressed()
    
end

function Challenges:draw()
    love.graphics.setColor(rgba(26, 26, 37))
    love.graphics.draw(self.img, 0, -self.marginY, 0, ww, wh/10)
    love.graphics.draw(self.img, 0, 9*wh/10+self.marginY, 0, ww, wh/10)

    love.graphics.setColor(1, 1, 1)
end