ButtonUI = Object:extend()

function ButtonUI:new()
    self.buttons = {}
end

function ButtonUI:createButton(id, x, y, w, h, wake)
    self.buttons[id] = {
        x = x or 0,
        y = y or 0,
        width = w or 0,
        height = h or 0,
        wake = wake,
        hovered = false
    }
end

function ButtonUI:editButton(id, x, y, w, h, wake)
        self.buttons[id] = {
            x = x or self.buttons[id].x,
            y = y or self.buttons[id].y,
            width = w or self.buttons[id].width,
            height = h or self.buttons[id].height,
            wake = wake,
            hovered = self.buttons[id].hovered
        }
end

function ButtonUI:refresh()
    for _, obj in pairs(self.buttons) do
        obj.x = 0
        obj.y = 0
        obj.width = 0
        obj.height = 0
        obj.wake = false
    end
end

function ButtonUI:update(dt)
    mx, my = love.mouse.getPosition()

    for _, obj in pairs(self.buttons) do
        obj.hovered = false

        if mx >= obj.x and mx <= obj.x + obj.width and my >= obj.y and my <= obj.y + obj.height then
            obj.hovered = true
        end
    end
end

function ButtonUI:isHovered(id)
    return self.buttons[id].hovered  
end

function ButtonUI:draw()
    love.graphics.setColor(0, 1, 0)
    for id, obj in pairs(self.buttons) do
        if obj.wake then
            love.graphics.rectangle("line", obj.x, obj.y, obj.width, obj.height)
            love.graphics.print("ID: " .. id, obj.x, obj.y)
            love.graphics.print("Hovered: " .. tostring(obj.hovered), obj.x, obj.y + obj.height/2)
        end
    end
    love.graphics.setColor(1, 1, 1)
end