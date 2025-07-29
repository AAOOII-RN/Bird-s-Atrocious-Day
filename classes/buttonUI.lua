ButtonUI = Object:extend()

function ButtonUI:new()
    self.buttons = {}
end

function ButtonUI:writeButton(id, x, y, w, h)
    x = x or 0
    y = y or 0
    w = w or 128
    h = h or 64
    self.buttons[id] = {}
    self.buttons[id].x = x
    self.buttons[id].y = y
    self.buttons[id].width = w
    self.buttons[id].height = h
    self.buttons[id].hovered = false
end

function ButtonUI:update(dt)
    mx, my = love.mouse.getPosition()

    for i = 1, #self.buttons do
        self.buttons[i].hovered = false

        if mx >= self.buttons[i].x and mx <= self.buttons[i].x + self.buttons[i].width and my >= self.buttons[i].y and my <= self.buttons[i].y + self.buttons[i].height then
            self.buttons[i].hovered = true
        end
    end
end

function ButtonUI:draw()
    love.graphics.setColor(0, 1, 0)
    for i = 1, #self.buttons do
        love.graphics.rectangle("line", self.buttons[i].x, self.buttons[i].y, self.buttons[i].width, self.buttons[i].height)
        love.graphics.print("ID: " .. i, self.buttons[i].x, self.buttons[i].y)
        love.graphics.print("Hovered: " .. tostring(self.buttons[i].hovered), self.buttons[i].x, self.buttons[i].y + self.buttons[i].height/2)
    end
    love.graphics.setColor(1, 1, 1)
end